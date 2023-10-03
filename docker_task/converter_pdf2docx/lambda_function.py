import boto3
import os
import botocore
import logging
import json
from aws_lambda_powertools import Logger 
import urllib.parse
from pdf2docx import Converter
 

logger = Logger()
s3 = boto3.client("s3")
sqs = boto3.client('sqs')
sqs_url = os.environ['SQS_URL']
download_dir = os.environ['DOWNLOAD_DIR']

def extension_check (object_key):
    get_extention = os.path.splitext(object_key)[1]
    if not get_extention == ".pdf":
        return "FAILED"
    else:
        return "SUCCESS"

def download_file(bucket_name, file_name):
    """Download file from S3 to /tmp. If file does not exist in S3, we will get error."""
  
    short_local_file_name = os.path.basename(file_name)
    local_obj_path = f"{download_dir}/{short_local_file_name}"
    try:
        logger.info("Downloading file from S3...")
        with open(local_obj_path, 'wb') as f:
            s3.download_fileobj(bucket_name, file_name, f)
    except botocore.exceptions.ClientError as e:
        if e.response['Error']['Code'] == "404":
            raise Exception("The object does not exist on s3.")
    return local_obj_path

def convert_pdf_to_docx (local_pdf_path):
    """Convert file from *.pdf to *.docx"""

    status = ""
    try:
        new_docx_file = os.path.splitext(local_pdf_path)[0]+'.docx'
        cv = Converter(local_pdf_path)
        convert = cv.convert(f'{new_docx_file}') 
        cv.close()
        status = "CONVERTED"
    except Exception as error:
        print("An exception occurred:", error)
        status = "FAILED"
    return new_docx_file, status

def upload_file(loc_docx_path, bucket, bucket_docx_path):
    status = ""
    try:
        uploading = s3.upload_file(loc_docx_path, bucket, bucket_docx_path)
        status = "SUCCESS"
    except ClientError as e:
        logging.error(e)
        status = "FAILED"
    return status

def send_sqs_message(message, sqs_url):
    """Send message about converted file to S3."""
    try:
        sqs.send_message(
            QueueUrl = sqs_url,
            MessageBody = message
        )
        logger.info(f"Message {message} sent to SQS.")  
    except botocore.exceptions.ClientError as err:
        raise Exception('[ERROR]:'.format(err.response['Error']['Message']))

def summary_message(bucket_name, extension_check_status, bucket_docx_path, convert_status, upload_status, projectId, projectSourceId, answerSourceId, teamId, messageIdentifier):
    """Generate summary message for SQS."""
    summary = {
        "taskName": "DOCUMENT_CONVERSION_COMPLETED",
        "payload": {
            "source": "serverless-pdf-convert",
            "bucketName": bucket_name,
            "extension": extension_check_status,
            "bucketKeyDOCX": bucket_docx_path,
            "convertResult": convert_status,
            "uploadResult": upload_status,
            "taskName": "DOCUMENT_CONVERSION_COMPLETED",
            "projectId": projectId,
            "answerSourceId": answerSourceId,
            "projectSourceId": projectSourceId,
            "teamId": teamId
        },
        "messageIdentifier": messageIdentifier
    }
    return json.dumps(summary)

def lambda_handler(event, context):

    message_body = event['Records'][0]['body']
    json_event = json.loads(message_body)
    try:
        bucket_name = json_event['payload']['bucket']
        logger.info(f"Bucketname: {bucket_name}")
        object_key = json_event['payload']['bucketKey']
        object_key = urllib.parse.unquote_plus(object_key)
        logger.info(f"Object Key: {object_key}")
        projectId = json_event['payload']['projectId']
        projectSourceId = json_event['payload']['projectSourceId']
        answerSourceId = json_event['payload']['answerSourceId']
        teamId = json_event['payload']['teamId']
        messageIdentifier = json_event['messageIdentifier']
    except Exception:
        exit(print("[ERROR]: Incorrect message attributes."))
    
    extension_check_status = extension_check(object_key)
    logger.info(f"Extension check status: {extension_check_status}")

    if extension_check_status == "SUCCESS":
        loc_pdf_path = download_file(bucket_name, object_key) 
        loc_docx_path, convert_status = convert_pdf_to_docx(loc_pdf_path)
        logger.info(f"Convert_status: {convert_status}")
        bucket_docx_key = os.path.splitext(object_key)[0]+'.docx'

        if convert_status == "CONVERTED":
            logger.info(f"This is new path to docx file:{bucket_docx_key}")
            upload_status = upload_file(loc_docx_path, bucket_name, bucket_docx_key)
        else:
            upload_status = "FAILED"
        logger.info(f"Upload status: {upload_status}")

    else:
        bucket_docx_key = "NONE"
        convert_status = "FAILED"
        upload_status = "FAILED"

    sqs_message = summary_message(bucket_name, extension_check_status, bucket_docx_key, convert_status, upload_status, projectId, projectSourceId, answerSourceId, teamId, messageIdentifier)
    logger.info(sqs_message)
    send_sqs_message(sqs_message, sqs_url)

    return 0
