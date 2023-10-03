#!/usr/bin/env bash

DISK=/dev/"$1"

sudo parted -- "$DISK" mklabel msdos
sudo parted -- "$DISK" mkpart primary 1MiB 512MiB

source ./bootstrap.sh

