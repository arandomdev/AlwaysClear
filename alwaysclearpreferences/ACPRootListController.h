#import <Preferences/PSListController.h>

@interface ACPRootListController : PSListController
- (NSArray *)specifiers;
- (id)readPreferenceValue:(PSSpecifier *)specifier;
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier;
@end
