#!/bin/bash
# ----------------------------------------
# Script para limpar container e imagem do MinIO
# ----------------------------------------

set -e

IMAGE_NAME="minio-gps-dev"
CONTAINER_NAME="minio"
DATA_DIR="$HOME/minio_data"
DATA_DIR_LOG="$HOME/minio_logs"

docker stop "$CONTAINER_NAME" || true
docker rm "$CONTAINER_NAME" || true
docker rmi "$IMAGE_NAME" || true
rm -rf "$DATA_DIR" "$DATA_DIR_LOG"

