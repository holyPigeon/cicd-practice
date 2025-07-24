#!/bin/bash
echo "[INFO] Checking if $NEXT_APP is healthy on port $NEXT_PORT..."

for i in {1..5}; do
  STATUS=$(curl -s http://localhost:$NEXT_PORT/actuator/health | grep '"status":"UP"' || true)
  if [ -n "$STATUS" ]; then
    echo "[SUCCESS] $NEXT_APP running"
    exit 0
  fi
  echo "[WARN] $NEXT_APP not ready, retrying ($i)..."
  sleep 2
done

echo "[ERROR] $NEXT_APP run failed, deploy stopped"
exit 1
