#!/bin/bash
set -e # Stop script execution on any error

# Replace these variables according to your project
PROJECT_ID="globalcloud-385321"
REGION="us-central1"
IMAGE_NAME="my-java-app"
SERVICE_NAME="my-java-app-service"
IMAGE_TAG="gcr.io/$PROJECT_ID/$IMAGE_NAME:latest"

# Ensure Docker is authenticated with Google Cloud
echo "Authenticating Docker with Google Cloud..."
gcloud auth configure-docker --quiet

# Step 1: Build the Maven project
echo "Building Maven project..."
mvn clean package

# Step 2: Build the Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Step 3: Tag the Docker image for Google Container Registry
echo "Tagging Docker image for GCR..."
docker tag $IMAGE_NAME $IMAGE_TAG

# Step 4: Push the Docker image to GCR
echo "Pushing Docker image to GCR..."
docker push $IMAGE_TAG

# Ensure the Cloud Run API is enabled
echo "Ensuring Cloud Run API is enabled..."
gcloud services enable run.googleapis.com --quiet

# Step 5: Deploy the Docker image to Google Cloud Run
echo "Deploying to Google Cloud Run..."
gcloud run deploy $SERVICE_NAME \
  --image $IMAGE_TAG \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --quiet

echo "Deployment completed successfully."
