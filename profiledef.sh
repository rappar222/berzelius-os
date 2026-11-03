#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="berzeliusos"
iso_label="BERZELIUS_$(date +%Y%m)"
iso_publisher="BerzeliusOS Project <https://github.com/berzeliusos>"
iso_application="BerzeliusOS Linux Live/Installation Media (Tall-Form Beaker Edition)"
iso_version="$(date +%Y.%m.%d)"
install_dir="berzelius"
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86' '-b' '1M' '-Xdict-size' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/sudoers.d"]="0:0:750"
  ["/etc/sudoers.d/00-liveuser"]="0:0:440"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/home/radu"]="1000:1000:755"
  ["/usr/local/bin/berzelius-welcome"]="0:0:755"
  ["/usr/local/bin/berzelius-calc"]="0:0:755"
  ["/usr/local/bin/berzelius-update"]="0:0:755"
  ["/usr/local/bin/periodic"]="0:0:755"
  ["/usr/local/bin/berzelius-setup"]="0:0:755"
)
