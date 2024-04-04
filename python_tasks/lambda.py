import sys
import boto3
from botocore.exceptions import ClientError
import json

ami_region = 'eu-west-2'
asg = boto3.client("autoscaling")
ec2 = boto3.client('ec2', region_name=ami_region)

def get_ami_id ():
    try:
        get_images = ec2.describe_images(
                Filters=[
                {'Name': 'tag:Name', 'Values': ['Teamcity']},
            ]
        )

        # Collect Images Found
        images = get_images['Images']

        # If no images found, send a failed response.
        if len(images) == 0:
            print(f'No images found')

        # Sort Images by name
        sorted_images = sorted(images, key=lambda k: k['CreationDate'])

        # Since the Image names include a timestamp, the most recent AMI will
        # be the last element
        latest_image = sorted_images[-1]
        ami = latest_image["ImageId"]
        # snapshot = latest_image["BlockDeviceMappings"][0]["Ebs"]["SnapshotId"]
        print(f'Latest image is {latest_image["Name"]} and ID {ami}')
        return ami
    except ClientError as e:
        print(f'Recieved client error {e}')

def get_launch_template_id ():
    get_asg = asg.describe_auto_scaling_groups(
        AutoScalingGroupNames=['TeamCity']
    )
    template_id = get_asg['AutoScalingGroups'][0]['LaunchTemplate']['LaunchTemplateId']
    print(f'launch template id: {template_id}')
    return template_id

def update_current_launch_template_ami(ami, launch_template_id):
    response = ec2.create_launch_template_version(
        LaunchTemplateId=launch_template_id,
        SourceVersion="$Latest",
        VersionDescription="Latest-AMI",
        LaunchTemplateData={
            "ImageId": ami
     }
    )
    print(f"New launch template created with AMI {ami}")


def lambda_handler(event, context):
    ami = get_ami_id()
    template_id = get_launch_template_id()
    update_current_launch_template_ami (ami, template_id)
