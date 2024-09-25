#!/usr/bin/env bash

echo "Machine name:"
printf "%s" "> "
read machine

set -x

nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./machines/${machine}/disks.nix
nixos-generate-config --root /mnt
mv /mnt/etc/nixos ~
cp -r . /mnt/etc/nixos
cp ~/nixos/hardware-configuration.nix /mnt/etc/nixos/machines/${machine}
nixos-install --flake /mnt/etc/nixos#${machine}

