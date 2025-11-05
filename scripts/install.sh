#!/usr/bin/env bash
set -e
source ./utils.sh

sudo apt-get update -y && sudo apt-get upgrade -y

bash ./setup-packages-apt.sh
bash ./applications/deb-get-install.sh || true
bash ./setup-packages-deb.sh
bash ./setup-configs.sh
bash ./setup-secrets.sh
