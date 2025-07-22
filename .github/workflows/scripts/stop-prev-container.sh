#!/bin/bash
set -e

cd ./cicd-practice
source ../.deploy-info.env

echo "[INFO] Stopping previous container..."

if [ "$ACTIVE_PORT" = "8081" ]; then
  docker stop spring-blue && docker rm spring-blue
else
  docker stop spring-green && docker rm spring-green
fi

echo "[INFO] Previous container stopped"
