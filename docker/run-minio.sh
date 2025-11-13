#!/bin/bash
# ----------------------------------------
# Script para buildar e rodar o MinIO via Docker
# Se o container já existir, apenas o inicia
# ----------------------------------------

set -e

IMAGE_NAME="minio-custom"
CONTAINER_NAME="minio"
DATA_DIR="$HOME/minio_data"
DATA_DIR_LOG="$HOME/minio_logs"


container_existe() {
    docker ps -a --format '{{.Names}}' | grep -wq "$CONTAINER_NAME"
}

# Função para verificar se está rodando
container_rodando() {
    docker ps --format '{{.Names}}' | grep -wq "$CONTAINER_NAME"
}

# Garante que a imagem está buildada
docker build -t $IMAGE_NAME .

# Cria o diretório de dados se não existir
mkdir -p "$DATA_DIR"

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
      -v "$DATA_DIR_LOG":/var/log/minio \
      $IMAGE_NAME
fi

sleep 5

docker exec $CONTAINER_NAME /bin/sh -c "
  mc alias set local http://localhost:9000 admin admin123 && \
  mc mb local/public --ignore-existing && \
  mc anonymous set public local/public && \
  echo 'Arquivo de teste' > /data/teste-publico.txt && \
  mc cp /data/teste-publico.txt local/public/
"

echo
echo "MinIO ativo"
echo "http://localhost:9001"
echo "Bucket público: http://localhost:9000/public/"
echo "Usuário: admin | Senha: admin123"
echo "Para ver logs: docker logs -f $CONTAINER_NAME"
