//
//  PersonMessage.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonMessage.h"

@implementation PersonMessage
+ (PersonMessage *)personWithDic:(NSDictionary *)dic{
    PersonMessage *per = [[PersonMessage alloc]init];
    per.ID = dic[@"id"];
    per.nickname = dic[@"nickname"];
    per.mobile = dic[@"mobile"];
    per.avatar = dic[@"avatar"];
    per.sex = dic[@"sex"];
    per.sex = dic[@"like_wiki"];
    return per;
}
@end
