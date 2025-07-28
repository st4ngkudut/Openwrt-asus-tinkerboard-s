
define Device/asus_tinker_board_s
  DEVICE_TITLE := Asus Tinker Board S
  DEVICE_DTS := rk3288-tinker-s
  DEVICE_PACKAGES := kmod-r8169 kmod-usb-core kmod-usb2 kmod-usb3 kmod-fs-ext4 block-mount
endef
TARGET_DEVICES += asus_tinker_board_s
