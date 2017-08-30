LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	ril_proxy.cpp

LOCAL_SHARED_LIBRARIES := \
	liblog \
	libutils \
	libdl

LOCAL_CFLAGS := -DRIL_SHLIB

ifeq ($(SIM_COUNT), 2)
    LOCAL_CFLAGS += -DANDROID_SIM_COUNT_2
endif

ifeq ($(TARGET_USE_LEGACY_SUPPORT),true)
LOCAL_SRC_FILES += \
    rild_socket.c
endif

LOCAL_MODULE:= libril_proxy
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

#endif
