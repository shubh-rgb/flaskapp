#!/bin/bash

# Set variables
DOCKER_USERNAME="shubh301"
DOCKER_PASSWORD="***********"
IMAGE_NAME_APP1="app1"
IMAGE_NAME_APP2="app2"
NAMESPACE="coding-sap"

# Log in to Docker Hub
echo "Logging in to Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Build Docker images
echo "Building Docker images..."
docker build -t "$DOCKER_USERNAME/$IMAGE_NAME_APP1:latest" -f Dockerfile.app1 .
docker build -t "$DOCKER_USERNAME/$IMAGE_NAME_APP2:latest" -f Dockerfile.app2 .

# Push Docker images to Docker Hub
echo "Pushing Docker images to Docker Hub..."
docker push "$DOCKER_USERNAME/$IMAGE_NAME_APP1:latest"
docker push "$DOCKER_USERNAME/$IMAGE_NAME_APP2:latest"

#Assuming minikube is installed on local laptop
minikube start
minikube status

# Deploy Kubernetes resources
echo "Deploying Kubernetes resources..."
kubectl apply -f app1-deployment.yaml -n $NAMESPACE
kubectl apply -f app2-deployment.yaml -n $NAMESPACE

# Wait for pods to be ready
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=ready pod -l app=app1 -n $NAMESPACE --timeout=120s
kubectl wait --for=condition=ready pod -l app=app2 -n $NAMESPACE --timeout=120s

# Get the NodePort or ClusterIP for accessing the service
echo "Getting service details..."
APP1_SERVICE_URL=$(minikube service app1-service -n $NAMESPACE --url)
APP2_SERVICE_URL=$(minikube service app2-service -n $NAMESPACE --url)

# Fetch HTTP response from both services
echo "Fetching HTTP responses..."
APP1_RESPONSE=$(curl -s $APP1_SERVICE_URL)
APP2_RESPONSE=$(curl -s $APP2_SERVICE_URL)

# Print HTTP responses
echo "App1 Response: $APP1_RESPONSE"
echo "App2 Response: $APP2_RESPONSE"

# Done
echo "Deployment and HTTP requests completed successfully."
