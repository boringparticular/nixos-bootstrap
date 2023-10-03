#!/usr/bin/env bash

DISK=/dev/"$1"
USE_GPT="$2"

if [[ -z "$USE_GPT+x" ]];
then
    sudo parted -- "$DISK" mklabel gpt
    sudo parted -- "$DISK" mkpart ESP fat32 1MiB 512MiB
    sudo parted -- "$DISK" set 1 esp on
    # sudo parted -- "$DISK" set 1 boot on
else
    sudo parted -- "$DISK" mklabel msdos
    sudo parted -- "$DISK" mkpart primary 1MiB 512MiB
fi

sudo parted -- "$DISK" mkpart primary 512MiB 100%

sudo mkfs.fat -F 32 -n boot /"$DISK"1
sudo mkfs.btrfs -L nixos /"$DISK"2

sudo mount "$DISK"2 /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/home
sudo btrfs subvolume create /mnt/nix
sudo btrfs subvolume create /mnt/swap
sudo umount /mnt

sudo mount -o compress=zstd,subvol=root /"$DISK"2 /mnt
sudo mkdir /mnt/{home,nix}
sudo mount -o compress=zstd,subvol=home /"$DISK"2 /mnt/home
sudo mount -o compress=zstd,subvol=nix /"$DISK"2 /mnt/nix

sudo mkdir /mnt/boot
sudo mount "$DISK"1 /mnt/boot

sudo nixos-generate-config --root /mnt

# if [[ -z "$USE_GPT+x" ]];
# then
#     sudo cp ./minimal.nix /etc/nixos/configuration.nix
# else
# fi
#
# sudo nixos-install --root /mnt --no-root-passwd
# sudo reboot
