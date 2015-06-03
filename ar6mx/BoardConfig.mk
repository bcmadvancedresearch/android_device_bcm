#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/bcm/ar6mx/build_id.mk
include device/bcm/ar6mx/AR6MXBoardConfigComm.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk

# camera hal v2
IMX_CAMERA_HAL_V2 := true

BOARD_HAVE_USB_CAMERA := true

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0 video=mxcfb1:off video=mxcfb2:off fbmem=10M fb0base=0x27b00000 vmalloc=400M androidboot.console=ttymxc0


ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0 video=mxcfb1:off video=mxcfb2:off fbmem=10M fb0base=0x27b00000 vmalloc=400M androidboot.console=ttymxc0  mtdparts=gpmi-nand:20m(bootloader),20m(bootimg),20m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

#TARGET_KERNEL_DEFCONF := ar6mx_android_defconfig
TARGET_KERNEL_DEFCONF := imx_v7_android_defconfig
USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true
TARGET_BOOTLOADER_CONFIG := 6q:ar6mxqandroid_config 6dl:ar6mxdlandroid_config 6solo:ar6mxsandroid_config
TARGET_BOARD_DTS_CONFIG := 6q:imx6q-ar6mx.dtb 6dl:imx6dl-ar6mx.dtb

# Filesystem and partitioning
#BOARD_SYSTEMIMAGE_PARTITION_SIZE	:= 512M
BOARD_USERDATAIMAGE_PARTITION_SIZE	:= 536870912
BOARD_CACHEIMAGE_PARTITION_SIZE		:= 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE	:= ext4
BOARD_FLASH_BLOCK_SIZE 			:= 4096
TARGET_USERIMAGES_USE_EXT4		:= true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED	:= true

# System
TARGET_NO_RECOVERY			:= false
TARGET_PROVIDES_INIT_RC			:= true
TARGET_RECOVERY_FSTAB = device/bcm/ar6mx/fstab.bcm

BOARD_SEPOLICY_DIRS := \
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
