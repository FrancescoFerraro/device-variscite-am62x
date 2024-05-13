#
# Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com/
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
TARGET_KERNEL_USE ?= 6.1

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/ti/am62x/am62x/device.mk)

PRODUCT_NAME := am62x
PRODUCT_DEVICE := am62x
PRODUCT_BRAND := TI
PRODUCT_MODEL := AOSP on AM62X EVM
PRODUCT_MANUFACTURER := TexasInstruments
PRODUCT_CHARACTERISTICS := tablet

# Set lowram options
PRODUCT_VENDOR_PROPERTIES += \
    dalvik.vm.dex2oat64.enabled=false \
    dalvik.vm.heapstartsize=1m \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapsize=384m \
    dalvik.vm.heaptargetutilization=0.90 \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapmaxfree=2m \
    dalvik.vm.usejit=true \
    ro.lmk.medium=700 \
    ro.lmk.critical_upgrade=true \
    ro.lmk.upgrade_pressure=40 \
    ro.lmk.downgrade_pressure=60 \
    ro.lmk.kill_heaviest_task=false \
    pm.dexopt.downgrade_after_inactive_days=10 \
    pm.dexopt.shared=quicken

PRODUCT_VENDOR_PROPERTIES += \
     ro.config.low_ram=true

# Speed profile services and wifi-service to reduce RAM and storage.
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile

# Set SOC information
PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

# clean-up all unknown PRODUCT_PACKAGES
allowed_list := product_manifest.xml
$(call enforce-product-packages-exist, $(allowed_list))

include device/ti/am62x/optee/device-optee.mk

# Include vendor binaries
$(call inherit-product-if-exists, vendor/ti/am62x/am62x.mk)