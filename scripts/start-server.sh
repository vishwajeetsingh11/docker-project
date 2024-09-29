#!/bin/bash

# Change to the app directory
cd /home/ec2-user/my-flask-app

# Build the Docker image
sudo docker build -t my-flask-app .

# Run the Docker container
sudo docker run -d -p 5000:5000 --name my-flask-app my-flask-app

