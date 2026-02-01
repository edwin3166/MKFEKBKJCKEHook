TARGET := iphone:clang:latest:14.0
ARCHS = arm64

# ⚠️ TrollFools = NO instalación automática
INSTALL_TARGET_PROCESSES =
THEOS_PACKAGE_SCHEME =
FINALPACKAGE = 0

DEBUG = 0
GO_EASY_ON_ME = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = RobloxTF

RobloxTF_FILES = Tweak.xm
RobloxTF_CFLAGS = -fobjc-arc
RobloxTF_FRAMEWORKS = UIKit Foundation QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

# ⚠️ Evita intentar instalar
after-install::
	@echo "Build listo para TrollFools (solo dylib)"
