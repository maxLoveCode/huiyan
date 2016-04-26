//
//  ServerManager.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//
//  base on the afnetworking 3.x, which subclassing from
//  afhttpsessionmanager to deal with any requests



#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ServerManager : AFHTTPSessionManager

@property (nonatomic, copy)  NSString* _Nonnull accessToken;

extern NSString  * _Nonnull const b_URL;
extern NSString  * _Nonnull const version;

+ (_Nonnull id)sharedInstance;
- (NSString* _Nonnull)appendedURL:(NSString* _Nonnull)url;

- (void)AnimatedPOST:(NSString * _Nonnull)URLString
          parameters:(nullable id)parameters
             success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;
- (void)AnimatedGET:(NSString * _Nonnull)URLString
          parameters:(nullable id)parameters
             success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure;

@end
