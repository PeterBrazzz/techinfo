The task was to download the app and run it on the localhost. Then create a container as small as possible

You can build an image and run containers with this app by running this commands:

For Dockerfile (image size 1.2Gb): 

    - docker build -t IMAGE_NAME --file Dockerfile .
      docker run IMAGE_NAME

For Dockerfile.small (image size 25MB):

    - docker build -t IMAGE_NAME --file Dockerfile.small .
      docker run IMAGE_NAME


The app was downloaded from this repository:
https://github.com/aditya-sridhar/simple-reactjs-app
