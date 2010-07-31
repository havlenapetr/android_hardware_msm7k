BUILD_LIBCAMERA:= true
ifeq ($(BUILD_LIBCAMERA),true)

# When zero we link against libmmcamera; when 1, we dlopen libmmcamera.
DLOPEN_LIBMMCAMERA:=1

ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= QualcommCameraHardware.cpp

LOCAL_CFLAGS:= -DDLOPEN_LIBMMCAMERA=$(DLOPEN_LIBMMCAMERA)

LOCAL_C_INCLUDES+= \
	frameworks/base/include

LOCAL_SHARED_LIBRARIES:= libbinder libutils libcamera_client liblog

ifneq ($(DLOPEN_LIBMMCAMERA),1)
LOCAL_SHARED_LIBRARIES+= liboemcamera
else
LOCAL_SHARED_LIBRARIES+= libdl
endif

LOCAL_MODULE:= libcamera
include $(BUILD_SHARED_LIBRARY)

endif # BUILD_TINY_ANDROID
endif # BUILD_LIBCAMERA