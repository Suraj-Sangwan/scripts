#!/bin/bash
rm -rf .repo/local_manifests/
# remove device tree
rm -rf device/oneplus/dumpling
rm -rf device/oneplus/msm8998-common
rm -rf kernel/oneplus/msm8998
rm -rf vendor/oneplus/dumpling
rm -rf vendor/oneplus/msm8998-common
rm -rf hardware/oneplus
# Initialize ROM manifest
repo init -u https://github.com/RisingTechOSS/android -b fifteen --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="
# Clone local_manifests repository
git clone https://github.com/Suraj-Sangwan/local_manifests --depth 1 -b dumpling .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"
# Sync the repositories
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi
repo forall -c 'git lfs install && git lfs pull && git lfs checkout' 
echo "============SYNC DONE================"
# Set up the build environment
source build/envsetup.sh
#export TARGET_RELEASE=ap2a
export ALLOW_MISSING_DEPENDENCIES=true
echo "====== Envsetup Done ======="
# Choose the target device
riseup dumpling userdebug
mka installclean
echo "======LUNCH DONE======="
# Build the ROM (use mka bacon for a full build)
rise b