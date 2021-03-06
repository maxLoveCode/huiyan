//
//  UnitTest.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//
//  Singleton object class for unit testing 

#import <Foundation/Foundation.h>
#import "ServerManager.h"

@interface UnitTest : NSObject
{
    ServerManager *manager;
}

+ (UnitTest *)instance;
-(void)testResult:(void(^)(BOOL result))completion;

@end
