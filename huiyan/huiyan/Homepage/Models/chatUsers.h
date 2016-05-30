//
//  chatUsers.h
//  huiyan
//
//  Created by 华印mac-001 on 16/5/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>
#import "ServerManager.h"

@interface chatUsers : NSObject<RCIMUserInfoDataSource>

@property (nonatomic, strong) ServerManager* serverManager;
@property (nonatomic, strong) NSMutableArray* dataArray;
+(chatUsers*)instance;

@end
