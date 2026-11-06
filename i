#!/bin/sh
# Instala o NixOS na VM com a config deste repositorio
set -ex
D=/dev/sda
parted -s $D -- mklabel gpt mkpart ESP fat32 1MiB 1GiB set 1 esp on mkpart root btrfs 1GiB 100%
sleep 2
mkfs.fat -F32 -n BOOT ${D}1
mkfs.btrfs -f -L nixos ${D}2
mount ${D}2 /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
umount /mnt
mount -o subvol=@,compress=zstd,noatime ${D}2 /mnt
mkdir -p /mnt/home /mnt/nix /mnt/boot
mount -o subvol=@home,compress=zstd,noatime ${D}2 /mnt/home
mount -o subvol=@nix,compress=zstd,noatime ${D}2 /mnt/nix
mount -o umask=077 ${D}1 /mnt/boot
nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix /tmp/hw.nix
rm -rf /mnt/etc/nixos
nix-shell -p git --run "git clone https://github.com/GabrielFTL-13/nixos-config /mnt/etc/nixos"
cp /tmp/hw.nix /mnt/etc/nixos/hardware-configuration.nix
sed -i 's|^}$|  virtualisation.virtualbox.guest.enable = true;\n}|' /mnt/etc/nixos/hardware-configuration.nix
rm -f /mnt/etc/nixos/i
cd /mnt/etc/nixos
nix-shell -p git --run "git add -A"
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
nixos-enter --root /mnt -c 'echo tux:tux | chpasswd'
echo "INSTALACAO CONCLUIDA"
