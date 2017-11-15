//
//  NSDate+Expand.h
//

#import <Foundation/Foundation.h>

@interface NSDate (Expand)

/**
 *  @param dateFormat 例如 yyyy-MM-dd
 */
- (NSString *)ex_getDataStrWithFormatType:(NSString *)dateFormat;

/** 字符串 -> NSDate */
+ (NSDate *)ex_getDateWithDateStr:(NSString *)dateStr AndFormat:(NSString *)format;


//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)ex_dateAfterDay:(int)day;

//month个月后的日期
- (NSDate *)ex_dateafterMonth:(int)month;

//获取日
- (NSUInteger)ex_getDay;

//获取月
- (NSUInteger)ex_getMonth;

//获取年
- (NSUInteger)ex_getYear;

//返回一周的第几天(周末为第一天)
- (NSUInteger)ex_weekday;

//获取周几
- (NSString *)ex_weekDayStr;

/** 获取指定Date月的天数 */
- (NSInteger)ex_getDaysCountOfMonth;

/** 获取dateStr所在周的 周一 */
+ (NSDate *)ex_getFirstDayInWeek:(NSString *)dateStr AndFormat:(NSString *)format;
/** 获取dateStr所在周的 周日 */
+ (NSDate *)ex_getEndDayInWeek:(NSString *)dateStr AndFormat:(NSString *)format;

/**
 *  获取 当前Date所在的日 周 月 范围
 *
 *  @param dateType 0 日 1 周 2 月
 *
 *  @return @{@"fromDate": @"yyyy-MM-dd HH:ss", @"toDate": @"yyyy-MM-dd HH:ss"}
 */
- (NSDictionary *)ex_getFromDateAndToDateWithType:(NSInteger)dateType;

@end
