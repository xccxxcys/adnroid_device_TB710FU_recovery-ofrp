#
# Copyright (C) 2025 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from this product for devices that support only 64-bit apps using:
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Configure virtual_ab compression.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Enable Project Quotas and Case Folding
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit some common twrp stuff.
$(call inherit-product, vendor/twrp/config/common.mk)

# Shipping API level
BOARD_SHIPPING_API_LEVEL    := 34
PRODUCT_SHIPPING_API_LEVEL  := 34
PRODUCT_TARGET_VNDK_VERSION := 34

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Kernel
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS   := false
PRODUCT_ENABLE_UFFD_GC                          := true

# OTA certs
PRODUCT_EXTRA_RECOVERY_KEYS += \
	$(DEVICE_PATH)/security/releasekey.x509.pem \
	$(DEVICE_PATH)/security/testkey_rsa2048.pem \
	$(DEVICE_PATH)/security/testkey_rsa4096.pem
	
# 新增PEM密钥文件复制（编译时同步到设备）
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/security/testkey_rsa2048.pem:$(TARGET_COPY_OUT_VENDOR)/etc/security/testkey_rsa2048.pem \
    $(DEVICE_PATH)/security/testkey_rsa4096.pem:$(TARGET_COPY_OUT_VENDOR)/etc/security/testkey_rsa4096.pem \
    $(DEVICE_PATH)/security/releasekey.x509.pem:$(TARGET_COPY_OUT_VENDOR)/etc/security/releasekey.x509.pem
    
# AVB2.0 签名密钥依赖（告知编译系统使用自定义密钥）
PRODUCT_AVB_KEYS += \
    $(DEVICE_PATH)/security/testkey_rsa2048.pem \
    $(DEVICE_PATH)/security/testkey_rsa4096.pem
    
# 禁用默认AVB密钥，强制使用自定义密钥
PRODUCT_AVB_DISABLE_DEFAULT_KEY := true

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)
