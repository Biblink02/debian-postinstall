#!/usr/bin/env bash
set -e

echo "Updating APT and installing prerequisites..."
sudo apt update
sudo apt install -y curl wget lsb-release

echo "Installing deb-get using the official method..."
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get

echo
echo "deb-get installed successfully."
echo "You can verify with: deb-get --version"
