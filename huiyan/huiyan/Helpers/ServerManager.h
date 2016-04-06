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

@property (nonatomic, copy) NSString* accessToken;

extern NSString *const b_URL;
extern NSString *const version;

+ (id)sharedInstance;
- (NSString*)appendedURL:(NSString*)url;

@end
