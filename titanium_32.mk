DEVICE_PACKAGE_OVERLAYS := device/qcom/titanium_32/overlay

TARGET_USES_QCOM_BSP := true

# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
TARGET_USES_NQ_NFC := true

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# media_profiles and media_codecs xmls for titanium
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/titanium_32/media/media_profiles_titanium.xml:system/etc/media_profiles.xml \
                      device/qcom/titanium_32/media/media_codecs_titanium.xml:system/etc/media_codecs.xml \
                      device/qcom/titanium_32/media/media_codecs_performance_titanium.xml:system/etc/media_codecs_performance.xml
endif

PRODUCT_COPY_FILES += device/qcom/titanium_32/whitelistedapps.xml:system/etc/whitelistedapps.xml

PRODUCT_PROPERTY_OVERRIDES += \
       dalvik.vm.heapminfree=6m \
       dalvik.vm.heapstartsize=14m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := titanium_32
PRODUCT_DEVICE := titanium_32

ifeq ($(strip $(TARGET_USES_QTIC)),true)
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
    MULTI_LANG_ENGINE := REVERIE
#   MULTI_LANG_ZAWGYI := REVERIE
endif
endif

PRODUCT_BOOT_JARS += qcmediaplayer \
                     vcard \
                     com.qti.dpmframework
ifneq ($(strip $(QCPATH)),)
    PRODUCT_BOOT_JARS += qcom.fmradio
    PRODUCT_BOOT_JARS += WfdCommon
    PRODUCT_BOOT_JARS += oem-services
    PRODUCT_BOOT_JARS += tcmiface
    PRODUCT_BOOT_JARS += dpmapi
    PRODUCT_BOOT_JARS += com.qti.location.sdk
endif

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8953/msm8953.mk

# ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

# NFC
ifeq ($(strip $(TARGET_USES_NQ_NFC)),true)
PRODUCT_PACKAGES += \
    NQNfcNci \
    libnqnfc-nci \
    libnqnfc_nci_jni \
    nfc_nci.nqx.default \
    libp61-jcop-kit \
    com.nxp.nfc.nq \
    com.nxp.nfc.nq.xml \
    libpn547_fw.so \
    libpn548ad_fw.so \
    libnfc-brcm.conf \
    libnfc-nxp.conf \
    nqnfcee_access.xml \
    nqnfcse_access.xml \
    Tag \
    com.android.nfc_extras \
    libQPayJNI \
    com.android.qti.qpay \
    com.android.qti.qpay.xml \
    SmartcardService \
    org.simalliance.openmobileapi \
    org.simalliance.openmobileapi.xml

PRODUCT_COPY_FILES += \
    packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml

# SmartcardService, SIM1,SIM2,eSE1 not including eSE2,SD1 as default
ADDITIONAL_BUILD_PROPERTIES += persist.nfc.smartcard.config=SIM1,SIM2,eSE1
endif # TARGET_USES_NQ_NFC

# Feature definition files for titanium
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown

PRODUCT_PACKAGES += wcnss_service

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/qcom/titanium_32/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/titanium_32/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/titanium_32/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin \
    device/qcom/titanium_32/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat


PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf
#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

# Defined the locales
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN

# Add the overlay path
ifeq ($(strip $(TARGET_USES_QTIC)),true)
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)
endif

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
     device/qcom/titanium_32/sensors/hals.conf:system/etc/sensors/hals.conf

# Disable Verity boot feature
PRODUCT_SUPPORTS_VERITY := true

