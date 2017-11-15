//
//  ArchiveManager.h
//  解压压缩
//  需要pod 引入‘SSZipArchive’
//  < -- pod 'SSZipArchive' -- >

//  需要pod 引入‘AFNetworking3.0’
//  < --     pod 'AFNetworking', '~> 3.0' -- >

//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

typedef void (^ManagerArrayBlock)(NSDictionary *result, NSString *filePath, NSFileManager *fileManager);

typedef void (^ManagerNetworkBlock)(NSString *state);


@interface ArchiveManager : NSObject

@property (nonatomic, strong) NSString *cachesPath;

@property (nonatomic, strong) NSString *tempPath;


@property (nonatomic, strong) NSFileManager *fileManager;

@property (nonatomic, copy) ManagerArrayBlock arrayBlock;

@property (nonatomic, copy) ManagerNetworkBlock networkBlock;

+ (instancetype)manager;

- (void)startRequest:(NSString *)urlString;

@end
