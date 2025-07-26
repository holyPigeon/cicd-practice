#!/bin/bash
CONF="/etc/nginx/conf.d/app.conf"

if grep -q "^[^#]*server localhost:8081;" "$CONF"; then
  ACTIVE_PORT=8081
  NEXT_APP="spring-green"
  NEXT_PORT=8082
else
  ACTIVE_PORT=8082
  NEXT_APP="spring-blue"
  NEXT_PORT=8081
fi

echo "[INFO] ACTIVE_PORT: $ACTIVE_PORT"
echo "[INFO] NEXT_APP: $NEXT_APP"
echo "[INFO] NEXT_PORT: $NEXT_PORT"

cat <<EOF > .deploy-info.env
ACTIVE_PORT=$ACTIVE_PORT
NEXT_APP=$NEXT_APP
NEXT_PORT=$NEXT_PORT
EOF