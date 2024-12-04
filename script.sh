#!/bin/bash
# Initialize ROM manifest
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh
# remove device tree
rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf vendor/oneplus/fajita
rm -rf hardware/oneplus
# cloning device tree
git clone https://github.com/LineageOS/android_device_oneplus_fajita.git device/oneplus/fajita
git clone https://github.com/LineageOS/android_device_oneplus_sdm845-common.git device/oneplus/sdm845-common
# cloning kernel tree
git clone https://github.com/LineageOS/android_kernel_oneplus_sdm845.git kernel/oneplus/sdm845
# cloning vendor tree
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita.git vendor/oneplus/fajita
git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_sdm845-common.git vendor/oneplus/sdm845-common
# cloning hardware tree
git clone https://github.com/LineageOS/android_hardware_oneplus.git hardware/oneplus
# Set up the build environment
source build/envsetup.sh
# Choose the target device
lunch lineage_fajita-ap2a-userdebug
# Build the ROM (use mka bacon for a full build)
make installclean
mka bacon
