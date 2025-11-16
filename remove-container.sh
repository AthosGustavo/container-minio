#!/bin/bash

# ----------------------------------------
# Script remover todas as dependências relacionadas ao container e a imagem
# ----------------------------------------

IMAGE_NAME="image-minio-ras-dev"
CONTAINER_NAME="container-minio-ras-dev"
APP_DIR="$HOME/minio-dev"


container_existe() {
    docker ps -a --format '{{.Names}}' | grep -wq "$CONTAINER_NAME"
}

container_rodando() {
    docker ps --format '{{.Names}}' | grep -wq "$CONTAINER_NAME"
}

if container_existe; then
  
  if container_rodando; then
    docker stop "$CONTAINER_NAME"
  fi

  docker rm "$CONTAINER_NAME"
  docker rmi "$IMAGE_NAME" || echo "Imagem já removida ou não encontrada."
  sudo rm -rf "$APP_DIR"
  
  echo "Container e imagem removidos e diretórios limpos com sucesso"

else
  echo "O container não existe."
fi

#Se a imagem já tenha sido removida, docker rmi "$IMAGE_NAME" retornará um código diferente de 0
#que significa sucesso para o batch
#Qualquer código retornado diferente de 0,resultará no encerramento do script.