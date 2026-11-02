#!/usr/bin/env bash
# ==============================================================================
# BerzeliusOS ISO Build Script
# The Chemistry Glassware Distribution (Arch Linux Base)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORK_DIR="${WORK_DIR:-/tmp/berzelius-build-work}"
OUT_DIR="${OUT_DIR:-${SCRIPT_DIR}/out}"

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

echo -e "${CYAN}"
echo "======================================================================"
echo "    🧪 BerzeliusOS - Tall-Form Chemistry Glassware Distribution"
echo "======================================================================"
echo -e "${NC}"

# Check root privileges
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[ERROR] mkarchiso requires root privileges.${NC}"
    echo -e "Please re-run this script with sudo:"
    echo -e "    ${YELLOW}sudo ./build.sh${NC}"
    exit 1
fi

# Check for mkarchiso
if ! command -v mkarchiso >/dev/null 2>&1; then
    echo -e "${RED}[ERROR] 'mkarchiso' command not found!${NC}"
    echo -e "Install archiso package using:"
    echo -e "    ${YELLOW}pacman -S --needed archiso${NC}"
    exit 1
fi

# Ensure executable permissions on helper scripts
chmod +x "${SCRIPT_DIR}/airootfs/usr/local/bin/"* 2>/dev/null || true

# Prepare output directory
mkdir -p "${OUT_DIR}"

echo -e "${GREEN}[1/4] Preparing build workspace:${NC}"
echo -e "  • Profile directory : ${SCRIPT_DIR}"
echo -e "  • Work directory    : ${WORK_DIR}"
echo -e "  • Output directory  : ${OUT_DIR}"
echo ""

# Clean existing work directory to avoid stale locks from aborted runs
if [ -d "${WORK_DIR}" ]; then
    echo -e "${YELLOW}Cleaning previous temporary work directory...${NC}"
    rm -rf "${WORK_DIR}"
fi

echo -e "${GREEN}[2/4] Validating profiledef.sh and package manifest...${NC}"
if [ ! -f "${SCRIPT_DIR}/profiledef.sh" ] || [ ! -f "${SCRIPT_DIR}/packages.x86_64" ]; then
    echo -e "${RED}[ERROR] Missing profiledef.sh or packages.x86_64!${NC}"
    exit 1
fi
echo -e "  ✓ Manifests found."

echo -e "${GREEN}[3/4] Synthesizing BerzeliusOS ISO with mkarchiso...${NC}"
echo -e "  (This will download packages and assemble the live filesystem)"
echo ""

mkarchiso -v -w "${WORK_DIR}" -o "${OUT_DIR}" "${SCRIPT_DIR}"

echo ""
echo -e "${GREEN}[4/4] Generating cryptographic checksums...${NC}"
cd "${OUT_DIR}"
for iso in *.iso; do
    if [ -f "$iso" ]; then
        sha256sum "$iso" > "${iso}.sha256"
        echo -e "  ✓ Created checksum: ${CYAN}${iso}.sha256${NC}"
    fi
done

echo ""
echo -e "${CYAN}======================================================================${NC}"
echo -e "${GREEN}🧪 BerzeliusOS ISO synthesis complete!${NC}"
echo -e "ISO is ready for VirtualBox at: ${YELLOW}${OUT_DIR}/*.iso${NC}"
echo -e "${CYAN}======================================================================${NC}"
