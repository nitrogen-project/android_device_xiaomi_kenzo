#
# Copyright (C) 2015 The Android Open-Source Project
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

DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi
# A list of dpis to select prebuilt apk, in precedence order.
PRODUCT_AAPT_PREBUILT_DPI := xxhdpi xhdpi hdpi

# kernel
PRODUCT_PACKAGES += \
    kernel

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    vold.fstab \
    init.class_main.sh \
    init.qcom.class_core.sh \
    init.qcom.early_boot.sh \
    init.qcom.post_boot.sh \
    init.qcom.qseecomd.sh \
    init.qcom.zram.sh \
    init.qcom.rc \
    init.qcom.sh \
    init.qcom.syspart_fixup.sh \
    init.qcom.usb.rc \
    init.qcom.usb.sh \
    init.qcom.bt.sh \
    init.qcom.fm.sh \
    init.target.rc \
    ueventd.qcom.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.hdmi.cec.xml:system/etc/permissions/android.hardware.hdmi.cec.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.vr.high_performance.xml:system/etc/permissions/android.hardware.vr.high_performance.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:system/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/xiaomi/kenzo/audio/audio_policy.conf:system/etc/audio_policy.conf \
    device/xiaomi/kenzo/audio/audio_output_policy.conf:system/vendor/etc/audio_output_policy.conf \
    device/xiaomi/kenzo/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/xiaomi/kenzo/audio/mixer_paths_mtp.xml:system/etc/mixer_paths_mtp.xml \
    device/xiaomi/kenzo/audio/mixer_paths_qrd_skuh.xml:system/etc/mixer_paths_qrd_skuh.xml \
    device/xiaomi/kenzo/audio/mixer_paths_qrd_skui.xml:system/etc/mixer_paths_qrd_skui.xml \
    device/xiaomi/kenzo/audio/mixer_paths_qrd_skuhf.xml:system/etc/mixer_paths_qrd_skuhf.xml \
    device/xiaomi/kenzo/audio/mixer_paths_qrd_skum.xml:system/etc/mixer_paths_qrd_skum.xml \
    device/xiaomi/kenzo/audio/mixer_paths_qrd_skun_cajon.xml:system/etc/mixer_paths_qrd_skun_cajon.xml \
    device/xiaomi/kenzo/audio/mixer_paths_wcd9330.xml:system/etc/mixer_paths_wcd9330.xml \
    device/xiaomi/kenzo/audio/mixer_paths_wcd9306.xml:system/etc/mixer_paths_wcd9306.xml \
    device/xiaomi/kenzo/audio/mixer_paths_wcd9335.xml:system/etc/mixer_paths_wcd9335.xml \
    device/xiaomi/kenzo/audio/mixer_paths_wcd9326.xml:system/etc/mixer_paths_wcd9326.xml \
    device/xiaomi/kenzo/audio/mixer_paths_qrd_skun.xml:system/etc/mixer_paths_qrd_skun.xml \
    device/xiaomi/kenzo/audio/mixer_paths_skuk.xml:system/etc/mixer_paths_skuk.xml \
    device/xiaomi/kenzo/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/xiaomi/kenzo/audio/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/xiaomi/kenzo/audio/sound_trigger_mixer_paths_wcd9306.xml:system/etc/sound_trigger_mixer_paths_wcd9306.xml \
    device/xiaomi/kenzo/audio/sound_trigger_mixer_paths_wcd9330.xml:system/etc/sound_trigger_mixer_paths_wcd9330.xml \
    device/xiaomi/kenzo/audio/sound_trigger_mixer_paths_wcd9335.xml:system/etc/sound_trigger_mixer_paths_wcd9335.xml \
    device/xiaomi/kenzo/audio/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/xiaomi/kenzo/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    device/xiaomi/kenzo/audio/audio_platform_info_extcodec.xml:system/etc/audio_platform_info_extcodec.xml \
    device/xiaomi/kenzo/audio/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt

# Audio ACDB stuff
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Speaker_cal.acdb:system/etc/acdbdata/MTP/MTP_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Hdmi_cal.acdb:system/etc/acdbdata/MTP/MTP_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/MTP_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_General_cal.acdb:system/etc/acdbdata/MTP/MTP_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Global_cal.acdb:system/etc/acdbdata/MTP/MTP_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Headset_cal.acdb:system/etc/acdbdata/MTP/MTP_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/MTP_Handset_cal.acdb:system/etc/acdbdata/MTP/MTP_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/QRD_Speaker_cal.acdb:system/etc/acdbdata/QRD/QRD_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/QRD_Hdmi_cal.acdb:system/etc/acdbdata/QRD/QRD_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/QRD_Bluetooth_cal.acdb:system/etc/acdbdata/QRD/QRD_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/QRD_General_cal.acdb:system/etc/acdbdata/QRD/QRD_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/QRD_Global_cal.acdb:system/etc/acdbdata/QRD/QRD_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/QRD_Headset_cal.acdb:system/etc/acdbdata/QRD/QRD_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/QRD_Handset_cal.acdb:system/etc/acdbdata/QRD/QRD_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Handset_cal.acdb:system/etc/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Hdmi_cal.acdb:system/etc/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Headset_cal.acdb:system/etc/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_General_cal.acdb:system/etc/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Global_cal.acdb:system/etc/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Speaker_cal.acdb:system/etc/acdbdata/MTP/msm8952-tomtom-snd-card/MTP_WCD9330_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Handset_cal.acdb:system/etc/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Hdmi_cal.acdb:system/etc/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Headset_cal.acdb:system/etc/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_General_cal.acdb:system/etc/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Global_cal.acdb:system/etc/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Speaker_cal.acdb:system/etc/acdbdata/MTP/msm8976-tasha-snd-card/MTP_WCD9335_Speaker_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Handset_cal.acdb:system/etc/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Handset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Bluetooth_cal.acdb:system/etc/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Hdmi_cal.acdb:system/etc/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Hdmi_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Headset_cal.acdb:system/etc/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Headset_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_General_cal.acdb:system/etc/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_General_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Global_cal.acdb:system/etc/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Global_cal.acdb \
    $(LOCAL_PATH)/audio/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Speaker_cal.acdb:system/etc/acdbdata/QRD/msm8976-skun-snd-card/QRD_SKUN_Speaker_cal.acdb


PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio.primary.msm8952 \
    audio.r_submix.default \
    audio.usb.default \
    tinymix

PRODUCT_PACKAGES += \
    libaudio-resampler \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing

PRODUCT_PACKAGES += \
    libOmxAacEnc \
    libOmxQcelp13Enc \
    libOmxEvrcEnc \
    libOmxAmrEnc

# Display
PRODUCT_PACKAGES += \
    copybit.msm8952 \
    gralloc.msm8952 \
    hdmi_cec.msm8952 \
    hwcomposer.msm8952 \
    memtrack.msm8952 \
    liboverlay

# Light
PRODUCT_PACKAGES += \
    lights.msm8952

# Power
PRODUCT_PACKAGES += \
    power.msm8952

# GPS
PRODUCT_PACKAGES += \
    com.android.location.provider \
    gps.msm8952

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/configs/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/configs/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/configs/lowi.conf:system/etc/lowi.conf \
    $(LOCAL_PATH)/configs/sap.conf:system/etc/sap.conf \
    $(LOCAL_PATH)/configs/xtwifi.conf:system/etc/xtwifi.conf \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

PRODUCT_COPY_FILES += \
    device/xiaomi/kenzo/configs/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf \
    device/xiaomi/kenzo/configs/msm_irqbalance_little_big.conf:system/vendor/etc/msm_irqbalance_little_big.conf

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/ft5x06_ts.kl:system/usr/keylayout/ft5x06_ts.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/synaptics_dsx.kl:system/usr/keylayout/synaptics_dsx.kl \
    $(LOCAL_PATH)/keylayout/synaptics_rmi4_i2c.kl:system/usr/keylayout/synaptics_rmi4_i2c.kl \
    $(LOCAL_PATH)/keylayout/msm8976-tashalite-snd-card_Button_Jack.kl:system/usr/keylayout/msm8976-tashalite-snd-card_Button_Jack.kl \
    $(LOCAL_PATH)/keylayout/uinput-fpc.kl:system/usr/keylayout/uinput-fpc.kl

# Media profile
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_codecs_performance.xml:system/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_profiles_8956.xml:system/etc/media_profiles_8956.xml \

# Media
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libdivxdrmdecrypt \
    libdashplayer \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc \
    libstagefrighthw \

# Sensors
PRODUCT_PACKAGES += \
    sensors.kenzo

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensor_def_qcomdev.conf:system/etc/sensors/sensor_def_qcomdev.conf \
    $(LOCAL_PATH)/configs/hals.conf:system/etc/sensors/hals.conf

# wlan driver
PRODUCT_PACKAGES += \
    WCNSS_cfg.dat

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_sdio_cfg.ini:system/etc/wifi/WCNSS_qcom_sdio_cfg.ini

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf \
    hostapd_default.conf \
    hostapd.accept \
    hostapd.deny

# Camera
PRODUCT_PACKAGES += \
    Snap \
    camera.msm8952

# Fingerprint
PRODUCT_PACKAGES += \
    fingerprintd

# FM radio  
PRODUCT_PACKAGES += \
    FM2 \
    libqcomfm_jni \
    qcom.fmradio \
    qcom.fmradio.xml

# Consumerir
PRODUCT_PACKAGES += \
    consumerir.msm8952

# RIL
PRODUCT_PACKAGES += \
    libril_proxy \
    librmnetctl \
    libxml2

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/mbn_ota.txt:system/etc/mbn_ota.txt

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/dsi_config.xml:system/etc/data/dsi_config.xml \
    $(LOCAL_PATH)/configs/netmgr_config.xml:system/etc/data/netmgr_config.xml \
    $(LOCAL_PATH)/configs/qmi_config.xml:system/etc/data/qmi_config.xml

# IPACM
PRODUCT_PACKAGES += \
    IPACM_cfg.xml \
    ipacm \
    libipanat

# Thermal
PRODUCT_PACKAGES += \
    thermal.kenzo

PRODUCT_COPY_FILES += \
    device/xiaomi/kenzo/configs/thermal-engine-8956.conf:system/etc/thermal-engine-8956.conf

# for off charging mode
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystem management tools
PRODUCT_PACKAGES += \
    e2fsck \
    make_ext4fs \
    setup_fs

# for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

# Misc dependency packages
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    curl \
    libcurl \
    libnl_2 \
    libbson \
    libcnefeatureconfig \
    libtinyxml

PRODUCT_PACKAGES += \
    Eleven \
    Browser

# setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)


# Board platforms lists to be used for
# TARGET_BOARD_PLATFORM specific featurization
QCOM_BOARD_PLATFORMS := msm8952

# List of targets that use video hw
MSM_VIDC_TARGET_LIST := msm8952

$(call inherit-product, device/xiaomi/kenzo/utils.mk)

