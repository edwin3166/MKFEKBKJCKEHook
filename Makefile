ARCHS = arm64
TARGET = iphone:clang:latest:15.0

THEOS_PACKAGE_SCHEME = rootless
DEBUG = 0
FINALPACKAGE = 1

INSTALL_TARGET_PROCESSES = FreeFire

TWEAK_NAME = FFHook

FFHook_FILES = Tweak.xm
FFHook_CFLAGS = -fobjc-arc
FFHook_FRAMEWORKS = UIKit Foundation QuartzCore

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
