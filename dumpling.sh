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
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="
# Clone local_manifests repository
#git clone https://github.com/Suraj-Sangwan/local_manifests --depth 1 -b dumpling .repo/local_manifests
#echo "============================"
#echo "Local manifest clone success"
#echo "============================"
#clone kernelsu
git clone https://github.com/KernelSU-Next/KernelSU-Next --depth 1 -b next kernel/oneplus/msm8998/KernelSU-Next
# Sync the repositories
if [ -f /opt/crave/resync.sh ]; then
  /opt/crave/resync.sh
else
  repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
fi
repo forall -c 'git lfs install && git lfs pull && git lfs checkout' 
echo "============SYNC DONE================"
# Set up the build environment
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_IGNORE_NEVERALLOWS=true
echo "====== Envsetup Done ======="
# Choose the target device
lunch lineage_dumpling-bp1a-userdebug
echo "======LUNCH DONE======="
# Build the ROM (use mka bacon for a full build)
m evolution