#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="mk3"
REMOTE_USER="root"
REMOTE_DIR="/root/services/barwuerfeln.de"

echo "==> Syncing to ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR} ..."
rsync -ravz --delete \
  --exclude .venv/ \
  --exclude __pycache__/ \
  --exclude "*.pyc" \
  --exclude .git/ \
  ../ "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"

echo "==> Deploying on remote..."
ssh "${REMOTE_USER}@${REMOTE_HOST}" "
  cd ${REMOTE_DIR}
  docker-compose down
  docker-compose up --build -d
"

echo "==> Done. Server is live at https://barwuerfeln.de"
