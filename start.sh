#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/Biblink02/debian-postinstall.git"
TMP="$(mktemp -d)"

cleanup() { rm -rf "$TMP"; }
trap cleanup EXIT

git clone --depth=1 "$REPO_URL" "$TMP" >/dev/null
cd "$TMP/scripts"
AUTO=${AUTO:-1} bash install.sh
