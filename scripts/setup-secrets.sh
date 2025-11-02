#!/usr/bin/env bash
set -e

CONFIG_DIR="configs"
SECRETS_LIST="$CONFIG_DIR/secrets"
SECRETS_FILE="$HOME/.secrets"

echo "Setting up user secrets from $SECRETS_LIST..."

# Ensure the secrets list exists
if [ ! -f "$SECRETS_LIST" ]; then
    echo "Error: $SECRETS_LIST not found."
    echo "Create it with one variable name per line, e.g.:"
    echo "DEBGET_TOKEN"
    echo "GITHUB_TOKEN"
    exit 1
fi

# Ensure the destination file exists and has correct permissions
if [ ! -f "$SECRETS_FILE" ]; then
    echo "Creating $SECRETS_FILE..."
    touch "$SECRETS_FILE"
fi
chmod 600 "$SECRETS_FILE"

# Read each variable name from configs/secrets
while IFS= read -r VAR_NAME; do
    # Skip empty lines or comments
    [[ -z "$VAR_NAME" || "$VAR_NAME" =~ ^# ]] && continue

    # Check if variable already defined
    if grep -q "^export ${VAR_NAME}=" "$SECRETS_FILE" 2>/dev/null; then
        echo "${VAR_NAME} already exists in ${SECRETS_FILE}."
        continue
    fi

    # Ask user whether to add this secret
    read -rp "Do you want to add ${VAR_NAME}? (y/n): " confirm
    case "$confirm" in
        [Yy]*)
            read -rsp "Enter value for ${VAR_NAME} (input hidden): " VALUE
            echo
            if [ -n "$VALUE" ]; then
                echo "export ${VAR_NAME}=\"${VALUE}\"" >> "$SECRETS_FILE"
                echo "${VAR_NAME} added to ${SECRETS_FILE}."
            else
                echo "No value entered for ${VAR_NAME}, skipping."
            fi
            ;;
        *)
            echo "Skipping ${VAR_NAME}."
            ;;
    esac
done < "$SECRETS_LIST"

chmod 600 "$SECRETS_FILE"

echo
echo "Secrets setup completed."
echo
echo "Make sure your ~/.profile contains this line:"
echo '[ -f "$HOME/.secrets" ] && . "$HOME/.secrets"'
