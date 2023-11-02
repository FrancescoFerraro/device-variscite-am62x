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

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/ti/am62x/device.mk)

PRODUCT_NAME := am62x-var-som
PRODUCT_DEVICE := am62x-var-som
PRODUCT_BRAND := TI
PRODUCT_MODEL := AOSP on VAR-SOM-AM62X
PRODUCT_MANUFACTURER := Variscite
PRODUCT_CHARACTERISTICS := tablet


PRODUCT_PROPERTY_OVERRIDES += \
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

# Set SOC information
PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=$(PRODUCT_MANUFACTURER) \
    ro.soc.model=$(PRODUCT_DEVICE)

# clean-up all unknown PRODUCT_PACKAGES
allowed_list := product_manifest.xml
$(call enforce-product-packages-exist, $(allowed_list))

include device/ti/am62x/optee/device-optee.mk
