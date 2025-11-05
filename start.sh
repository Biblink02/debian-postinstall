#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Biblink02/debian-postinstall.git"
TMP="$(mktemp -d)"

git clone --depth=1 "$REPO_URL" "$TMP" >/dev/null 2>&1
cd "$TMP/scripts"
AUTO=${AUTO:-1} bash install.sh
rm -rf "$TMP"
