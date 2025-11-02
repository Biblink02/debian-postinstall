#!/usr/bin/env bash
set -e

INSTALL_DIR="$HOME/.local/jetbrains-toolbox"
TMP_DIR="/tmp/jbtb"
DESKTOP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$DESKTOP_DIR/jetbrains-toolbox.desktop"

# Download latest release URL
echo "Fetching latest JetBrains Toolbox release..."
URL=$(curl -fsSL 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' | grep -Pio '"linux":\{"link":"\K[^"]+')

# Clean up and prepare
rm -rf "$TMP_DIR" "$INSTALL_DIR"
mkdir -p "$TMP_DIR" "$INSTALL_DIR"

# Download and extract
echo "Downloading Toolbox..."
curl -fsSL "$URL" | tar -xz -C "$INSTALL_DIR" --strip-components=1

# Create desktop entry
mkdir -p "$DESKTOP_DIR"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=JetBrains Toolbox
Exec=$INSTALL_DIR/jetbrains-toolbox
Icon=$INSTALL_DIR/jetbrains-toolbox.svg
Type=Application
Categories=Development;IDE;
EOF

chmod +x "$INSTALL_DIR/jetbrains-toolbox"
update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true

echo "JetBrains Toolbox installed successfully."
echo "You can start it with: $INSTALL_DIR/jetbrains-toolbox"
