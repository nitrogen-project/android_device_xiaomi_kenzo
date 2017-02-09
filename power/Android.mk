LOCAL_PATH := $(call my-dir)

#ifeq ($(call is-vendor-board-platform,QCOM),true)

# HAL module implemenation stored in
# hw/<POWERS_HARDWARE_MODULE_ID>.<ro.hardware>.so
include $(CLEAR_VARS)

LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_SHARED_LIBRARIES := liblog libcutils libdl
LOCAL_SRC_FILES := power.c metadata-parser.c utils.c list.c hint-data.c

# Include target-specific files.
ifneq ($(filter msm8974,$(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES += power-8974.c
endif

ifneq ($(filter msm8226,$(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES += power-8226.c
endif

ifneq ($(filter msm8610,$(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES += power-8610.c
endif

ifneq ($(filter apq8084,$(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES += power-8084.c
endif

ifneq ($(filter msm8909,$(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES += power-8909.c
endif

ifneq ($(filter msm8916,$(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES += power-8916.c
endif

ifneq ($(filter msm8952,$(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES += power-8952.c
endif

ifeq ($(TARGET_USES_INTERACTION_BOOST),true)
    LOCAL_CFLAGS += -DINTERACTION_BOOST
endif

LOCAL_MODULE := power.$(TARGET_BOARD_PLATFORM)
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

#endif
