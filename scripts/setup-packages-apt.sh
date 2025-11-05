#!/usr/bin/env bash
set -e

if [ -f ../packages/apt-get.txt ]; then
    echo "Installing APT packages..."
    while read -r pkg; do
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        read -rp "Install ${pkg}? (y/n): " confirm
        case "$confirm" in
            [Yy]*) sudo apt-get install -y "$pkg" ;;
        esac
    done < ../packages/apt-get.txt
else
    echo "No packages/apt-get.txt found"
fi
