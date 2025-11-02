#!/usr/bin/env bash
set -e

echo "Starting Debian post-install setup..."

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Load helper functions (if any)
if [ -f scripts/utils.sh ]; then
    source scripts/utils.sh
fi

# 1. Install base APT packages
if [ -f scripts/setup-packages-apt.sh ]; then
    echo "Installing APT packages..."
    bash scripts/setup-packages-apt.sh
fi

# 2. Install applications (Docker, Node, Telegram, JetBrains Toolbox…)
if [ -d scripts/applications ]; then
    echo "Installing custom applications..."
    for script in scripts/applications/*.sh; do
        echo "Running $(basename "$script")..."
        bash "$script"
    done
fi

# 3. Apply user configuration files
if [ -f scripts/setup-configs.sh ]; then
    echo "Applying user configs..."
    bash scripts/setup-configs.sh
fi

# 4. Install deb-get and related packages
if [ -f scripts/setup-packages-deb.sh ]; then
    echo "Installing deb-get packages..."
    bash scripts/setup-packages-deb.sh
fi

echo
echo "✅ Post-installation completed successfully!"
