#!/bin/bash
# ----------------------------------------
# Script para buildar e rodar o MinIO via Docker
# Se o container já existir, apenas o inicia
# ----------------------------------------

set -e

IMAGE_NAME="image-minio-ras-dev"
CONTAINER_NAME="container-minio-ras-dev"
APP_DIR="$HOME/minio-dev"
DATA_DIR="$APP_DIR/data"
LOG_DIR="$APP_DIR/var/log"
LOG_FILE="$LOG_DIR/minio.log"

mkdir -p "$DATA_DIR" "$LOG_DIR"


container_existe() {
    docker ps -a --format '{{.Names}}' | grep -wq "$CONTAINER_NAME"
}

# Função para verificar se está rodando
container_rodando() {
    docker ps --format '{{.Names}}' | grep -wq "$CONTAINER_NAME"
}

# Garante que a imagem está buildada
docker build -t $IMAGE_NAME .


if container_existe; then
    if container_rodando; then
        echo "O container já existe e está em execução."
    else
        echo "O container já existe e será iniciado."
        docker start "$CONTAINER_NAME"
    fi
else
    docker run -d \
      --name $CONTAINER_NAME \
      -p 9000:9000 \
      -p 9001:9001 \
      -v "$DATA_DIR":/data \
      -v "$LOG_DIR":/var/log/minio \
      $IMAGE_NAME
fi

sleep 5

echo "MinIO ativo"
echo "Para ver logs: docker logs -f $CONTAINER_NAME"

# Salvar logs em arquivo no host
docker logs "$CONTAINER_NAME" >> "$LOG_FILE" 2>&1 &
