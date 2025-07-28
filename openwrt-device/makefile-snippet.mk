
define Device/asus_tinker_board_s
  DEVICE_TITLE := Asus Tinker Board S
  DEVICE_DTS := rk3288-tinker-s
  DEVICE_PACKAGES := kmod-r8169 kmod-usb-core kmod-usb2 kmod-usb3 kmod-fs-ext4 block-mount base-files blkid ca-bundle dnsmasq dropbear e2fsprogs firewall4 fstools kmod-fs-vfat kmod-nft-offload libc libgcc libustream-mbedtls logd mkf2fs mtd netifd nftables odhcp6c odhcpd-ipv6only opkg ppp ppp-mod-pppoe procd-ujail uci uclient-fetch urandom-seed urngd kmod-amazon-ena kmod-e1000e kmod-vmxnet3 kmod-rtc-rx8025 kmod-i2c-mux-pca954x kmod-gpio-pca953x partx-utils kmod-wdt-sp805 kmod-mvneta kmod-mvpp2 kmod-fsl-dpaa1-net kmod-fsl-dpaa2-net kmod-fsl-enetc-net kmod-dwmac-imx kmod-fsl-fec kmod-dwmac-rockchip kmod-dwmac-sun8i kmod-phy-aquantia kmod-phy-broadcom kmod-phy-marvell kmod-phy-marvell-10g kmod-sfp kmod-atlantic kmod-bcmgenet kmod-octeontx2-net kmod-renesas-net-avb kmod-phy-realtek kmod-phy-smsc luci
endef
TARGET_DEVICES += asus_tinker_board_s
