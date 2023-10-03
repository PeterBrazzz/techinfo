FROM public.ecr.aws/lambda/python:3.8

WORKDIR /var/task

RUN yum update -y \
    && pip install --upgrade pip \
    && pip3 install --no-cache-dir awslambdaric boto3 aws-lambda-powertools \
    && pip3 install pdf2docx \
    && pip3 install opencv-python-headless
COPY lambda_function.py /var/task/lambda_function.py
ENTRYPOINT [ "/var/lang/bin/python3", "-m", "awslambdaric" ]
CMD [ "lambda_function.lambda_handler" ]