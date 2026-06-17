#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="mk3"
REMOTE_USER="root"
REMOTE_DIR="/root/services/barwuerfeln.de"

# Always sync the barWuerfeln-web root, regardless of where this script is called from.
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Run from inside the repo root and use a relative source ("./"). macOS's bundled
# openrsync fails to lstat an absolute local source when pushing to a remote
# destination ("(l)stat: No such file or directory" / "Transfer starting: 0 files");
# a relative source avoids that bug.
cd "${REPO_ROOT}"

echo "==> Syncing ${REPO_ROOT} to ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR} ..."
rsync -ravz --delete \
  --exclude .venv/ \
  --exclude documents/progress/ \
  --exclude resources/app-store-page/ \
  --exclude __pycache__/ \
  --exclude "*.pyc" \
  --exclude .git/ \
  ./ "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}/"

echo "==> Deploying on remote..."
ssh "${REMOTE_USER}@${REMOTE_HOST}" "
  cd ${REMOTE_DIR}
  docker-compose down
  docker-compose up --build -d
"

echo "==> Done. Server is live at https://barwuerfeln.de"
