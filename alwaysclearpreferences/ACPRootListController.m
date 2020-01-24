#import <Preferences/PSSpecifier.h>
#include "ACPRootListController.h"

@implementation ACPRootListController
- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}
@end
