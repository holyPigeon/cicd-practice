#!/bin/bash
CONF="/etc/nginx/conf.d/app.conf"

# 현재 사용 중인 포트 추출
if grep -q "server localhost:8081;" "$CONF"; then
  # 현재 blue → green 전환
  echo "[INFO] Switching traffic to BLUE (8081)"
  sudo sed -i 's/server localhost:8081;/# server localhost:8081;/g' "$CONF"
  sudo sed -i 's/# server localhost:8082;/server localhost:8082;/g' "$CONF"
  ACTIVE_PORT=8081
  NEXT_APP="spring-green"
  NEXT_PORT=8082
else
  # 현재 green → blue 전환
  echo "[INFO] Switching traffic to GREEN (8082)"
  sudo sed -i 's/server localhost:8082;/# server localhost:8082;/g' "$CONF"
  sudo sed -i 's/# server localhost:8081;/server localhost:8081;/g' "$CONF"
  ACTIVE_PORT=8082
  NEXT_APP="spring-blue"
  NEXT_PORT=8081
fi

echo "[INFO] Traffic switching complete"

# Nginx 설정 테스트 및 reload
echo "[INFO] Reloading Nginx with new config"
sudo nginx -t && sudo nginx -s reload

# 환경 변수를 파일로 저장
cat <<EOF > .deploy-info.env
ACTIVE_PORT=$ACTIVE_PORT
NEXT_APP=$NEXT_APP
NEXT_PORT=$NEXT_PORT
EOF