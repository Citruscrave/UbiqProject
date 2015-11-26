#import <UIKit/UIKit.h>

@interface UITextField (Utilities) <UITextFieldDelegate>

+ (UITextField *)createGenericTextFieldWithPlaceholder:(NSString*)placeholder;

+ (UITextField *)createEmailAddressTextField;

+ (UITextField *)createPasswordTextField:(NSString *)passwordField;

+ (UITextField *)getNameTextField:(NSString*)name;

@end