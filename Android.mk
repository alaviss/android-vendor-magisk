LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := magiskconfig
LOCAL_MODULE_STEM := .magisk
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/.backup
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES := magisk.conf
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := magisk32.xz
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/overlay.d/sbin

LOCAL_MODULE_TARGET_ARCH := arm arm64

intermediates := $(call local-generated-sources-dir)
GEN := $(intermediates)/magisk32.xz

ifneq ($(filter arm%,$(call get-prebuilt-src-arch,$(LOCAL_MODULE_TARGET_ARCH))),)
$(GEN): PRIVATE_CUSTOM_TOOL = unzip -p $< lib/armeabi-v7a/libmagisk32.so | xz -c -9 --check=crc32 > $@
endif
$(GEN): $(LOCAL_PATH)/Magisk.apk
	$(call transform-generated-source)

LOCAL_PREBUILT_MODULE_FILE := $(GEN)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := magisk64.xz
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/overlay.d/sbin

LOCAL_MODULE_TARGET_ARCH := arm64

intermediates := $(call local-generated-sources-dir)
GEN := $(intermediates)/magisk64.xz

ifneq ($(filter arm%,$(call get-prebuilt-src-arch,$(LOCAL_MODULE_TARGET_ARCH))),)
$(GEN): PRIVATE_CUSTOM_TOOL = unzip -p $< lib/arm64-v8a/libmagisk64.so | xz -c -9 --check=crc32 > $@
endif
$(GEN): $(LOCAL_PATH)/Magisk.apk
	$(call transform-generated-source)

LOCAL_PREBUILT_MODULE_FILE := $(GEN)
include $(BUILD_PREBUILT)
