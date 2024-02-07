#!/bin/bash
set -e # Stop script execution on any error

# Replace these variables according to your project
PROJECT_ID="globalcloud-385321"
REGION="us-central1"
IMAGE_NAME="my-java-app"
SERVICE_NAME="my-java-app-service"
IMAGE_TAG="gcr.io/$PROJECT_ID/$IMAGE_NAME:latest"

# Step 1: Delete the Cloud Run service
echo "Deleting Cloud Run service $SERVICE_NAME..."
gcloud run services delete $SERVICE_NAME --platform managed --region $REGION --quiet

# Step 2: Delete the Docker image from GCR
echo "Deleting Docker image $IMAGE_TAG from GCR..."
gcloud container images delete $IMAGE_TAG --quiet

echo "Resources deleted successfully."
