INSTALL_TARGET_PROCESSES = Preferences

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = AlwaysClearPreferences

AlwaysClearPreferences_FILES = ACPRootListController.m
AlwaysClearPreferences_INSTALL_PATH = /Library/PreferenceBundles
AlwaysClearPreferences_FRAMEWORKS = UIKit
AlwaysClearPreferences_PRIVATE_FRAMEWORKS = Preferences
AlwaysClearPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/AlwaysClearPreferences.plist$(ECHO_END)
