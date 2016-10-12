//
//  GKDHotFixManager.m
//  sojex
//
//  Created by gkoudai_xsm on 16/8/27.
//  Copyright © 2016年 finance. All rights reserved.
//
#import "JPLoader.h"
#import "JPCleaner.h"
#import "MKHotFixManager.h"

@implementation MKHotFixManager

static MKHotFixManager *manager;
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [MKHotFixManager new];
    });
    return manager;
}

- (void)downloadScriptAndRun {
    @try {
        [JPLoader run];
    } @catch (NSException *exception) {
        [JPCleaner cleanAll];
    } @finally {
        //请求版本信息
        NSString *shellUrlStr = [NSString stringWithFormat:@"http://xxx.xxx.xxx.xxx/Patch"];
        NSURL *shellUrl = [NSURL URLWithString:shellUrlStr];
        NSURLRequest *shellRequest = [NSURLRequest requestWithURL:shellUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:shellRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (response != nil && data != nil) {
                NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *dataDic = responseDic[@"data"];
                NSInteger version = [dataDic[@"patch_version"] integerValue];
                NSString *downloadUrl = dataDic[@"url"];
                if (version != 0 && version > [JPLoader currentVersion]) {
                     //开始加载新补丁
                    [JPLoader updateToVersion:version downloadUrl:downloadUrl callback:^(NSError *error) {
                        if (error == nil) {
                            //加载完成，清空runned老补丁
                            [JPCleaner cleanAll];
                            //准备运行补丁
                            @try {
                                [JPLoader run];
                            } @catch (NSException *exception) {
                                [JPCleaner cleanAll];
                            }
                        } else {
                            //加载错误
                            NSLog(@"错误信息：%@",error);
                        }
                        
                    }];
                } else {
                    NSLog(@"当前为最新补丁");
                    if (version == 0) {
                        [JPCleaner cleanAll];
                    }
                }
            } else {
                NSLog(@"没有补丁信息");
            }
            
        }];
        [dataTask resume];
    }
}

- (void)runTestScript {
    [JPLoader runTestScriptInBundle];
}
@end
