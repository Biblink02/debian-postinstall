#!/usr/bin/env bash
set -e

echo "Starting Debian post-install setup..."

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Load helper functions if present
if [ -f scripts/utils.sh ]; then
    source scripts/utils.sh
fi

# 1. Install base APT packages
if [ -f scripts/setup-packages-apt.sh ]; then
    echo "Installing APT packages..."
    bash scripts/setup-packages-apt.sh
else
    echo "setup-packages-apt.sh not found, skipping."
fi

# 2. Install applications
if [ -d scripts/applications ]; then
    echo "Installing custom applications..."
    for script in scripts/applications/*.sh; do
        echo "Running $(basename "$script")..."
        bash "$script"
    done
else
    echo "scripts/applications directory not found, skipping."
fi

# 3. Apply user configuration files
if [ -f scripts/setup-configs.sh ]; then
    echo "Applying user configs..."
    bash scripts/setup-configs.sh
else
    echo "setup-configs.sh not found, skipping."
fi

# 4. Setup secrets (tokens, credentials, etc.)
if [ -f scripts/setup-secrets.sh ]; then
    echo "Configuring user secrets..."
    bash scripts/setup-secrets.sh
else
    echo "setup-secrets.sh not found, skipping."
fi

# 5. Install deb-get and related packages
if [ -f scripts/setup-packages-deb.sh ]; then
    echo "Installing deb-get packages..."
    bash scripts/setup-packages-deb.sh
else
    echo "setup-packages-deb.sh not found, skipping."
fi

echo
echo "Post-installation completed successfully."
echo "Don't forget to install single IDE."
