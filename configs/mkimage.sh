#!/bin/bash
set -e

OUTPUT_IMG="openwrt.img"
BOOT_SIZE=64M
ROOTFS=rootfs.ext4

dd if=/dev/zero of=$OUTPUT_IMG bs=1M count=512

parted $OUTPUT_IMG --script mklabel msdos
parted $OUTPUT_IMG --script mkpart primary ext2 1MiB 65MiB
parted $OUTPUT_IMG --script mkpart primary ext4 65MiB 100%

LOOPDEV=$(losetup --show -fP $OUTPUT_IMG)
partprobe $LOOPDEV

mkfs.vfat ${LOOPDEV}p1
mkfs.ext4 ${LOOPDEV}p2

mkdir -p mnt/boot mnt/root
mount ${LOOPDEV}p1 mnt/boot
mount ${LOOPDEV}p2 mnt/root

cp zImage *.dtb extlinux.conf mnt/boot/
dd if=$ROOTFS of=${LOOPDEV}p2 bs=4M conv=fsync

sync
umount mnt/boot mnt/root
losetup -d $LOOPDEV
rm -rf mnt

gzip -f $OUTPUT_IMG
echo "✅ Image created and compressed: $OUTPUT_IMG.gz"
