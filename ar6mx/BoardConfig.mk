#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/bcm/ar6mx/build_id.mk
include device/fsl/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# AR6MX default target for EXT4
BUILD_TARGET_FS = ext4
# AR6MX default target device(change to emmc for emmc boot)
BUILD_TARGET_DEVICE = sd

include device/fsl/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_DEVICE),sd)
ADDITIONAL_BUILD_PROPERTIES += \
                        ro.boot.storage_type=sd
TARGET_RECOVERY_FSTAB = device/bcm/ar6mx/fstab.bcm.sd
PRODUCT_COPY_FILES +=	\
	device/bcm/ar6mx/fstab.bcm.sd:root/fstab.freescale
else
ADDITIONAL_BUILD_PROPERTIES += \
                        ro.boot.storage_type=emmc
TARGET_RECOVERY_FSTAB = device/bcm/ar6mx/fstab.bcm.emmc
PRODUCT_COPY_FILES +=	\
	device/bcm/ar6mx/fstab.bcm.emmc:root/fstab.freescale
endif # BUILD_TARGET_DEVICE


TARGET_BOOTLOADER_BOARD_NAME := AR6MX
PRODUCT_MODEL := AR6MX

TARGET_RELEASETOOLS_EXTENSIONS := device/fsl/imx6

# This enables the wpa wireless driver
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_2_1_DEVEL_WCS

# Enabling iwlwifi
BOARD_USING_INTEL_IWL := true
INTEL_IWL_MODULE_SUB_FOLDER := cht

COMBO_CHIP_VENDOR := intel
COMBO_CHIP := lnp

# SoftAp FW reload definitions.
# we don't really need this, it's to avoid error when the framework
# will trigger the fwReloadSoftap function, what will lead to an error
# enabling the SoftAp.
# so we set up this for letting the function execute gracefully.
WIFI_DRIVER_FW_PATH_STA := "/system/vendor/firmware/iwlwifi-softap-dummy.ucode"
WIFI_DRIVER_FW_PATH_AP  := "/system/vendor/firmware/iwlwifi-softap-dummy.ucode"
WIFI_DRIVER_FW_PATH_P2P := "/system/vendor/firmware/iwlwifi-softap-dummy.ucode"
WIFI_DRIVER_FW_PATH_PARAM := "/dev/null"

BOARD_MODEM_VENDOR := AMAZON

USE_ATHR_GPS_HARDWARE := true
USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true
SENSOR_MMA8451 := true

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
DM_VERITY_RUNTIME_CONFIG := true
# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true


ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/fsl/sabresd_6dq/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=ldb,bpp=32 video=mxcfb1:off video=mxcfb2:off video=mxcfb3:off vmalloc=400M androidboot.console=ttymxc0 consoleblank=0 androidboot.hardware=freescale cma=384M

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

# atheros 3k BT
BOARD_USE_AR3K_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/bcm/ar6mx/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v2
IMX_CAMERA_HAL_V2 := true

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := true

TARGET_BOOTLOADER_CONFIG := 6q:ar6mxqandroid_config 6dl:ar6mxdlandroid_config 6solo:ar6mxsandroid_config
TARGET_BOARD_DTS_CONFIG := 6q:imx6q-ar6mx.dtb 6dl:imx6dl-ar6mx.dtb

BOARD_SEPOLICY_DIRS := \
       device/fsl/imx6/sepolicy \
       device/bcm/ar6mx/sepolicy

BOARD_SEPOLICY_UNION := \
       domain.te \
       system_app.te \
       system_server.te \
       untrusted_app.te \
       sensors.te \
       init_shell.te \
       bluetooth.te \
       kernel.te \
       mediaserver.te \
       file_contexts \
       genfs_contexts \
       fs_use  \
       rild.te \
       init.te \
       netd.te \
       bootanim.te \
       dnsmasq.te \
       recovery.te \
       device.te \
       zygote.te
