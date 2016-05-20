//
//  Message.m
//  HuiYan
//
//  Created by zc on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "Message.h"

@implementation Message

+(Message*)parseMessageFromJSON:(NSDictionary*)json
{
    Message* msg = [[Message alloc]init];
    [msg setContent:json[@"content"]];
    [msg setMid:json[@"id"]];
    NSString* flag = json[@"is_read"];
    [msg setIsRead:([flag isEqualToString:@"0"])?YES:NO];
    [msg setTitle:json[@"title"]];
    return msg;
}


@end
