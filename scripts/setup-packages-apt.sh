#!/usr/bin/env bash
set -e
while read -r p; do
    [[ -z "$p" || "$p" =~ ^# ]] && continue
    ask "Install $p?" && sudo apt-get install -y "$p"
done < ../packages/apt-get.txt
