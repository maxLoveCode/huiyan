//
//  FindFriend.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/27.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FindFriend.h"

@implementation FindFriend
+ (FindFriend *)findFriendWithData:(NSDictionary *)dic{
    FindFriend *model = [[FindFriend alloc]init];
    NSLog(@"%@",dic);
    model.ID = dic[@"id"];
    model.nickname = dic[@"nickname"];
    model.avatar = dic[@"avatar"];
    model.sex = dic[@"sex"];
    model.like_wiki = dic[@"like_wiki"];
    model.distance = dic[@"distance"];
    model.is_friend = dic[@"is_friend"];
    return model;
}
@end
