//
//  chatUsers.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "chatUsers.h"

@interface chatUsers()

@end

@implementation chatUsers

-(instancetype)init
{
    self = [super init];
    if (self) {
        _serverManager = [ServerManager sharedInstance];
        _dataArray = [[NSMutableArray alloc]init];
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
    }
    return self;
}

+(chatUsers*)instance
{
    static chatUsers* Instance = nil;
    static dispatch_once_t dispatchOnce;
    dispatch_once(&dispatchOnce,^{
        Instance = [[chatUsers alloc]init];
    });
    return Instance;
}

-(void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion
{
    //NSLog(@"get user info");
    NSDictionary* dic = @{@"access_token":_serverManager.accessToken ,@"user_id":userId};
    for (RCUserInfo * data in _dataArray) {
        //NSLog(@"%@",data.userId);
        if ([data.userId isEqual:userId]) {
            //NSLog(@"user Found");
            return completion(data);
        }
    }

    [_serverManager AnimatedGET:@"get_user_info.php" parameters:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"]integerValue] == 80001) {
            return  completion(nil);
        }
        else
        {
            NSDictionary* data =[responseObject objectForKey:@"data"];
            [self addPeopleWithID:userId Avatar:[data objectForKey:@"avatar"] Name:[data objectForKey:@"nickname"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)addPeopleWithID:(NSString *)userid Avatar:(NSString *)avatar Name:(NSString*)name
{
    RCUserInfo *newUser = [[RCUserInfo alloc]init];
    newUser.userId = userid;
    newUser.portraitUri = avatar;
    newUser.name = name;
    //NSLog(@"add User %@ with Avatar", userid);
    [_dataArray addObject:newUser];
}


@end
