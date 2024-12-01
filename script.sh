git clone https://github.com/LineageOS/android_device_oneplus_fajita.git device/oneplus/fajita

git clone https://github.com/LineageOS/android_device_oneplus_sdm845-common.git device/oneplus/sdm845-common

git clone https://github.com/LineageOS/android_kernel_oneplus_sdm845.git kernel/oneplus/sdm845

git clone https://github.com/TheMuppets/proprietary_vendor_oneplus_fajita.git vendor/oneplus/fajita

git clone https://github.com/LineageOS/android_hardware_oneplus.git hardware/oneplus

repo sync

lunch lineage_fajita-userdebug

mka bacon