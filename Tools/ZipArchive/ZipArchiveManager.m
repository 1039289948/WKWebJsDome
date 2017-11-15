//
//  ZipArchiveManager.m
//  evhcSecond
//
//  Created by lms on 2017/11/1.
//  Copyright © 2017年 themobiyun. All rights reserved.
//

#import "ZipArchiveManager.h"

typedef void (^ManagerStringBlock)(NSString *string);

@interface ZipArchiveManager ()

@property (copy, nonatomic) NSString *m_htmlVer;

@end

@implementation ZipArchiveManager

/* 单例控制器 */
+ (instancetype)manager {
    return [[self alloc] init];
}
static ZipArchiveManager *instance = nil;
static dispatch_once_t onceToken;
- (instancetype)init {
    dispatch_once(&onceToken, ^{
        instance = [super init];
//        _tempPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        _tempPath = [[[NSURL fileURLWithPath:NSTemporaryDirectory()] absoluteString] substringFromIndex:[@"file://" length]];;
        _fileManager = [NSFileManager defaultManager];
    });
    return instance;
}

#pragma mark - 从Url获取对应文件
- (void)startRequest:(NSString *)urlString htmlVer:(NSString *)htmlVer {
//    __weak __typeof(self)weakSelf = self;
    self.m_htmlVer = htmlVer;
    NSString *folderName = [[urlString lastPathComponent] stringByDeletingPathExtension];
    NSString *folderPath = [[_tempPath stringByAppendingPathComponent:htmlVer] stringByAppendingPathComponent:folderName];
    if ([self directoryExists:folderPath]) {
        if (self.arrayBlock) {
            self.arrayBlock(folderPath, [self fileList:folderPath], self.fileManager);
        }
    }else{
        [self downloadField:urlString block:^(NSString *filePath) {
            if (filePath) {
                if([instance createFolderWithPath:folderPath]) {
                    [instance releaseZipFiles:filePath unzipPath:folderPath];
                }
            }
        }];
    }
}

#pragma mark - 文件处理
#pragma mark 检测目录文件夹是否存在
/**
 检测目录文件夹是否存在
 
 @param directoryPath 目录路径
 @return 是否存在
 */
- (BOOL)directoryExists:(NSString *)directoryPath{
    BOOL isDir = NO;
    BOOL isDirExist = [_fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if (isDir && isDirExist) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark 获取文件夹下所有文件列表。
- (NSArray *)fileList:(NSString *)directoryPath{
    return [[_fileManager contentsOfDirectoryAtPath:directoryPath error:nil] mutableCopy];
}

#pragma mark 下载文件。目录文件夹不存在，那么这步
- (void)downloadField:(NSString *)urlString block:(ManagerStringBlock)block{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
//        NSString *fullPath = [[_tempPath stringByAppendingPathComponent:self.m_htmlVer] stringByAppendingPathComponent:response.suggestedFilename];
        
        NSString *fullPath = [_tempPath stringByAppendingPathComponent:response.suggestedFilename];

        
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (block) {
            block([filePath path]);
        }
    }] resume];
}
#pragma mark 创建文件夹。下载完文件，文件需要解压到这个文件夹
- (BOOL)createFolderWithPath:(NSString *)folderPath{
    return [_fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
}

#pragma mark - SSZipArchive
#pragma mark 解压
- (void)releaseZipFiles:(NSString *)zipPath unzipPath:(NSString *)unzipPath{
    
    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath delegate:self]) {
        NSLog(@"解压成功");
        [_fileManager removeItemAtPath:zipPath error:nil];
        NSArray *fileList = [self fileList:[unzipPath stringByAppendingPathComponent:@"html"]];
        
        
        if (self.arrayBlock) {
            self.arrayBlock([unzipPath stringByAppendingPathComponent:@"html"], fileList, self.fileManager);
        }
    }else {
        NSLog(@"解压失败");
    }
}
#pragma mark SSZipArchiveDelegate
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath{
    NSString *DS_Store = [unzippedPath stringByAppendingPathComponent:@".DS_Store"];
    [_fileManager removeItemAtPath:DS_Store error:nil];
}


@end
