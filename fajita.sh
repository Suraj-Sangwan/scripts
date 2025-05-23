#!/bin/bash
rm -rf .repo/local_manifests/
# remove device tree
rm -rf device/oneplus/fajita
rm -rf device/oneplus/sdm845-common
rm -rf kernel/oneplus/sdm845
rm -rf vendor/oneplus/fajita
rm -rf vendor/oneplus/sdm845-common
rm -rf hardware/oneplus
# Initialize ROM manifest
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="
# Clone local_manifests repository
git clone https://github.com/Suraj-Sangwan/local_manifests --depth 1 -b main .repo/local_manifests
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
. build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export SELINUX_IGNORE_NEVERALLOWS=true
echo "====== Envsetup Done ======="
#Signing of build dependencies 
#croot && git clone https://github.com/Evolution-X/vendor_evolution-priv_keys-template vendor/evolution-priv/keys
#cd vendor/evolution-priv/keys
#./keys.sh
#croot
# Choose the target device
lunch lineage_fajita-bp1a-userdebug
echo "======LUNCH DONE======="
# Build the ROM (use mka bacon for a full build)
m evolution
