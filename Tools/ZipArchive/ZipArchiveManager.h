//
//  ZipArchiveManager.h
//  evhcSecond
//
//  Created by lms on 2017/11/1.
//  Copyright © 2017年 themobiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>
#import <SSZipArchive.h>

typedef void (^ManagerZipArrayBlock)(NSString *hostPath, NSArray *array, NSFileManager *fileManager);

typedef void (^ManagerNetworkBlock)(NSString *state);


@interface ZipArchiveManager : NSObject<SSZipArchiveDelegate>

@property (nonatomic, strong) NSString *tempPath;

@property (nonatomic, strong) NSFileManager *fileManager;

@property (nonatomic, copy) ManagerZipArrayBlock arrayBlock;

@property (nonatomic, copy) ManagerNetworkBlock networkBlock;

+ (instancetype)manager;
- (BOOL)directoryExists:(NSString *)directoryPath;
- (NSArray *)fileList:(NSString *)directoryPath;
- (void)startRequest:(NSString *)urlString htmlVer:(NSString *)htmlVer;

@end
