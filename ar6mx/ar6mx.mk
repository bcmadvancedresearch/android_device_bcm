# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/fsl/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

#ifneq ($(wildcard device/bcm/ar6mx/fstab_nand.freescale),)
#$(shell touch device/bcm/ar6mx/fstab_nand.freescale)
#endif

#ifneq ($(wildcard device/bcm/ar6mx/fstab.freescale),)
#$(shell touch device/bcm/ar6mx/fstab.freescale)
#endif

# Overrides
PRODUCT_NAME := ar6mx
PRODUCT_DEVICE := ar6mx

PRODUCT_COPY_FILES += \
        device/bcm/ar6mx/init.rc:root/init.freescale.rc \
        device/bcm/ar6mx/gpsreset.sh:system/etc/gpsreset.sh \
        device/bcm/ar6mx/audio_policy.conf:system/etc/audio_policy.conf \
        device/bcm/ar6mx/audio_effects.conf:system/vendor/etc/audio_effects.conf \
        device/bcm/init.superuser.rc:root/init.superuser.rc \
        device/bcm/ar6mx/load_wifi_module.sh:system/etc/load_wifi_module.sh \

PRODUCT_COPY_FILES +=	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6d.bin:system/lib/firmware/vpu/vpu_fw_imx6d.bin 	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6q.bin:system/lib/firmware/vpu/vpu_fw_imx6q.bin
# setup dm-verity configs.
#ifneq ($(BUILD_TARGET_DEVICE),sd)
# PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk3p5
# $(call inherit-product, build/target/product/verity.mk)
#else 
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk2p5
 $(call inherit-product, build/target/product/verity.mk)

#endif

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/bcm/ar6mx/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
	device/bcm/ar6mx/required_hardware.xml:system/etc/permissions/required_hardware.xml

PRODUCT_PACKAGES += AudioRoute

# for Compat driver
PRODUCT_COPY_FILES += \
	device/bcm/ar6mx/p2p_supplicant.conf:system/etc/wifi/p2p_supplicant.conf \

# include firmware binaries for Wifi adapters
#$(call inherit-product-if-exists, vendor/linux-firmware/iwlwifi.mk)
$(call inherit-product,$(LOCAL_PATH)/firmware.mk)

PRODUCT_PROPERTY_OVERRIDES += \
        wifi.interface=wlan0

#SUPERUSER_PACKAGE := com.bcm.superuser
SUPERUSER_PACKAGE_PREFIX := .cyanogenmod.superuser

SUPERUSER_EMBEDDED := true

PRODUCT_PACKAGES += IWLWIFI \
	su \
	Superuser \
	iwlwifi.ko
