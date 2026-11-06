#!/bin/sh
# Continua a instalacao: remove linha duplicada e roda nixos-install
set -ex
cd /mnt/etc/nixos
awk '!(/virtualisation.virtualbox.guest.enable/ && seen++)' hardware-configuration.nix > /tmp/hw2.nix
cp /tmp/hw2.nix hardware-configuration.nix
rm -f j
nix-shell -p git --run "git add -A"
nixos-install --flake /mnt/etc/nixos#nixos --no-root-passwd
nixos-enter --root /mnt -c 'echo tux:tux | chpasswd'
echo "INSTALACAO CONCLUIDA"
