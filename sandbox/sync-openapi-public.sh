#!/usr/bin/env bash
set -euo pipefail

SANDBOX_REPO="qbox/sandbox"
ENVD_REPO="qbox/envd"
LOCAL_ROOT="$(cd "$(dirname "$0")" && pwd)"

WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT

echo "[1/2] Syncing spec/openapi-public.yml from $SANDBOX_REPO as openapi.yml..."
gh api "repos/$SANDBOX_REPO/contents/spec/openapi-public.yml?ref=main" --jq '.content' | base64 -d > "$LOCAL_ROOT/openapi.yml"

echo "[2/2] Syncing envd specs from $ENVD_REPO..."
git clone --branch main --depth 1 --filter=blob:none --sparse \
    "https://github.com/$ENVD_REPO.git" "$WORK_DIR/envd"
git -C "$WORK_DIR/envd" sparse-checkout set spec

mkdir -p "$LOCAL_ROOT/envd/filesystem" "$LOCAL_ROOT/envd/process"
cp "$WORK_DIR/envd/spec/envd.yaml" "$LOCAL_ROOT/envd/envd.yaml"
cp "$WORK_DIR/envd/spec/filesystem/filesystem.proto" "$LOCAL_ROOT/envd/filesystem/filesystem.proto"
cp "$WORK_DIR/envd/spec/process/process.proto" "$LOCAL_ROOT/envd/process/process.proto"

echo "Done. Changes:"
git -C "$LOCAL_ROOT" status --short
