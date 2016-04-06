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
    tick.address = dic[@"address"];
    tick.price_range = dic[@"price_range"];
    tick.content = dic[@"content"];
    tick.buy_tip = dic[@"buy_tip"];
    tick.title = dic[@"title"];
    tick.cover = dic[@"cover"];
    return tick;
}
@end
