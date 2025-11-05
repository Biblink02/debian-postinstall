#!/usr/bin/env bash
set -e
source ./utils.sh

for f in ../configs/*; do
    merge_block "$f" "$HOME/.${f##*/}"
done

command -v git-credential-oauth >/dev/null && git credential-oauth configure || true
