#!/bin/bash
CONF="/etc/nginx/conf.d/app.conf"

# 현재 사용 중인 포트 추출
if [ "$NEXT_PORT" -eq 8082 ]; then
  echo "[INFO] Switching traffic to GREEN (8082)"
  sudo sed -i 's/^.*server localhost:8081;/# server localhost:8081;/' "$CONF"
  sudo sed -i 's/^#*\s*server localhost:8082;/server localhost:8082;/' "$CONF"
else
  echo "[INFO] Switching traffic to BLUE (8081)"
  sudo sed -i 's/^\s*server localhost:8082;/# server localhost:8082;/' "$CONF"
  sudo sed -i 's/^#*\s*server localhost:8081;/server localhost:8081;/' "$CONF"
fi

echo "[INFO] Traffic switching complete"

# Nginx 설정 테스트 및 reload
echo "[INFO] Reloading Nginx with new config"
sudo nginx -t && sudo kill -HUP $(cat /var/run/nginx.pid)

