//
//  Category.h
//  WisdomFrontDesk_PadHD
//
//  Created by bokaPM on 16/6/13.
//  Copyright © 2016年 iOSMax. All rights reserved.
//

#ifndef Category_h
#define Category_h


#import "NSString+Expand.h"
#import "NSDate+Expand.h"
#import "NSArray+Expand.h"

#import "NSMutableAttributedString+Expand.h"


#import "NSUserDefaultsKeys.h"


#endif /* Category_h */


/**
*弹框时间
*/
#define HUD_DELAY_TIME 0.7f

/**
 *  LoadTag
 */
#define LoadTag (10086)

//打印
#ifdef DEBUG
#define NLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#define NLog(...) NSLog(__VA_ARGS__)
#else
#define NLog(...)
#endif


/**
 *  懒加载
 */
#define M_LazyLoadMutableArray(obj, method) - (NSMutableArray *)method {\
if (obj == nil) {obj = [NSMutableArray array];}\
return obj;}

#define M_LazyLoadMutableDictionary(obj, method) - (NSMutableDictionary *)method {\
if (obj == nil) {obj = [NSMutableDictionary dictionary];}\
return obj;}

/** userDefaults */
#define M_USERDEFAULTS                 ([NSUserDefaults standardUserDefaults])
#define M_USERDEFAULTS_GET(key)        ([[NSUserDefaults standardUserDefaults] objectForKey:key])
#define M_USERDEFAULTS_SET(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];\
[M_USERDEFAULTS synchronize];

/**
 *  IndexPath
 */
#define M_IndexPath(section, row) ([NSIndexPath indexPathForRow:row inSection:section])

/**
 *  IndexSet
 */
#define M_IndexSet(section) ([[NSIndexSet alloc] initWithIndex:section])

//RGB颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//字体
#define M_FONT_SYSTEM(font) ([UIFont systemFontOfSize:font])
#define M_FONT_BOLD(font)   ([UIFont boldSystemFontOfSize:font])

//当前View宽度
#define CurrentViewWidth (CGRectGetWidth(self.frame))

//当前View高度
#define CurrentViewHeight (CGRectGetHeight(self.frame))


#define mainScreen_Width ([[UIScreen mainScreen] bounds].size.width)

#define mainScreen_Height ([[UIScreen mainScreen] bounds].size.height)

#define WS __weak typeof(self) ws = self;



#pragma mark - 常用宏
/**
 *  APP编号
 */
#define APPID @"931167309"

/**
 *  APP苹果下载地址
 */
#define IPHONE_DOWNLOAD_URL @"https://itunes.apple.com/us/app/fm365-mei-rong-mei-fa-mei/id905626963?l=zh&ls=1&mt=8"


/**
 *是否为iPad版
 */
#define ISPAD ([[[UIDevice currentDevice] model] isEqualToString:@"iPad"] ? YES : NO)

/**
 *是否>=IOS8系统
 */
#define ISIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

/**
 *  3.5寸屏
 */
#define IS_IPHONE_35 ([UIScreen mainScreen].bounds.size.height == 480.f)

/**
 *  4.0寸屏
 */
#define IS_IPHONE_40 ([UIScreen mainScreen].bounds.size.height == 568.f)

/**
 *  4.7寸屏
 */
#define IS_IPHONE_47 ([UIScreen mainScreen].bounds.size.height == 667.f)

/**
 *  5.5寸屏
 */
#define IS_IPHONE_55 ([UIScreen mainScreen].bounds.size.height == 736.f)

/**
 *  Cell高度
 */
#define TabCellH (mainScreen_Width == 320 ? 44 : 50)

/**
 *  深蓝色
 */
#define NavyBlue RGBCOLOR(74, 152, 226)

/**
 *  新建预约 left 边距
 */
#define top_left 20

/**
 *  新建预约 title 宽度
 */
#define title_Width 200
/**
 *  新建预约 title 高度
 */
#define title_Height 30











