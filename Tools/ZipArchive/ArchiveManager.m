//
//  ArchiveManager.m
//
//

#import "ArchiveManager.h"
#import <MJExtension.h>

typedef void (^ManagerStringBlock)(NSString *string);

@implementation ArchiveManager

/* 单例控制器 */
+ (instancetype)manager {
    return [[self alloc] init];
}

static ArchiveManager *instance = nil;
static dispatch_once_t onceToken;
- (instancetype)init {
    dispatch_once(&onceToken, ^{
        instance = [super init];
        
        _cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        _fileManager = [NSFileManager defaultManager];
    });
    return instance;
}

#pragma mark - 从Url获取对应文件
- (void)startRequest:(NSString *)urlString{
    
    [self downloadField:urlString block:^(NSString *filePath) {
        if (filePath) {
            
            NSLog(@"%@",filePath);
            NSData *data=[NSData dataWithContentsOfFile:filePath];
            
//            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingUTF8);
            NSString *ret = [[NSString alloc]initWithData:data encoding:enc];
            NSString *dic = [ret mj_JSONString];
            NSData *idc = [dic mj_JSONData];
            NSError *error;
            id jsonObject=[NSJSONSerialization JSONObjectWithData:idc
                                                          options:NSJSONReadingAllowFragments
                                                            error:&error];
            if (self.arrayBlock) {
                self.arrayBlock(jsonObject, filePath, _fileManager);
            }
        }else{
            // 下载文件失败
        }
    }];
    
}

#pragma mark 下载文件。目录文件夹不存在，那:@""么这步
- (void)downloadField:(NSString *)urlString block:(ManagerStringBlock)block{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:^(NSProgress * _Nonnull downloadProgress) {
                                                                         
                                                                     } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                                         NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                                                         
                                                                         return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                                                     } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                                         
                                                                         if (block) {
                                                                             block([filePath path]);
                                                                         }
                                                                     }];
    [downloadTask resume];
}


@end
