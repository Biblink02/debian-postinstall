# Debian Post-Install

Automated setup script for configuring a fresh Debian system.

## Compatibility
- Tested only on Debian 13 (Trixie)
- Intended for a regular desktop environment (GNOME/KDE/XFCE)
- Not intended for Docker or headless environments
- Requires a user with sudo privileges

## Requirements
- git and curl installed
- Internet connection

## Quick Start
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/Biblink02/debian-postinstall/main/start.sh)
```

## What the script does
1. Runs system update and upgrade
2. Installs APT packages interactively
3. Installs optional custom applications interactively
4. Merges config files into $HOME
5. Handles user secrets via ~/.secrets
6. Installs deb-get packages only if deb-get is available

## APT packages (packages/apt-get.txt)
curl
git
htop
build-essential
nethogs
bluetooth
bluez
pulseaudio-module-bluetooth
libspa-0.2-bluetooth
tree
git-credential-oauth
wireguard

## deb-get packages (packages/deb-get.txt)
localsend
google-chrome-stable
discord
linuxtoys
lsd
fd
sublime-text

## Custom installers (scripts/applications/)
deb-get-install.sh         Installs deb-get
node-npm-install.sh        Installs NVM + Node.js LTS   
docker-install.sh          Installs Docker CE   
telegram-install.sh        Installs Telegram Desktop    
jetbrains-toolbox-install.sh Install Jetbrains Toolbox   

## Config files (configs/ → $HOME)
bashrc     → ~/.bashrc (merged)     
profile    → ~/.profile (merged)    
gitconfig  → ~/.gitconfig   
secrets    → variable names for ~/.secrets prompt input

## Secrets
Stored in ~/.secrets with chmod 600.
Ensure ~/.profile contains:
```bash
if [ -f ~/.secrets ]; then
    . ~/.secrets
fi
```
## Notes
- JetBrains Toolbox requires GUI
- deb-get packages are skipped automatically if deb-get isn't installed
- Script is interactive by design