//
//  DramaStar.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/15.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStar.h"

@implementation DramaStar
+ (DramaStar *)dramaWithDic:(NSDictionary *)dic{
    DramaStar *drama = [[DramaStar alloc]init];
    drama.avator = dic[@"avatar"];
    drama.profile = dic[@"profile"];
    drama.flower = dic[@"flower"];
    drama.userID = dic[@"id"] ;
    drama.nickName = dic[@"nickname"];
    drama.cid = dic[@"cid"];
    drama.is_fans = dic[@"is_fans"];
    return drama;
}

@end
