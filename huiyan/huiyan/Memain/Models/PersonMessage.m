//
//  PersonMessage.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonMessage.h"
#import "NSString+ImageString.h"
@implementation PersonMessage
+ (PersonMessage *)personWithDic:(NSDictionary *)dic{
    PersonMessage *per = [[PersonMessage alloc]init];
    per.ID = dic[@"id"];
    per.nickname = dic[@"nickname"];
    per.mobile = dic[@"mobile"];
    per.avatar = [NSString stringFormatting:dic[@"avatar"]];
    per.sex = dic[@"sex"];
    per.like_wiki = dic[@"like_wiki"];
    return per;
}
@end
