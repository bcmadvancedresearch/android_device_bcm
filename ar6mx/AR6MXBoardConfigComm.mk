
#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := AR6MX
PRODUCT_MODEL := AR6MX 

# For wifi
BOARD_CUSTOM_WIFI_HAL_SRC := hardware/intel/wifi/wifi.c
ADDITIONAL_DEFAULT_PROPERTIES += wifi.interface=wlan0

# Must be set to enable WPA supplicant build. WEXT is the driver for generic
# linux wireless extensions. NL80211 supercedes it.
# This variable is used by external/wpa_supplicant/Android.mk
BOARD_WPA_SUPPLICANT_DRIVER=NL80211

# Set to use WCS supplicant version
WPA_SUPPLICANT_VERSION := VER_2_1_DEVEL_WCS
BOARD_WLAN_DEVICE := intc

#Do not reload firmware when enabling SoftAP
NO_FW_RELOAD_FOR_SOFTAP := true

BOARD_USING_INTEL_IWL := true
INTEL_IWL_BOARD_CONFIG := iwlwifi-public-android
INTEL_IWL_USE_SYSTEM_COMPAT_MOD_BUILD := y

BOARD_MODEM_VENDOR := AMAZON

BOARD_HAVE_HARDWARE_GPS := true
USE_ATHR_GPS_HARDWARE := true
USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true
SENSOR_MMA8451 := true

# for recovery service
TARGET_SELECT_KEY := 28

TARGET_USERIMAGES_USE_EXT4 := true

# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/bcm/ar6mx/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

# atheros 3k BT
BOARD_USE_AR3K_BLUETOOTH := true

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true
