
#!/bin/bash
DEVICE="$1"

if [ -z "$DEVICE" ]; then
    echo "Usage: $0 /dev/sdX"
    exit 1
fi

echo "Partitioning $DEVICE..."
sudo parted $DEVICE mklabel msdos
sudo parted -a optimal $DEVICE mkpart primary fat32 1MiB 128MiB
sudo parted -a optimal $DEVICE mkpart primary ext4 128MiB 100%

sudo mkfs.vfat ${DEVICE}1
sudo mkfs.ext4 ${DEVICE}2

echo "Mounting partitions..."
mkdir -p /mnt/boot /mnt/root
sudo mount ${DEVICE}1 /mnt/boot
sudo mount ${DEVICE}2 /mnt/root

echo "Copying OpenWrt files..."
cp bin/targets/armsr/armv7/openwrt-*-zImage /mnt/boot/zImage
cp bin/targets/armsr/armv7/openwrt-*.dtb /mnt/boot/rk3288-tinker-s.dtb
tar -xzf bin/targets/armsr/armv7/openwrt-*-rootfs.tar.gz -C /mnt/root

echo "Writing U-Boot..."
sudo dd if=u-boot/rk3288_tinker_s.bin of=$DEVICE seek=64 conv=notrunc

echo "Sync and unmount..."
sync
sudo umount /mnt/boot /mnt/root
