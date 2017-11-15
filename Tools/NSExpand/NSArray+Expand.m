//
//  NSArray+Expand.m
//

#import "NSArray+Expand.h"

@implementation NSArray (Expand)

- (NSArray *)ex_filteredArrayWithFormat:(NSString *)format {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:format];
    
    NSArray *resultArray   = [self filteredArrayUsingPredicate:predicate];
    
    if ([resultArray count] == 0)
        return nil;
    
    return resultArray;
}

- (NSArray *)ex_containSpecifiedValueDictionary:(NSString *)value WithKey:(NSString *)key {
    
    NSString *str = [NSString stringWithFormat:@"%@ == '%@'", key, value];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    
    NSArray *resultArray   = [self filteredArrayUsingPredicate:predicate];
    
    if ([resultArray count] == 0) 
        return nil;
    
    return resultArray;
}

- (NSArray *)ex_containSpecifiedValueDictionary:(NSString *)value WithKey:(NSString *)key IsString:(BOOL)isString {
    NSString *str = isString ? [NSString stringWithFormat:@"%@ == '%@'", key, value] : [NSString stringWithFormat:@"%@ == %@", key, value];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    
    NSArray *resultArray   = [self filteredArrayUsingPredicate:predicate];
    
    if ([resultArray count] == 0)
        return nil;
    
    return resultArray;
}

- (NSArray *)ex_getReverseArray {
    NSArray *newArray = [[self reverseObjectEnumerator] allObjects];
    return newArray;
}

+ (NSArray *)ex_fileList:(NSString *)directoryPath{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [[fileManager contentsOfDirectoryAtPath:directoryPath error:nil] mutableCopy];
    
}

@end
