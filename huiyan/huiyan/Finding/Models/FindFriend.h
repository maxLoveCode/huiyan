//
//  FindFriend.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/27.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindFriend : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,strong) NSArray *like_wiki;
@property (nonatomic,copy) NSString *distance;
@property (nonatomic,copy) NSString *is_friend;

+ (FindFriend *)findFriendWithData:(NSDictionary *)dic;
@end
