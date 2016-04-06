//
//  ServerManager.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ServerManager.h"

#ifdef DEBUG
    #define _BASE_URL @"http://139.196.32.98/huiyan"
#else
    #define _BASE_URL @"http://139.196.32.98/huiyan"
#endif

NSString *const b_URL = _BASE_URL;
NSString *const version = @"v1_0";

@implementation ServerManager

+ (id)sharedInstance {
    static dispatch_once_t once;
    static ServerManager *sharedInstance;
    
    
    dispatch_once(&once, ^{
    
        sharedInstance = [[self alloc] initWithBaseURL: [NSURL URLWithString:b_URL]];
    });
    
    NSDictionary *dic = @{@"username":@"huiyan",
                          @"password":@"huiyan"};
    
    [sharedInstance GET:[sharedInstance appendedURL:@"token.php"] parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress %@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 10000) {
            sharedInstance.accessToken = [responseObject objectForKey:@"access_token"];
        }
        else
        {
            NSLog(@"access_token failed");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@", error);
    }];
    
    return sharedInstance;
}

- (NSString*)appendedURL:(NSString*)url
{
    return [NSString stringWithFormat:@"%@/api/%@", version, url];
}


@end
