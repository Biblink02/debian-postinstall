#!/usr/bin/env bash
set -e
source ./utils.sh

S="$HOME/.secrets"
touch "$S"; chmod 600 "$S"

while read -r v; do
    [[ -z "$v" || "$v" =~ ^# ]] && continue
    grep -q "^export $v=" "$S" && continue
    if ask "Add $v?"; then
        read -rsp "Value for $v: " val; echo
        echo "export $v=\"$val\"" >> "$S"
    fi
done < ../configs/secrets

chmod 600 "$S"
