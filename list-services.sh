#!/bin/bash

# Replace these variables according to your project
PROJECT_ID=globalcloud-385321
REGION=us-central1

echo "Listing Cloud Run services in project $PROJECT_ID, region $REGION..."
gcloud run services list --platform managed --region $REGION
