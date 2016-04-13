//
//  User.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "User.h"

@interface User()


@end

@implementation User

-(instancetype)initWithMobile:(NSString*)mobile Password:(NSString*)password
{
    self = [super init];
    if (self) {
        self.mobile = mobile;
        self.password = password;
    }
    return self;
}

@end
