#!/usr/bin/env bash
set -e

# Install APT packages
if [ -f ../packages/apt-get.txt ]; then
    echo "Installing APT packages..."
    while read -r pkg; do
        [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
        sudo apt-get install -y "$pkg"
    done < ../packages/apt-get.txt
else
    echo "No packages/apt-get.txt found"
fi