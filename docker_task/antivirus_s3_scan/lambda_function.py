import boto3
import os.path
import botocore
import json
from subprocess import run
from aws_lambda_powertools import Logger
import random
import urllib.parse

logger = Logger()
s3 = boto3.client("s3")
sqs = boto3.client('sqs')
sqs_url = os.environ['SQS_URL']

CLEAN = "CLEAN"
INFECTED = "INFECTED"
UNSCANNED = "UNSCANNED"
MAX_BYTES = 4000000000

def download_file(bucket_name, file_name):
    """Download file from S3 to /tmp. If file does not exist in S3, we will get error."""
    download_dir = "/tmp"
    short_local_file_name = os.path.basename(file_name)
    local_path = f"{download_dir}/{short_local_file_name}"
    try:
        with open(local_path, 'wb') as f:
            s3.download_fileobj(bucket_name, file_name, f)
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "404":
            raise Exception("The object does not exist on s3.")
    return local_path

def scan(path):
    """Scan downloaded file and get scan status."""
    command = [
        "clamscan",
        "-v",
        "--stdout",
        f"--max-filesize={MAX_BYTES}",
        f"--max-scansize={MAX_BYTES}",
        "-r",
        f"{path}"
    ]
    scan_summary = run(command, capture_output=True)
    returncode = scan_summary.returncode
    status = ""
    if scan_summary.returncode == 0:
        status = CLEAN
    elif scan_summary.returncode == 1:
        status = INFECTED
    else:
        scan_summary.stderr.decode()
        raise Exception(f"[ERROR]: Unexpected exit code of command 'clamscan -v --stdout --max-filesize={MAX_BYTES} --max-scansize={MAX_BYTES} -r {path}'")
    return status

def send_sqs_message(message, sqs_url):
    """Send message about infecrted file to S3."""
    try:
        sqs.send_message(
            QueueUrl = sqs_url,
            MessageBody = message
        )
        logger.info(f"Message {message} sent to SQS.")  
    except botocore.exceptions.ClientError as err:
        raise Exception('[ERROR]:'.format(err.response['Error']['Message']))

def summary_message(bucket_name, file_name, scan_result):
    """Generate summary message for SQS."""
    summary = {
        "taskName": "AV_SCAN",
        "payload": {
            "source": "serverless-clamscan",
            "bucketName": bucket_name,
            "bucketKey": file_name,
            "scanResult": scan_result,
            "taskName": "AV_SCAN",
            "message": f"File {bucket_name}/{file_name} is {scan_result}."
        },
        "messageIdentifier": random.randint(100000, 1000000)
    }
    return json.dumps(summary)

def object_tagging (bucket_name, file_name, scan_result):
    """Tag S3 object."""
    s3.put_object_tagging(
    Bucket = bucket_name,
    Key = file_name,    
    Tagging={
        'TagSet': [
            {
                'Key': 'status',
                'Value': scan_result
            },
        ]
    }
)

def delete_infection(bucket_name, file_name):
    """Delete infected file from S3."""
    s3.delete_object(Bucket = bucket_name, Key = file_name)
    logger.info("File deleted successfully.")

def lambda_handler(event, context):
    """Download file from S3, scan it via clamav. 
    If file clean then 'return 0', otherwise delete it from S3 and send message to SQS."""
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    logger.info(f"Bucketname: {bucket_name}")
    file_name = event['Records'][0]['s3']['object']['key']
    decoded_file_name = urllib.parse.unquote_plus(file_name)
    logger.info(f"Object key: {decoded_file_name}")
    object_tagging (bucket_name, decoded_file_name, UNSCANNED)
    local_full_path = download_file(bucket_name, decoded_file_name)
    logger.info(f"File download ended: {local_full_path}")

    scan_result = scan(local_full_path) 
    object_tagging (bucket_name, decoded_file_name, scan_result)
    logger.info(f"File {bucket_name}/{decoded_file_name} is {scan_result}.")

    os.remove(local_full_path)
    sqs_message = summary_message(bucket_name, decoded_file_name, scan_result)
    
    if scan_result == INFECTED :
        delete_infection(bucket_name, file_name)
    
    send_sqs_message(sqs_message, sqs_url)

    return 0
