//
//  NSMutableAttributedString+Expand.m
//  WisdomFrontDesk_PadHD
//
//

#import "NSMutableAttributedString+Expand.h"
#import "NSString+Expand.h"

@implementation NSMutableAttributedString (Expand)

- (NSMutableAttributedString *)ex_setStringColor:(UIColor *)rangeColor withString:(NSString *)string{
    NSRange range = [self.string rangeOfString:[NSString ex_stringWithId:string]];
    [self addAttributes:@{NSForegroundColorAttributeName:rangeColor} range:range];
    return self;
}

- (NSMutableAttributedString *)ex_setStringFont:(UIFont *)rangeFont withString:(NSString *)string{
    NSRange range = [self.string rangeOfString:[NSString ex_stringWithId:string]];
    [self addAttributes:@{NSFontAttributeName:rangeFont} range:range];
    return self;
}

- (NSMutableAttributedString *)ex_setStringFont:(UIFont *)rangeFont withColor:(UIColor *)rangeColor withString:(NSString *)string{
    NSRange range = [self.string rangeOfString:[NSString ex_stringWithId:string]];
    [self addAttributes:@{NSFontAttributeName:rangeFont,NSForegroundColorAttributeName:rangeColor} range:range];
    return  self;
}

@end
