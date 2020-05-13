export FINALPACKAGE = 1
export ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Music

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AlwaysClear

AlwaysClear_FILES = Tweak.x
AlwaysClear_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += alwaysclearpreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
