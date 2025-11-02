#!/usr/bin/env bash
set -e

CONFIG_DIR="configs"
HOME_DIR="$HOME"

echo "Applying user configuration files from $CONFIG_DIR..."

# Function to append lines from source config to destination file (idempotent)
append_config() {
    local src="$1"
    local dest="$2"

    if [ ! -f "$src" ]; then
        echo "Skipping missing config: $src"
        return
    fi

    mkdir -p "$(dirname "$dest")"
    touch "$dest"

    echo "Merging $(basename "$src") → $(basename "$dest")"
    while IFS= read -r line; do
        # Skip empty lines or comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        # Append only if not already present
        grep -Fxq "$line" "$dest" || echo "$line" >> "$dest"
    done < "$src"
}

# Iterate over all files in configs/
for cfg_file in "$CONFIG_DIR"/*; do
    [ -f "$cfg_file" ] || continue
    base_name="$(basename "$cfg_file")"
    dest_file="$HOME_DIR/.${base_name}"
    append_config "$cfg_file" "$dest_file"
done

echo "Base configs applied."

# --- Git Credential OAuth configuration ---
if command -v git-credential-oauth >/dev/null 2>&1; then
    echo "Configuring git-credential-oauth..."
    git credential-oauth configure || true
else
    echo "git-credential-oauth not installed, skipping configuration."
fi

echo
echo "✅ User configuration setup completed."
