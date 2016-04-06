//
//  UnitTest.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "UnitTest.h"
#import "Constant.h"

@implementation UnitTest

+ (UnitTest *)instance{
    static UnitTest *Instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Instance = [[UnitTest alloc]init];
    });
    return Instance;
}

-(void)testResult:(void(^)(BOOL result))completion
{
    manager = [ServerManager sharedInstance];
    completion(YES);
}

@end
