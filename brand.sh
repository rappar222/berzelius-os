#!/usr/bin/env bash
set -e

# Ensure script is run with root permissions
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root: sudo bash brand.sh"
    exit 1
fi

echo "🧪 Applying BerzeliusOS Branding & Fastfetch setup..."

# 1. Update /etc/os-release
cat << 'EOF' > /etc/os-release
NAME="BerzeliusOS"
PRETTY_NAME="BerzeliusOS Linux (Tall-Form Beaker Edition)"
ID=berzeliusos
ID_LIKE=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;56;189;248"
HOME_URL="https://github.com/rappar222/berzelius-os"
DOCUMENTATION_URL="https://github.com/rappar222/berzelius-os"
BUG_REPORT_URL="https://github.com/rappar222/berzelius-os/issues"
LOGO=berzelius-beaker
EOF

# 2. Setup fastfetch system-wide directories
mkdir -p /etc/fastfetch /etc/xdg/fastfetch

# 3. Create beaker ASCII logo
cat << 'EOF' > /etc/fastfetch/berzelius-logo.txt
      .---.
     /     \
    |  ___  |
   /| (   ) |\
  / |  \_/  | \
 |  |_______|  |
 |  | 400ml |  |
 |  |       |  |
 |  |-300- -|  |
 |  |~ ~ ~ ~|  |
 |  |~200~ ~|  |
 |  |~ ~ ~ ~|  |
 |  |~100~ ~|  |
 |  \_______/  |
  \___________/
EOF
cp /etc/fastfetch/berzelius-logo.txt /etc/xdg/fastfetch/berzelius-logo.txt

# 4. Create fastfetch config
cat << 'EOF' > /etc/fastfetch/config.jsonc
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "file",
    "source": "/etc/fastfetch/berzelius-logo.txt",
    "color": {
      "1": "cyan"
    },
    "padding": {
      "top": 1,
      "left": 2,
      "right": 3
    }
  },
  "display": {
    "separator": " 🧪 "
  },
  "modules": [
    "title",
    "separator",
    {
      "type": "os",
      "key": "Distro",
      "format": "BerzeliusOS Linux (Tall-Form Beaker Edition)"
    },
    {
      "type": "host",
      "key": "Apparatus"
    },
    {
      "type": "kernel",
      "key": "Reaction Core"
    },
    {
      "type": "uptime",
      "key": "Synthesis Time"
    },
    {
      "type": "packages",
      "key": "Reagents"
    },
    {
      "type": "shell",
      "key": "CLI Crucible"
    },
    {
      "type": "de",
      "key": "Glassware UI"
    },
    {
      "type": "wm",
      "key": "Compositor"
    },
    {
      "type": "terminal",
      "key": "Terminal"
    },
    {
      "type": "cpu",
      "key": "Catalyst (CPU)"
    },
    {
      "type": "gpu",
      "key": "Renderer"
    },
    {
      "type": "memory",
      "key": "Flask Capacity"
    },
    {
      "type": "disk",
      "key": "Storage Vessel"
    },
    "break",
    "colors"
  ]
}
EOF
cp /etc/fastfetch/config.jsonc /etc/xdg/fastfetch/config.jsonc

# 5. Install berzelius-update and glassware tools
mkdir -p /usr/local/bin
curl -sL https://raw.githubusercontent.com/rappar222/berzelius-os/main/airootfs/usr/local/bin/berzelius-update -o /usr/local/bin/berzelius-update || true
curl -sL https://raw.githubusercontent.com/rappar222/berzelius-os/main/airootfs/usr/local/bin/berzelius-calc -o /usr/local/bin/berzelius-calc || true
curl -sL https://raw.githubusercontent.com/rappar222/berzelius-os/main/airootfs/usr/local/bin/periodic -o /usr/local/bin/periodic || true
curl -sL https://raw.githubusercontent.com/rappar222/berzelius-os/main/airootfs/usr/local/bin/berzelius-welcome -o /usr/local/bin/berzelius-welcome || true
chmod +x /usr/local/bin/berzelius-* /usr/local/bin/periodic 2>/dev/null || true

# 6. Add alias and prompt to bashrc if desired
TARGET_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$TARGET_USER")
if [ -f "$USER_HOME/.bashrc" ]; then
    if ! grep -q "fastfetch" "$USER_HOME/.bashrc"; then
        echo "alias fetch='fastfetch'" >> "$USER_HOME/.bashrc"
    fi
    if ! grep -q "berzelius-update" "$USER_HOME/.bashrc"; then
        echo "alias update='sudo berzelius-update'" >> "$USER_HOME/.bashrc"
    fi
fi

echo "✅ BerzeliusOS identity and berzelius-update installed successfully!"
echo ""
fastfetch || true
