//
//  PersonDramaTicket.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/15.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonDramaTicket.h"
#import "NSString+ImageString.h"
@implementation PersonDramaTicket

+ (PersonDramaTicket *)personDramaTicketWithDic:(NSDictionary *)dic{
    PersonDramaTicket *per = [[PersonDramaTicket alloc]init];
    per.ID = dic[@"id"];
    per.opera_title = dic[@"opera_title"];
    per.opera_date = dic[@"opera_date"];
    per.floor = dic[@"floor"];
    per.tickets = dic[@"tickets"];
    per.mobile = dic[@"mobile"];
    per.code_num = dic[@"code_num"];
    per.code_img = [NSString stringFormatting:dic[@"code_img"]];
    per.theater_name = dic[@"theater_name"];
    per.theater_addr = dic[@"theater_addr"];
    per.theater_tel = dic[@"theater_tel"];
    per.pay_price = dic[@"pay_price"];
    per.pay_num = dic[@"pay_num"];
    per.order_no = dic[@"oder_no"];
    per.pay_time = dic[@"pay_time"];
    per.kefu_tel = dic[@"kefu_tel"];
    per.opera_cover = dic[@"opera_cover"];
    return per;
}
@end
