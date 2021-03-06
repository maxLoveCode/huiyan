//
//  BuyTicket.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "BuyTicket.h"

@implementation BuyTicket
+ (BuyTicket *)dataWithDic:(NSDictionary *)dic{
    BuyTicket *tick = [[BuyTicket alloc]init];
    tick.date = dic[@"date"];
    tick.theater_addr = dic[@"theater_addr"];
    tick.theater_tel = dic[@"theater_tel"];
    tick.theater_name = dic[@"theater_name"];
    tick.price_range = dic[@"price_range"];
    tick.content = dic[@"content"];
    tick.buy_tip = dic[@"buy_tip"];
    tick.title = dic[@"title"];
    tick.cover = [self stringFormatting:dic[@"cover"]];
    tick.ID = dic[@"id"];
    tick.cid = dic[@"cid"];
    return tick;
}
+(NSString*)stringFormatting:(NSString*)responseData
{
    
    responseData = [responseData stringByReplacingOccurrencesOfString:@" " withString:@""];
    responseData = [responseData stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return responseData;
}
@end
