#!/usr/bin/env bash
set -e

echo "Starting Debian post-install setup..."

# Update and upgrade system
sudo apt-get update && sudo apt-get upgrade -y

# Load helper functions if present
if [ -f ./utils.sh ]; then
    source ./utils.sh
fi

# 1. Install base APT packages
if [ -f ./setup-packages-apt.sh ]; then
    echo "Installing APT packages..."
    bash ./setup-packages-apt.sh
else
    echo "setup-packages-apt.sh not found, skipping."
fi

# 2. Install applications
if [ -d ./applications ]; then
    echo "Installing custom applications..."
    for script in ./applications/*.sh; do
        app_name=$(basename "$script" | sed 's/-install\.sh$//')
        read -rp "Do you want to install ${app_name}? (y/n): " confirm
        case "$confirm" in
            [Yy]*)
                echo "Running ${app_name}-install.sh..."
                bash "$script"
                ;;
            *)
                echo "Skipping ${app_name}."
                ;;
        esac
    done
else
    echo "./applications directory not found, skipping."
fi


# 3. Apply user configuration files
if [ -f ./setup-configs.sh ]; then
    echo "Applying user configs..."
    bash ./setup-configs.sh
else
    echo "setup-configs.sh not found, skipping."
fi

# 4. Setup secrets (tokens, credentials, etc.)
if [ -f ./setup-secrets.sh ]; then
    echo "Configuring user secrets..."
    bash ./setup-secrets.sh
else
    echo "setup-secrets.sh not found, skipping."
fi

# 5. Install deb-get and related packages
if [ -f ./setup-packages-deb.sh ]; then
    echo "Installing deb-get packages..."
    bash ./setup-packages-deb.sh
else
    echo "setup-packages-deb.sh not found, skipping."
fi

echo
echo "Post-installation completed successfully."
printf "Don't forget to:\n
Install single IDE from Toolbox.\n
Run \"git-credential-oauth configure\" to configure the OAuth GitHub helper\n
Set Sublime-Text as default text editor\n
"

