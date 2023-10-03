This directory contains everything you need to build the lambda image.
Algorithm of lambda operation:
    1) Lambda triggers on uplad of an object in S3
    2) Lambda downloads this object
    3) The object in S3 is given the tag "UNSCANNED" 
    4) The object is scanned locally
    5) Depending on the scan result, the object in S3 is given the tag "CLEAN" or "INFECTED"
    6) A message is sent to SQS with the scan results.

./automation contains a buildspec file to automatically build the image during pipeline.

Necessary variables for the successful operation of the lambda:
${SQS_URL}
${DOWNLOAD_DIR}

Necessary variables for a successful build during the build stage:
${REGION_NAME}
${ECR_URI}
${REPOSITORY_URI}
${LAMBDA_IMAGE}

Terraform lambda configuration is in the ../../terraform/av_lambda/
