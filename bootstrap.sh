#!/usr/bin/env bash

sudo parted -- "$DISK" mkpart primary 512MiB 100%

sudo mkfs.fat -F 32 -n boot /dev/"$DISK"1
sudo mkfs.btrfs -L nixos /dev/"$DISK"2

sudo mount /dev/"$DISK"2 /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/home
sudo btrfs subvolume create /mnt/nix
sudo btrfs subvolume create /mnt/swap
sudo umount /mnt

sudo mount -o compress=zstd,subvol=root /dev/"$DISK"2 /mnt
sudo mkdir /mnt/{home,nix}
sudo mount -o compress=zstd,subvol=home /dev/"$DISK"2 /mnt/home
sudo mount -o compress=zstd,subvol=nix /dev/"$DISK"2 /mnt/nix

sudo mkdir /mnt/boot
sudo mount /dev/"$DISK"1 /mnt/boot

sudo nixos-generate-config --root /mnt
sudo cp ./minimal.nix /etc/nixos/configuration.nix
sudo nixos-install --root /mnt --no-root-passwd
sudo reboot
