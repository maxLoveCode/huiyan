//
//  Invitation.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "Invitation.h"

@implementation Invitation
+ (Invitation *)invitationWithDic:(NSDictionary *)dic{
    Invitation *model = [[Invitation alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}
@end
