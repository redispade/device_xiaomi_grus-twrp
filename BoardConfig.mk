#
# Copyright 2017 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

DEVICE_PATH := device/xiaomi/grus

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo300

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

TARGET_USES_64_BIT_BINDER := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sdm710
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Kernel
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xA90000 androidboot.hardware=qcom androidboot.console=ttyMSM0
BOARD_KERNEL_CMDLINE += video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += service_locator.enable=1 androidboot.configfs=true androidboot.usbcontroller=a600000.dwc3 swiotlb=1
BOARD_KERNEL_CMDLINE += firmware_class.path=/vendor/firmware_mnt/image loop.max_part=7
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
#TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz-dtb
#BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img

ifeq ($(TARGET_PREBUILT_KERNEL),)
  TARGET_KERNEL_ARCH := arm64
  TARGET_KERNEL_HEADER_ARCH := arm64
#  TARGET_KERNEL_CONFIG := kowalski_defconfig
  TARGET_KERNEL_CONFIG := grus_user_defconfig
  TARGET_KERNEL_CLANG_COMPILE := true
  TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
  TARGET_KERNEL_SOURCE := kernel/xiaomi/grus
  TARGET_KERNEL_VERSION := 4.9
  TARGET_COMPILE_WITH_MSM_KERNEL := true
  BOARD_DTBOIMG_PARTITION_SIZE := 8388608
endif


# Recovery DTBO
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_BOOTIMG_HEADER_VERSION := 1
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# Platform
TARGET_BOARD_PLATFORM := sdm710
TARGET_BOARD_PLATFORM_GPU := qcom-adreno616

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144

BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3758096384
BOARD_USERDATAIMAGE_PARTITION_SIZE := 119613140992
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736

#System as root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
BOARD_SUPPRESS_SECURE_ERASE := true


TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true

# Android Verified Boot
BOARD_AVB_ENABLE := false
BOARD_BUILD_DISABLED_VBMETAIMAGE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE := true

# TWRP specific build flags
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TW_INCLUDE_NTFS_3G := true
TW_EXTRA_LANGUAGES := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_SCREEN_BLANK_ON_BOOT := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_USE_TOOLBOX := true
TW_Y_OFFSET := 80
TW_H_OFFSET := -80
TW_NO_SCREEN_BLANK := true
TW_EXCLUDE_TWRPAPP := true

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31

#adbd insecure
BOARD_ALWAYS_INSECURE := true

# View button edl mode
TW_HAS_EDL_MODE := true

# Use ro.product.model
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

# NTFS support
TW_INCLUDE_NTFS_3G := true

# Set language default
TW_DEFAULT_LANGUAGE := en

# For Version TWRP
TW_DEVICE_VERSION := 7beta-Mi9SE by redispade

#Correct cpu temperature path
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/virtual/thermal/thermal_zone6/temp

#enable vibration
TW_NO_HAPTICS := false
TW_USE_QCOM_HAPTICS_VIBRATOR := true

#PIE
PLATFORM_SDK_VERSION := 28

#Brightness
TW_DEFAULT_BRIGHTNESS := 288
TW_MAX_BRIGHTNESS := 2047

# LZMA compression for recovery's & kernel ramdisk....
LZMA_RAMDISK_TARGETS := recovery

# For Screen_timeout_secs
TW_SCREEN_TIMEOUT_SECS := "120"

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# Always use rm -rf to wipe
TW_ALWAYS_RMRF := true

#personal preference flags

-include vendor/redispade/recovery/config.mk
