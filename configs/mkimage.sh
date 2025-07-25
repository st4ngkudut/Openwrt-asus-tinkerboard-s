#!/bin/bash
set -e

if [[ -z "$1" ]]; then
  echo "Usage: $0 /dev/sdX"
  exit 1
fi

DISK=$1

echo "[*] Partitioning $DISK..."
sudo parted -s "$DISK" mklabel msdos
sudo parted -s "$DISK" mkpart primary fat32 1MiB 100MiB
sudo parted -s "$DISK" mkpart primary ext4 100MiB 100%

BOOT="${DISK}1"
ROOT="${DISK}2"

sudo mkfs.vfat "$BOOT"
sudo mkfs.ext4 "$ROOT"

MNT_BOOT=$(mktemp -d)
MNT_ROOT=$(mktemp -d)

sudo mount "$BOOT" "$MNT_BOOT"
sudo mount "$ROOT" "$MNT_ROOT"

echo "[*] Copying boot files..."
sudo cp zImage rk3288-tinker.dtb "$MNT_BOOT"
sudo mkdir -p "$MNT_BOOT/extlinux"
sudo cp extlinux.conf "$MNT_BOOT/extlinux/"

echo "[*] Extracting rootfs..."
tar -xzf rootfs.tar.gz -C "$MNT_ROOT"

sync
sudo umount "$MNT_BOOT" "$MNT_ROOT"
rmdir "$MNT_BOOT" "$MNT_ROOT"

echo "[✓] SD Card ready to flash into Tinker Board S."
