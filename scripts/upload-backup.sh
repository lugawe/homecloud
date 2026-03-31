#!/usr/bin/env bash
set -euo pipefail

SRC=".backups"

kubectl port-forward -n storage svc/rustfs 3333:9000 &>/dev/null &
PF_PID=$!
trap 'rc=$?; kill "$PF_PID" 2>/dev/null; wait "$PF_PID" 2>/dev/null || true; exit $rc' EXIT

echo "Waiting for port 3333..."
deadline=$(($(date +%s) + 15))
until nc -z localhost 3333 2>/dev/null; do
	if (($(date +%s) >= deadline)); then
		echo "Timeout waiting for port 3333." >&2
		exit 1
	fi
	sleep 1
done

echo "Uploading backup..."

rclone --progress copy "$SRC" rustfs:longhorn-backups

echo "Backup uploaded from $SRC."
