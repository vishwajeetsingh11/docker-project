#!/bin/bash

# Set variables
ECR_IMAGE="950196620421.dkr.ecr.us-east-1.amazonaws.com/python:latest"
CONTAINER_NAME="my-flask-app"

# Authenticate Docker to ECR
aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin ${ECR_IMAGE}

# Pull the Docker image
sudo docker pull ${ECR_IMAGE}

# Stop and remove any existing container
if [ "$(sudo docker ps -q -f name=${CONTAINER_NAME})" ]; then
    echo "Stopping existing container ${CONTAINER_NAME}..."
    sudo docker stop ${CONTAINER_NAME}
fi

# Remove the container regardless of whether it was running or not
if [ "$(sudo docker ps -aq -f name=${CONTAINER_NAME})" ]; then
    echo "Removing container ${CONTAINER_NAME}..."
    sudo docker rm ${CONTAINER_NAME}
fi

# Run the Docker container
echo "Starting new container ${CONTAINER_NAME}..."
sudo docker run -d -p 5000:5000 --name ${CONTAINER_NAME} ${ECR_IMAGE}
