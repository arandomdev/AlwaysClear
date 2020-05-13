@interface UIAlertAction ()
@property (nonatomic,copy) void (^handler)(UIAlertAction *action);
@end

NSInteger ACMode = 1;

%hook MusicApplicationTabController
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
	if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {

		UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
		if (
			[alertController.message containsString:@"playing"]
			&& [alertController.message containsString:@"queue"]
		) {
			HBLogDebug(@"change with mode: %ld", ACMode);
			if (ACMode != 2) {
				UIAlertAction *clearAction = alertController.actions[ACMode];
				clearAction.handler(clearAction);
				
				if (completion) {
					completion();
				}
				return;
			}
		}
	}

	%orig;
}
%end

static void reloadPreferences() {
	NSString *preferencesFilePath = [NSString stringWithFormat:@"/User/Library/Preferences/com.haotestlabs.alwaysclearpreferences.plist"];
	
	NSData *fileData = [NSData dataWithContentsOfFile:preferencesFilePath];
	if (fileData) {
		NSError *error = nil;
		NSDictionary *preferences = [NSPropertyListSerialization propertyListWithData:fileData options:NSPropertyListImmutable format:nil error:&error];
		
		if (error) {
			HBLogError(@"Unable to read preference file, Error: %@", error);
		}
		else {
			if (preferences[@"ACMode"]) {
				ACMode = [preferences[@"ACMode"] intValue];
			}
		}
	}
}

%ctor {
	%init(MusicApplicationTabController = NSClassFromString(@"MusicApplication.TabBarController"));
	
	reloadPreferences();
	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		(CFNotificationCallback)reloadPreferences,
		CFSTR("com.haotestlabs.alwaysclearpreferences.reload"),
		NULL,
		CFNotificationSuspensionBehaviorCoalesce
	);
}
