#import <Cephei/HBPreferences.h>

@interface UIAlertAction ()
@property (nonatomic,copy) void (^handler)(UIAlertAction *action);
@end

HBPreferences *preferences;
NSInteger ACMode;

%hook MusicApplicationTabController
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
	if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {

		UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
		if ([alertController.message isEqual:@"After playing this, do you want to keep playing your Up Next queue?"]) {
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

%ctor {
	%init(MusicApplicationTabController = NSClassFromString(@"MusicApplication.TabBarController"));
	
	preferences = [[HBPreferences alloc] initWithIdentifier:@"com.haotestlabs.alwaysclearpreferences"];
	[preferences registerInteger:&ACMode default:1 forKey:@"mode"];
}
