#!/bin/bash
# ----------------------------------------
# Script para buildar e rodar o MinIO via Docker
# Se o container já existir, apenas o inicia
# ----------------------------------------

set -e

IMAGE_NAME="minio-gps-dev"
CONTAINER_NAME="minio"
DATA_DIR="$HOME/minio/data"
LOG_DIR="$HOME/minio/var/log"
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
    echo "O container já existe."
    if container_rodando; then
        echo "O container já está em execução."
    else
        echo "Iniciando container "
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
