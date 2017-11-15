//
//  NSDate+Expand.m
//

#import "NSDate+Expand.h"

@implementation NSDate (Expand)

- (NSString *)ex_getDataStrWithFormatType:(NSString *)dateFormat{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormat];
    
    return [dateFormatter stringFromDate:self];
}


//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)ex_dateAfterDay:(int)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    
    return dateAfterDay;
}
//month个月后的日期
- (NSDate *)ex_dateafterMonth:(int)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    
    return dateAfterMonth;
}
//获取日
- (NSUInteger)ex_getDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:self];
    return [dayComponents day];
}
//获取月
- (NSUInteger)ex_getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:self];
    return [dayComponents month];
}
//获取年
- (NSUInteger)ex_getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:self];
    return [dayComponents year];
}

//返回一周的第几天(周日为第一天)
- (NSUInteger)ex_weekday{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
    return [weekdayComponents weekday] - 1  ;
}

//返回周几
- (NSString *)ex_weekDayStr{
    NSArray *weeks  = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    NSInteger index = [self ex_weekday];
    
    return index < [weeks count] ? weeks[index] : @"";
}

/** 获取指定Date月的天数 */
- (NSInteger)ex_getDaysCountOfMonth{
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    
    return days.length;
}

+ (NSDate *)ex_getFirstDayInWeek:(NSString *)dateStr AndFormat:(NSString *)format{
    NSDate *date = [NSDate ex_getDateWithDateStr:dateStr AndFormat:format];
    
    NSInteger dayInWeek = [date ex_weekday];
    dayInWeek = dayInWeek - 1;
    if (dayInWeek < 0) {
        dayInWeek = 6;
    }
    
    NSDate *firstDate = [date ex_dateAfterDay:-(int)dayInWeek];
    
    return firstDate;
}

+ (NSDate *)ex_getDateWithDateStr:(NSString *)dateStr AndFormat:(NSString *)format{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:dateStr];
    
    return date;
}

+ (NSDate *)ex_getEndDayInWeek:(NSString *)dateStr AndFormat:(NSString *)format{
    NSDate *firstDate = [NSDate ex_getDateWithDateStr:dateStr AndFormat:format];
    
    NSDate *endDate   = [firstDate ex_dateAfterDay:6];
    
    return endDate;
}

- (NSDictionary *)ex_getFromDateAndToDateWithType:(NSInteger)dateType{
    NSString *defaultFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [self ex_getDataStrWithFormatType:defaultFormat];
    
    NSString *fromDateStr = @"";
    NSString *toDateStr   = @"";
    
    if (dateType == 0) {
        fromDateStr = dateStr;
        toDateStr   = dateStr;
    }
    
    if (dateType == 1) {
        NSDate *fromDate = [NSDate ex_getFirstDayInWeek:dateStr AndFormat:defaultFormat];
        NSDate *toDate   = [NSDate ex_getFirstDayInWeek:dateStr AndFormat:defaultFormat];
        
        fromDateStr = [fromDate ex_getDataStrWithFormatType:defaultFormat];
        toDateStr   = [toDate ex_getDataStrWithFormatType:defaultFormat];
    }
    
    if (dateType == 2) {
        dateStr     = [self ex_getDataStrWithFormatType:@"yyyy-MM"];
        fromDateStr = [NSString stringWithFormat:@"%@-01", dateStr];
        toDateStr   = [NSString stringWithFormat:@"%@-%zi", dateStr, [self ex_getDaysCountOfMonth]];
    }
    
    
    fromDateStr = [NSString stringWithFormat:@"%@ 00:00", fromDateStr];
    toDateStr   = [NSString stringWithFormat:@"%@ 23:59", toDateStr];
    return @{@"fromDate": fromDateStr,
             @"toDate":   toDateStr};
}

@end
