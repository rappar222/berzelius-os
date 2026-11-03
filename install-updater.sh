#!/usr/bin/env bash
set -e

# Ensure root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: curl -sL https://raw.githubusercontent.com/rappar222/berzelius-os/main/install-updater.sh | sudo bash"
    exit 1
fi

echo "🧪 Installing BerzeliusOS Updater command (/usr/local/bin/berzelius-update)..."

mkdir -p /usr/local/bin
curl -sL https://raw.githubusercontent.com/rappar222/berzelius-os/main/airootfs/usr/local/bin/berzelius-update -o /usr/local/bin/berzelius-update
chmod +x /usr/local/bin/berzelius-update

echo "✅ /usr/local/bin/berzelius-update installed successfully!"
echo "Executing berzelius-update now..."
/usr/local/bin/berzelius-update "$@"
