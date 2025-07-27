#!/usr/bin/env bash
set -euo pipefail

# DockerHub username
DOCKERHUB_USER="sahilc08"
IMAGE="$DOCKERHUB_USER/myapp:latest"

echo "🔧 Building Docker image..."
docker build -t $IMAGE .

echo "📤 Pushing image to DockerHub..."
docker push $IMAGE

echo "✅ Done! Image pushed as $IMAGE"

