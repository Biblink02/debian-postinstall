#!/usr/bin/env bash
set -e

# Install NVM
echo "Installing NVM..."
export NVM_VERSION="v0.40.3"
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash

# Load NVM into the current shell
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
else
  echo "Error: nvm.sh not found after installation."
  exit 1
fi

# Install Node.js version 24 (latest LTS major)
echo "Installing Node.js 24..."
nvm install 24

# Verify installation
echo "Node version: $(node -v)"
echo "npm version: $(npm -v)"
