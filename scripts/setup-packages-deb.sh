#!/usr/bin/env bash
set -e
command -v deb-get >/dev/null || exit 0
while read -r p; do
    [[ -z "$p" || "$p" =~ ^# ]] && continue
    ask "Install $p?" && deb-get install -y "$p"
done < ../packages/deb-get.txt
