LOCAL_PATH := $(call my-dir)

ifeq ($(BOARD_MAGISK_PREINIT_DEVICE),)
    $(warning ***************************************************************)
    $(warning *                                                             *)
    $(warning * Since Magisk 26.0, a pre-init device must be declared at    *)
    $(warning * installation time. This value can be obtained by running    *)
    $(warning *                                                             *)
    $(warning *     magisk --preinit-device                                 *)
    $(warning *                                                             *)
    $(warning * on your device, root is not required.                       *)
    $(warning *                                                             *)
    $(warning * The magisk executable can be obtained from Magisk.apk as    *)
    $(warning * lib/<arch>/libmagisk[32|64].so. Set executable and rename   *)
    $(warning * to magisk then you can run it on your device.               *)
    $(warning *                                                             *)
    $(warning * Set BOARD_MAGISK_PREINIT_DEVICE in BoardConfig.mk to the    *)
    $(warning * obtained value.                                             *)
    $(warning *                                                             *)
    $(warning ***************************************************************)
    $(error "NO MAGISK PREINIT DEVICE")
endif

include $(CLEAR_VARS)
LOCAL_MODULE := magiskconfig
LOCAL_MODULE_STEM := .magisk
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/.backup
LOCAL_MODULE_CLASS := ETC

intermediates := $(call local-generated-sources-dir)
GEN := $(intermediates)/magisk.conf

$(GEN): PRIVATE_CUSTOM_TOOL = cp $< $@ \
	&& echo "RANDOMSEED=$$(tr -dc 'a-f0-9' < /dev/urandom | head -c 16)" >> $@ \
	&& echo "PREINITDEVICE=$(BOARD_MAGISK_PREINIT_DEVICE)" >> $@
$(GEN): $(LOCAL_PATH)/magisk.conf
	$(call transform-generated-source)

LOCAL_PREBUILT_MODULE_FILE := $(GEN)
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

include $(CLEAR_VARS)
LOCAL_MODULE := magiskstub.xz
LOCAL_MODULE_STEM := stub.xz
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/overlay.d/sbin

intermediates := $(call local-generated-sources-dir)
GEN := $(intermediates)/stub.xz

$(GEN): PRIVATE_CUSTOM_TOOL = unzip -p $< assets/stub.apk | xz -c -9 --check=crc32 > $@
$(GEN): $(LOCAL_PATH)/Magisk.apk
	$(call transform-generated-source)

LOCAL_PREBUILT_MODULE_FILE := $(GEN)
include $(BUILD_PREBUILT)
