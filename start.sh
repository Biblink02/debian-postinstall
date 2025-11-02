#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/user/repo.git"
TMP_DIR="$(mktemp -d -t debian-setup-XXXX)"

echo "Cloning repository into $TMP_DIR..."
git clone --depth=1 "$REPO_URL" "$TMP_DIR" >/dev/null

echo "Running install.sh..."
bash "$TMP_DIR/scripts/install.sh"

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "Installation completed successfully."
