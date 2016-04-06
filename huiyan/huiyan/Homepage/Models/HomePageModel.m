//
//  HomePageModel.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel

+(HomePageModel* )parseDramaJSON:(NSDictionary*)json
{
    HomePageModel* drama = [[HomePageModel alloc] init];
    [drama setCover:[json objectForKey:@"cover"]];
    [drama setContent:[json objectForKey:@"content"]];
    [drama setCid:(NSInteger*)[[json objectForKey:@"cid"] integerValue]];
    [drama setType:(NSInteger*)[[json objectForKey:@"type"] integerValue]];
    [drama setID:(NSInteger*)[[json objectForKey:@"id"] integerValue]];
    [drama setActor:[json objectForKey:@"actor"]];
    [drama setTitle:[json objectForKey:@"title"]];
    [drama setProfile:[json objectForKey:@"profile"]];
    
    return drama;
}

@end
