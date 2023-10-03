#!/usr/bin/env bash

DISK=/dev/"$1"

sudo parted -- "$DISK" mklabel gpt
sudo parted -- "$DISK" mkpart ESP fat32 1MiB 512MiB
sudo parted -- "$DISK" set 1 esp on
# sudo parted -- "$DISK" set 1 boot on

source ./bootstrap.sh
