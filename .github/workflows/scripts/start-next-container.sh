#!/bin/bash
set -e

cd ~/cicd-practice

echo "[INFO] Pulling and starting container: $NEXT_APP"

docker compose pull "$NEXT_APP"
docker compose --env-file .env up -d "$NEXT_APP"