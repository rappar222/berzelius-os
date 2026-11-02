#!/usr/bin/env bash
# ==============================================================================
# BerzeliusOS QEMU Virtual Machine Test Runner
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SCRIPT_DIR}/out"

CYAN='\033[1;36m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

# Find the latest generated ISO
ISO_FILE=$(ls -t "${OUT_DIR}"/*.iso 2>/dev/null | head -n 1 || true)

if [ -z "$ISO_FILE" ]; then
    echo -e "${RED}[ERROR] No BerzeliusOS ISO found in ${OUT_DIR}!${NC}"
    echo -e "Please build the ISO first using:"
    echo -e "    ${YELLOW}sudo ./build.sh${NC}"
    exit 1
fi

echo -e "${CYAN}======================================================================${NC}"
echo -e "  🧪 Launching BerzeliusOS in QEMU virtual laboratory"
echo -e "  ISO: ${YELLOW}${ISO_FILE}${NC}"
echo -e "${CYAN}======================================================================${NC}"

# Detect KVM acceleration
KVM_FLAG=""
if [ -w /dev/kvm ]; then
    echo -e "${GREEN}✓ KVM hardware acceleration active${NC}"
    KVM_FLAG="-enable-kvm -cpu host"
else
    echo -e "${YELLOW}! KVM not available or accessible, running in standard emulation mode${NC}"
    KVM_FLAG="-cpu max"
fi

# Detect UEFI firmware (OVMF) if available
OVMF_FLAG=""
for ovmf_path in \
    /usr/share/ovmf/x64/OVMF_CODE.fd \
    /usr/share/edk2/x64/OVMF_CODE.fd \
    /usr/share/edk2-ovmf/x64/OVMF_CODE.fd \
    /usr/share/qemu/ovmf-x86_64-code.bin; do
    if [ -f "$ovmf_path" ]; then
        echo -e "${GREEN}✓ UEFI Firmware detected: ${ovmf_path}${NC}"
        OVMF_FLAG="-drive if=pflash,format=raw,readonly=on,file=${ovmf_path}"
        break
    fi
done

qemu-system-x86_64 \
    ${KVM_FLAG} \
    ${OVMF_FLAG} \
    -m 4G \
    -smp 4 \
    -vga virtio \
    -display sdl,gl=on 2>/dev/null || \
qemu-system-x86_64 \
    ${KVM_FLAG} \
    ${OVMF_FLAG} \
    -m 4G \
    -smp 4 \
    -vga virtio \
    -cdrom "${ISO_FILE}" \
    -boot d \
    -nic user,model=virtio-net-pci
