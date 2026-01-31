ARCHS = arm64
TARGET = iphone:clang:latest:15.0

export THEOS ?= $(HOME)/theos
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MKFEKBKJCKEHook
MKFEKBKJCKEHook_FILES = Tweak.xm
MKFEKBKJCKEHook_CFLAGS = -fobjc-arc -Wno-unused-function -Wno-deprecated-declarations -Wno-vla

include $(THEOS_MAKE_PATH)/tweak.mk
