ARCHS = arm64

INSTALL_TARGET_PROCESSES = Music

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AlwaysClear

AlwaysClear_FILES = Tweak.x
AlwaysClear_EXTRA_FRAMEWORKS += Cephei
AlwaysClear_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += alwaysclearpreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
