#!/usr/bin/env bash
set -e

# Remove old or conflicting Docker packages
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  sudo apt-get remove -y $pkg || true
done

# Update apt and install required packages
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker’s official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker’s official repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify installation
sudo docker run --rm hello-world

# Add user to docker group
sudo groupadd docker || true
sudo usermod -aG docker "$USER"

# Fix permissions for ~/.docker if it exists
if [ -d "$HOME/.docker" ]; then
  sudo chown -R "$USER":"$USER" "$HOME/.docker"
  sudo chmod -R g+rwx "$HOME/.docker"
fi

echo
echo "Docker installation complete."
echo "You must log out and log back in (or run 'newgrp docker') for group changes to take effect."
