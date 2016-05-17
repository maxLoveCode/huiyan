//
//  chatUsers.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "chatUsers.h"

@implementation chatUsers
-(instancetype)init
{
    self = [super init];
    if (self) {
        _serverManager = [ServerManager sharedInstance];
    }
    return self;
}

-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    
}


@end
