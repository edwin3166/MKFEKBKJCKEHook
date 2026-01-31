# Arquitectura y objetivo
ARCHS = arm64
TARGET = iphone:clang:latest:15.0

# Ruta correcta a Theos en GitHub Actions
THEOS := $(HOME)/theos

# Incluye common.mk desde Theos
include $(THEOS)/makefiles/common.mk

# Nombre del tweak y archivos fuente
TWEAK_NAME = MKFEKBKJCKEHook
MKFEKBKJCKEHook_FILES = Tweak.xm
MKFEKBKJCKEHook_CFLAGS = -fobjc-arc

# Incluye tweak.mk desde Theos
include $(THEOS_MAKE_PATH)/tweak.mk
