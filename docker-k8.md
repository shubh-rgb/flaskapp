<!-- Overview: Dockerfiles and Kubernetes
Dockerfile:
A Dockerfile is a script containing instructions to build a Docker image. It includes commands to set up the environment, install dependencies, copy application code, and specify the command to run the application.
We use a Dockerfile to build a Docker image using the docker build command.
Docker Image:
After the Docker image is built from the Dockerfile, it is pushed to a container registry Docker HUB.
The Docker image contains everything needed to run the application, including the code, runtime, libraries, and environment variables.
Kubernetes Deployment:
In a Kubernetes cluster, we don't directly use the Dockerfile. Instead, we refer to the pre-built Docker image in our Kubernetes manifest deployment-YAML files.
Kubernetes pulls the Docker image from the specified container registry and runs it inside a pod.
Workflow: Dockerfile to Kubernetes Deployment
Build the Docker Image:
First, we create a Dockerfile for our application (as we did with app1 and app2).
Then, we build the Docker image using:
docker build -t shubh301/app1:latest -f Dockerfile.app1 .
docker build -t shubh301/app2:latest -f Dockerfile.app2 .
Push the Docker Image to a Registry:
After building the image, we push it to a container registry:
docker push shubh301/app1:latest
docker push shubh301/app2:latest
 -->
