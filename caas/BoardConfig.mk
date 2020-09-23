# ----------------- BEGIN MIX-IN DEFINITIONS -----------------
# Mix-In definitions are auto-generated by mixin-update
##############################################################
# Source: device/intel/mixins/groups/disk-bus/auto/BoardConfig.mk
##############################################################
BOARD_DISK_BUS = ff.ff
##############################################################
# Source: device/intel/mixins/groups/dynamic-partitions/true/BoardConfig.mk
##############################################################
# Configure super partitions
BOARD_SUPER_PARTITION_GROUPS := group_sys
BOARD_GROUP_SYS_PARTITION_LIST := system vendor product odm

BOARD_SUPER_PARTITION_SIZE := $(shell echo 8000*1024*1024 | bc)
BOARD_GROUP_SYS_SIZE = $(shell echo "$(BOARD_SUPER_PARTITION_SIZE) / 2 - 4*1024*1024" | bc)

##############################################################
# Source: device/intel/mixins/groups/slot-ab/true/BoardConfig.mk
##############################################################
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS := \
    boot \
    system
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_SLOT_AB_ENABLE := true
BOARD_KERNEL_CMDLINE += rootfstype=ext4

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=false \
    POSTINSTALL_PATH_vendor=bin/postinstall
##############################################################
# Source: device/intel/mixins/groups/avb/true/BoardConfig.mk
##############################################################
BOARD_AVB_ENABLE := true
##############################################################
# Source: device/intel/mixins/groups/boot-arch/project-celadon/BoardConfig.mk
##############################################################
#
# -- OTA RELATED DEFINES --
#

# tell build system where to get the recovery.fstab.
TARGET_RECOVERY_FSTAB ?= $(TARGET_DEVICE_DIR)/fstab.recovery

# Used by ota_from_target_files to add platform-specific directives
# to the OTA updater scripts
TARGET_RELEASETOOLS_EXTENSIONS ?= $(INTEL_PATH_BUILD)/test

# By default recovery minui expects RGBA framebuffer
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"


#
# FILESYSTEMS
#

# NOTE: These values must be kept in sync with BOARD_GPT_INI
BOARD_BOOTIMAGE_PARTITION_SIZE ?= 31457280
SYSTEM_PARTITION_SIZE = $(shell echo 2560*1024*1024 | bc)
BOARD_TOSIMAGE_PARTITION_SIZE := 10485760
BOARD_BOOTLOADER_PARTITION_SIZE ?= $$((33 * 1024 * 1024))
BOARD_BOOTLOADER_BLOCK_SIZE := 4096
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
DATA_USE_F2FS := False

ifeq ($(DATA_USE_F2FS), true)
TARGET_USERIMAGES_USE_F2FS := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
else
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
INTERNAL_USERIMAGES_EXT_VARIANT := ext4
endif


TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

ifeq ($(BOARD_FLASH_UFS), 1)
BOARD_FLASH_BLOCK_SIZE := 4096
else ifeq ($(BOARD_FLASH_NVME), 1)
BOARD_FLASH_BLOCK_SIZE := 512
else
BOARD_FLASH_BLOCK_SIZE := 512
endif

# Partition table configuration file
BOARD_GPT_INI ?= $(TARGET_DEVICE_DIR)/gpt.ini

TARGET_BOOTLOADER_BOARD_NAME := $(TARGET_DEVICE)

BOARD_BOOTIMG_HEADER_VERSION := 2
BOARD_PREBUILT_DTBIMAGE_DIR := $(TARGET_DEVICE_DIR)/acpi
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
#
#kernel always use primary gpt without command line option "gpt",
#the label let kernel use the alternate GPT if primary GPT is corrupted.
#
BOARD_KERNEL_CMDLINE += gpt

#
# Trusted Factory Reset - persistent partition
#
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_HARDWARE)/bootctrl/boot/overlay

#can't use := here, as PRODUCT_OUT is not defined yet
BOARD_GPT_BIN = $(PRODUCT_OUT)/gpt.bin
BOARD_FLASHFILES += $(BOARD_GPT_BIN):gpt.bin
INSTALLED_RADIOIMAGE_TARGET += $(BOARD_GPT_BIN)

# We offer the possibility to flash from a USB storage device using
# the "installer" EFI application
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/installer.efi
BOARD_FLASHFILES += $(PRODUCT_OUT)/efi/startup.nsh
BOARD_FLASHFILES += $(PRODUCT_OUT)/bootloader.img



BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/boot-arch/generic
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/generic
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/efi




AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/update_ifwi_ab \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

BOARD_AVB_ENABLE := true
KERNELFLINGER_AVB_CMDLINE := true
BOARD_VBMETAIMAGE_PARTITION_SIZE := 2097152
BOARD_FLASHFILES += $(PRODUCT_OUT)/vbmeta.img

AB_OTA_PARTITIONS += vbmeta
AB_OTA_PARTITIONS += tos


KERNELFLINGER_SUPPORT_USB_STORAGE ?= true

KERNELFLINGER_SUPPORT_LIVE_BOOT ?= true

##############################################################
# Source: device/intel/mixins/groups/wlan/auto/BoardConfig.mk
##############################################################
# This enables the wpa wireless driver
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_2_1_DEVEL
# required for wifi HAL support
BOARD_WLAN_DEVICE := iwlwifi

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/wlan/common
##############################################################
# Source: device/intel/mixins/groups/kernel/gmin64/BoardConfig.mk.1
##############################################################
TARGET_USES_64_BIT_BINDER := true
##############################################################
# Source: device/intel/mixins/groups/kernel/gmin64/BoardConfig.mk
##############################################################
# Specify location of board-specific kernel headers
TARGET_BOARD_KERNEL_HEADERS := $(INTEL_PATH_COMMON)/kernel/lts2019-chromium/kernel-headers

ifneq ($(TARGET_BUILD_VARIANT),user)
KERNEL_LOGLEVEL ?= 7
else
KERNEL_LOGLEVEL ?= 2
endif

ifeq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += console=tty0
endif

BOARD_KERNEL_CMDLINE += \
        loglevel=$(KERNEL_LOGLEVEL) \
        androidboot.hardware=$(TARGET_DEVICE)\
        firmware_class.path=/vendor/firmware


BOARD_KERNEL_CMDLINE += \
       intel_pstate=passive

BOARD_KERNEL_CMDLINE += \
      snd-hda-intel.model=dell-headset-multi

ifeq ($(BASE_YOCTO_KERNEL), true)
BOARD_KERNEL_CMDLINE += \
      snd-intel-dspcfg.dsp_driver=1
endif

BOARD_SEPOLICY_M4DEFS += module_kernel=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/kernel
##############################################################
# Source: device/intel/mixins/groups/sepolicy/enforcing/BoardConfig.mk
##############################################################
# SELinux Policy
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)

# Pass device target to build in
BOARD_SEPOLICY_M4DEFS += board_sepolicy_target_product=$(TARGET_PRODUCT)
##############################################################
# Source: device/intel/mixins/groups/bluetooth/auto/BoardConfig.mk
##############################################################
BOARD_HAVE_BLUETOOTH_INTEL_ICNV := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(INTEL_PATH_COMMON)/bluetooth/tablet/

DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/bluetooth/overlay-bt-pan
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bluetooth/common
##############################################################
# Source: device/intel/mixins/groups/audio/project-celadon/BoardConfig.mk
##############################################################
BOARD_USES_ALSA_AUDIO := true
BOARD_USES_TINY_ALSA_AUDIO := true
BOARD_USES_GENERIC_AUDIO ?= false
USE_CUSTOM_PARAMETER_FRAMEWORK := false
ifneq ($(BOARD_USES_GENERIC_AUDIO), true)
# Audio HAL selection Flag default setting.
#  INTEL_AUDIO_HAL:= audio     -> baseline HAL
#  INTEL_AUDIO_HAL:= audio_pfw -> PFW-based HAL
INTEL_AUDIO_HAL := audio
else
INTEL_AUDIO_HAL := stub
endif

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/audio

# Use XML audio policy configuration file
USE_XML_AUDIO_POLICY_CONF := 1
# Use configurable audio policy
USE_CONFIGURABLE_AUDIO_POLICY := 0

# Use Baseline Legacy Audio HAL
USE_LEGACY_BASELINE_AUDIO_HAL := true
##############################################################
# Source: device/intel/mixins/groups/device-type/tablet/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/device-type/overlay-tablet
##############################################################
# Source: device/intel/mixins/groups/device-specific/caas/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += ${TARGET_DEVICE_DIR}/overlay

BOARD_KERNEL_CMDLINE += \
	no_timer_check \
	noxsaves \
	reboot_panic=p,w \
	i915.hpd_sense_invert=0x7 \
	intel_iommu=off \
	i915.enable_pvmmio=0 \
	loop.max_part=7

BOARD_FLASHFILES += ${TARGET_DEVICE_DIR}/bldr_utils.img:bldr_utils.img
BOARD_FLASHFILES += $(PRODUCT_OUT)/LICENSE
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/start_civ.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/start_flash_usb.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/auto_switch_pt_usb_vms.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/findall.py
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_host.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/sof_audio/configure_sof.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/sof_audio/blacklist-dsp.conf
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/setup_audio_host.sh
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/guest_pm_control
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/intel-thermal-conf.xml
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/thermald.service
BOARD_FLASHFILES += $(PRODUCT_OUT)/scripts/rpmb_dev

# for USB OTG WA
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/bxt_usb

# i915_async
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/i915_async

#add vendor property
BOARD_SEPOLICY_DIRS += device/intel/sepolicy/vendor/

TARGET_USES_HWC2 := true
BOARD_USES_GENERIC_AUDIO := false

DEVICE_MANIFEST_FILE := ${TARGET_DEVICE_DIR}/manifest.xml
DEVICE_MATRIX_FILE   := ${TARGET_DEVICE_DIR}/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := ${TARGET_DEVICE_DIR}/framework_manifest.xml
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
##############################################################
# Source: device/intel/mixins/groups/trusty/true/BoardConfig.mk
##############################################################
TARGET_USE_TRUSTY := true

ifneq (, $(filter abl sbl, project-celadon))
TARGET_USE_MULTIBOOT := true
endif

BOARD_USES_TRUSTY := true
BOARD_USES_KEYMASTER1 := true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/trusty
BOARD_SEPOLICY_M4DEFS += module_trusty=true

TRUSTY_BUILDROOT = $(PWD)/$(PRODUCT_OUT)/obj/trusty/

TRUSTY_ENV_VAR += TRUSTY_REF_TARGET=celadon_64

#for trusty vmm
# use same toolchain as android kernel
TRUSTY_ENV_VAR += CLANG_BINDIR=$(PWD)/$(LLVM_PREBUILTS_PATH)
TRUSTY_ENV_VAR += COMPILE_TOOLCHAIN=$(YOCTO_CROSSCOMPILE)
TRUSTY_ENV_VAR += TARGET_BUILD_VARIANT=$(TARGET_BUILD_VARIANT)
TRUSTY_ENV_VAR += BOOT_ARCH=project-celadon

# output build dir to android out folder
TRUSTY_ENV_VAR += BUILD_DIR=$(TRUSTY_BUILDROOT)
ifeq ($(LKDEBUG),2)
TRUSTY_ENV_VAR += LKBIN_DIR=$(PWD)/vendor/intel/fw/trusty-release-binaries/debug/
else
TRUSTY_ENV_VAR += LKBIN_DIR=$(PWD)/vendor/intel/fw/trusty-release-binaries/
endif

#Fix the cpu hotplug fail due to the trusty.
#Trusty will introduce some delay for cpu_up().
#Experiment show need wait at least 60us after
#apic_icr_write(APIC_DM_STARTUP | (start_eip >> 12), phys_apicid);
#So here override the cpu_init_udelay to have the cpu wait for 300us
#to guarantee the cpu_up success.
BOARD_KERNEL_CMDLINE += cpu_init_udelay=10

#TOS_PREBUILT := $(PWD)/$(INTEL_PATH_VENDOR)/fw/evmm/tos.img
#EVMM_PREBUILT := $(PWD)/$(INTEL_PATH_VENDOR)/fw/evmm/multiboot.img
##############################################################
# Source: device/intel/mixins/groups/firststage-mount/true/BoardConfig.mk
##############################################################
BOARD_FIRSTSTAGE_MOUNT_ENABLE := true
FIRSTSTAGE_MOUNT_SSDT = $(PRODUCT_OUT)/firststage-mount.aml
##############################################################
# Source: device/intel/mixins/groups/vendor-partition/true/BoardConfig.mk
##############################################################
# Those 3 lines are required to enable vendor image generation.
# Remove them if vendor partition is not used.
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
VENDOR_PARTITION_SIZE := $(shell echo 600*1048576 | bc)
AB_OTA_PARTITIONS += vendor
##############################################################
# Source: device/intel/mixins/groups/acpio-partition/true/BoardConfig.mk
##############################################################
TARGET_USE_ACPIO := true
BOARD_ACPIOIMAGE_PARTITION_SIZE := $$((2 * 1024 *1024))

AB_OTA_PARTITIONS += acpio
##############################################################
# Source: device/intel/mixins/groups/config-partition/true/BoardConfig.mk
##############################################################
BOARD_CONFIGIMAGE_PARTITION_SIZE := 8388608
BOARD_SEPOLICY_M4DEFS += module_config_partition=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/config-partition
##############################################################
# Source: device/intel/mixins/groups/product-partition/true/BoardConfig.mk
##############################################################
# Those 3 lines are required to enable product image generation.
# Remove them if product partition is not used.
TARGET_COPY_OUT_PRODUCT := product
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
PRODUCT_PARTITION_SIZE := $(shell echo 100*1048576 | bc)
TARGET_USE_PRODUCT := true
AB_OTA_PARTITIONS += product
##############################################################
# Source: device/intel/mixins/groups/odm-partition/true/BoardConfig.mk
##############################################################
# Those 3 lines are required to enable odm image generation.
# Remove them if odm partition is not used.
TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
ODM_PARTITION_SIZE := $(shell echo 100*1048576 | bc)
TARGET_USE_ODM := true
AB_OTA_PARTITIONS += odm
##############################################################
# Source: device/intel/mixins/groups/cpu-arch/x86/BoardConfig.mk
##############################################################
BUILD_CPU_ARCH ?= silvermont

# Items that are common between slm 32b and 64b:
TARGET_CPU_ABI_LIST_32_BIT := x86
TARGET_ARCH_VARIANT := $(if $(BUILD_CPU_ARCH),$(BUILD_CPU_ARCH),x86)
TARGET_CPU_SMP := true

ifeq ($(BOARD_USE_64BIT_USERSPACE),true)
# 64b-specific items:
TARGET_ARCH := x86_64
TARGET_CPU_ABI := x86_64
TARGET_2ND_CPU_ABI := x86
TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := $(if $(BUILD_CPU_ARCH),$(BUILD_CPU_ARCH))
TARGET_2ND_CPU_VARIANT := $(if $(BUILD_CPU_ARCH),$(BUILD_CPU_ARCH))
else
# 32b-specific items:
TARGET_ARCH := x86
TARGET_CPU_ABI := x86
endif
##############################################################
# Source: device/intel/mixins/groups/allow-missing-dependencies/true/BoardConfig.mk
##############################################################
ALLOW_MISSING_DEPENDENCIES := true
##############################################################
# Source: device/intel/mixins/groups/dexpreopt/true/BoardConfig.mk
##############################################################
# enable dex-preoptimization.
WITH_DEXPREOPT := true
##############################################################
# Source: device/intel/mixins/groups/media/auto/BoardConfig.mk
##############################################################
INTEL_STAGEFRIGHT := true

# Settings for the Media SDK library and plug-ins:
# - USE_MEDIASDK: use Media SDK support or not
USE_MEDIASDK := true
##############################################################
# Source: device/intel/mixins/groups/graphics/auto/BoardConfig.mk
##############################################################
# Use external/drm-bxt
TARGET_USE_PRIVATE_LIBDRM := true
LIBDRM_VER ?= intel

BOARD_KERNEL_CMDLINE += vga=current i915.modeset=1 drm.atomic=1 i915.nuclear_pageflip=1 drm.vblankoffdelay=1 i915.fastboot=1

ifeq ($(BASE_YOCTO_KERNEL),true)
BOARD_KERNEL_CMDLINE += i915.enable_guc=2
endif

USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
USE_INTEL_UFO_DRIVER := false
BOARD_GPU_DRIVERS := i965 virgl
BOARD_USE_CUSTOMIZED_MESA := true

# System's VSYNC phase offsets in nanoseconds
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 3000000

BOARD_GPU_DRIVERS ?= i965 swrast virgl
ifneq ($(strip $(BOARD_GPU_DRIVERS)),)
TARGET_HARDWARE_3D := true
TARGET_USES_HWC2 := true
endif

BOARD_USES_DRM_HWCOMPOSER := true
BOARD_USES_IA_PLANNER := true

BOARD_USES_IA_HWCOMPOSER := true

BOARD_USES_MINIGBM := true
BOARD_ENABLE_EXPLICIT_SYNC := true
INTEL_MINIGBM := $(INTEL_PATH_HARDWARE)/external/minigbm-intel


BOARD_USES_GRALLOC1 := true


BOARD_THREEDIS_UNDERRUN_WA := true


BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/graphics/mesa


BOARD_SEPOLICY_M4DEFS += module_hwc_info_service=true

##############################################################
# Source: device/intel/mixins/groups/ethernet/dhcp/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/ethernet/common
##############################################################
# Source: device/intel/mixins/groups/camera-ext/ext-camera-only/BoardConfig.mk
##############################################################
# Enable only USB camera and disable all CSI Cameras
BOARD_CAMERA_USB_STANDALONE = true

# SELinux support for USB camera
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/camera-ext/ext-camera-only
##############################################################
# Source: device/intel/mixins/groups/rfkill/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/rfkill
##############################################################
# Source: device/intel/mixins/groups/usb-gadget/auto/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/usb-gadget/configfs
##############################################################
# Source: device/intel/mixins/groups/navigationbar/true/BoardConfig.mk
##############################################################
DEVICE_PACKAGE_OVERLAYS += $(INTEL_PATH_COMMON)/navigationbar/overlay

##############################################################
# Source: device/intel/mixins/groups/debug-tools/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/debug-tools/androidterm
##############################################################
# Source: device/intel/mixins/groups/default-drm/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/drm-default
##############################################################
# Source: device/intel/mixins/groups/thermal/thermal-daemon/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += device/intel/sepolicy/thermal
BOARD_SEPOLICY_DIRS += device/intel/sepolicy/thermal/thermal-daemon
##############################################################
# Source: device/intel/mixins/groups/serialport/ttyS0/BoardConfig.mk
##############################################################
ifneq ($(TARGET_BUILD_VARIANT),user)
BOARD_KERNEL_CMDLINE += console=ttyS0,115200n8
endif
##############################################################
# Source: device/intel/mixins/groups/flashfiles/ini/BoardConfig.mk
##############################################################
FLASHFILES_CONFIG ?= $(TARGET_DEVICE_DIR)/flashfiles.ini
USE_INTEL_FLASHFILES := true
VARIANT_SPECIFIC_FLASHFILES ?= false
FAST_FLASHFILES := false
##############################################################
# Source: device/intel/mixins/groups/debug-crashlogd/true/BoardConfig.mk
##############################################################
ifeq ($(MIXIN_DEBUG_LOGS),true)
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/crashlogd
BOARD_SEPOLICY_M4DEFS += module_debug_crashlogd=true
endif
##############################################################
# Source: device/intel/mixins/groups/power/true/BoardConfig.mk
##############################################################

POWER_THROTTLE := true


BOARD_SEPOLICY_M4DEFS += module_power=true
#BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/power
##############################################################
# Source: device/intel/mixins/groups/intel_prop/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/intel_prop

ifneq ($(KERNELFLINGER_SUPPORT_NON_EFI_BOOT), true)
INTEL_PROP_LIBDMI := true
endif

##############################################################
# Source: device/intel/mixins/groups/memtrack/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/memtrack
##############################################################
# Source: device/intel/mixins/groups/abota-fw/true/BoardConfig.mk
##############################################################
ABOTA_BOOTARCH=project-celadon

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/generic
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/abota/generic/vendor_prefix


##############################################################
# Source: device/intel/mixins/groups/usb-init/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/usb-init
##############################################################
# Source: device/intel/mixins/groups/usb-otg-switch/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/usb-role-switch
##############################################################
# Source: device/intel/mixins/groups/vndk/true/BoardConfig.mk
##############################################################
BOARD_VNDK_VERSION := current
##############################################################
# Source: device/intel/mixins/groups/hdcpd/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/hdcpd
##############################################################
# Source: device/intel/mixins/groups/load_modules/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS +=  $(INTEL_PATH_SEPOLICY)/load_modules

TARGET_FS_CONFIG_GEN += $(INTEL_PATH_COMMON)/load_modules/filesystem_config/config.fs

##############################################################
# Source: device/intel/mixins/groups/swap/zram_auto/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/swap
BOARD_SEPOLICY_M4DEFS += module_swap=true
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/low-mem
BOARD_SEPOLICY_M4DEFS += module_low-mem=true
##############################################################
# Source: device/intel/mixins/groups/psdapp/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/psdapp
TARGET_FS_CONFIG_GEN += $(INTEL_PATH_COMMON)/psdapp/filesystem_config/config.fs
##############################################################
# Source: device/intel/mixins/groups/debugfs/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/debugfs
##############################################################
# Source: device/intel/mixins/groups/factory-scripts/true/BoardConfig.mk
##############################################################
# Include factory archive in 'make dist' output
TARGET_BUILD_INTEL_FACTORY_SCRIPTS := true

##############################################################
# Source: device/intel/mixins/groups/filesystem_config/common/BoardConfig.mk
##############################################################
TARGET_FS_CONFIG_GEN += $(INTEL_PATH_COMMON)/filesystem_config/config.fs
##############################################################
# Source: device/intel/mixins/groups/gptbuild/true/BoardConfig.mk
##############################################################
# can't use := here, as PRODUCT_OUT is not defined yet
BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true
GPTIMAGE_BIN = $(PRODUCT_OUT)/$(TARGET_PRODUCT).img

BOARD_FLASHFILES += $(GPTIMAGE_BIN):$(TARGET_PRODUCT).img

ifeq ($(TARGET_USE_TRUSTY),true)
TRUSTY_ENV_VAR += ENABLE_TRUSTY_SIMICS=true
endif

COMPRESS_GPTIMAGE ?= true

ifeq ($(COMPRESS_GPTIMAGE), true)
GPTIMAGE_GZ ?= $(GPTIMAGE_BIN).gz
endif
##############################################################
# Source: device/intel/mixins/groups/dbc/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/dbc
##############################################################
# Source: device/intel/mixins/groups/aaf/true/BoardConfig.mk
##############################################################
BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/aafd
##############################################################
# Source: device/intel/mixins/groups/sensors/mediation/BoardConfig.mk
##############################################################
USE_SENSOR_MEDIATION_HAL := true

BOARD_SEPOLICY_DIRS += $(INTEL_PATH_SEPOLICY)/sensors/mediation
# ------------------ END MIX-IN DEFINITIONS ------------------
