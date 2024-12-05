#!/bin/bash
rm -rf .repo/local_manifests/
# remove device tree
rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf vendor/oneplus/fajita
rm -rf hardware/oneplus
# Initialize ROM manifest
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="
# Clone local_manifests repository
git clone -b main https://github.com/Suraj-Sangwan/local_manifests .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"
# Sync the repositories
/opt/crave/resync.sh
echo "============================"
# Set up the build environment
source build/envsetup.sh
export TARGET_RELEASE=ap2a
export ALLOW_MISSING_DEPENDENCIES=true
echo "====== Envsetup Done ======="
# Choose the target device
lunch lineage_fajita-ap2a-userdebug
echo "======LUNCH DONE======="
# Build the ROM (use mka bacon for a full build)
make installclean
mka bacon
