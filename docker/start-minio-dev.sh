#!/bin/sh
set -e

minio server /data --console-address ":9001" &
sleep 5


# Configura usuário
mc alias set servidor-ras-52 http://localhost:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
mc admin user add servidor-ras-52 ras gpsminio52
mc admin policy set servidor-ras-52 readwrite user=ras
