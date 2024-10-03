#!/bin/bash

# Change to the app directory

# Authenticate Docker to ECR
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 950196620421.dkr.ecr.us-east-1.amazonaws.com/python:latest

# Pull the Docker image
sudo docker pull 950196620421.dkr.ecr.us-east-1.amazonaws.com/python:latest

# Stop and remove any existing container
if [ "$(sudo docker ps -q -f name=my-flask-app)" ]; then
    sudo docker stop my-flask-app
    sudo docker rm my-flask-app
fi

# Run the Docker container
sudo docker run -d -p 5000:5000 --name my-flask-app 950196620421.dkr.ecr.us-east-1.amazonaws.com/python:latest
