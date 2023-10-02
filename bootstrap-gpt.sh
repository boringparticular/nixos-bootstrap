#!/usr/bin/env bash

DISK=/dev/"$1"

sudo parted -- "$DISK" mklabel gpt
sudo parted -- "$DISK" mkpart ESP fat32 1MiB 512MiB
sudo parted -- "$DISK" set 1 esp on
# sudo parted -- "$DISK" set 1 boot on
sudo parted -- "$DISK" mkpart primary 512MiB 100%

sudo mkfs.fat -F 32 -n UEFI /dev/"$DISK"1

source ./bootstrap.sh
