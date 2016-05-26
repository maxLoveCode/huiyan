//
//  DramaStar.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/15.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

//红团/红角
#import "User.h"

@interface DramaStar : User
@property (nonatomic, copy) NSString *avator;
@property (nonatomic,copy) NSString *profile;
@property (nonatomic,copy) NSString *flower;
@property (nonatomic,copy) NSString *cid;
@property (nonatomic,copy) NSString *is_fans;
@property (nonatomic,copy) NSString *fans_count;
@property (nonatomic,copy) NSArray *gift_list;
+ (DramaStar *)dramaWithDic:(NSDictionary *)dic;
@end
