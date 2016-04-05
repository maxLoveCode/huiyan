//
//  ServerManager.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ServerManager.h"

@implementation ServerManager
+ (ServerManager *)instance{
    static ServerManager *Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[ServerManager alloc]init];
    });
    return Instance;
}
@end
