#!/usr/bin/env bash
set -e

# Only run if deb-get is available
if ! command -v deb-get >/dev/null 2>&1; then
    echo "deb-get is not installed, skipping deb-get package installation."
    exit 0
fi

if [ -f ../packages/deb-get.txt ]; then
    echo "Installing deb-get packages..."
    while read -r pkg; do
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        read -rp "Install ${pkg}? (y/n): " confirm
        case "$confirm" in
            [Yy]*) deb-get install -y "$pkg" ;;
        esac
    done < ../packages/deb-get.txt
else
    echo "No packages/deb-get.txt found"
fi
