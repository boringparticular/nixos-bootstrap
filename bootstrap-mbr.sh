#!/usr/bin/env bash

DISK=/dev/"$1"

sudo parted -- "$DISK" mklabel msdos
sudo parted -- "$DISK" mkpart primary 1MiB 512MiB
sudo parted -- "$DISK" mkpart primary 512MiB 100%

sudo mkfs.fat -F 32 -n NIXBOOT /dev/"$DISK"1

source ./bootstrap.sh

