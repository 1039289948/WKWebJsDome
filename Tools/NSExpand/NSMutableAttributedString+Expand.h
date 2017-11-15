//
//  NSMutableAttributedString+Expand.h
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (Expand)

- (NSMutableAttributedString *)ex_setStringColor:(UIColor *)rangeColor withString:(NSString *)string;

- (NSMutableAttributedString *)ex_setStringFont:(UIFont *)rangeFont withString:(NSString *)string;

- (NSMutableAttributedString *)ex_setStringFont:(UIFont *)rangeFont withColor:(UIColor *)rangeColor withString:(NSString *)string;


@end
