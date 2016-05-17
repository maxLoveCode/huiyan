//
//  PayData.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/4.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PayData.h"

@implementation PayData
+ (PayData *)paydataWithDic:(NSDictionary *)dic{
    PayData *model = [[PayData alloc]init];
    model.opera_title =  dic[@"opera_title"];
    model.opera_date =  dic[@"opera_date"];
    model.floor =  dic[@"floor"];
    model.tickets =  dic[@"tickets"];
    model.code_num =  dic[@"code_num"];
    model.code_img = [self stringFormatting:dic[@"code_img"]];     
    model.theater_name =  dic[@"theater_name"];
    model.theater_addr =  dic[@"theater_addr"];
    model.theater_tel =  dic[@"theater_tel"];
    model.pay_price =  dic[@"pay_price"];
    model.pay_num =  dic[@"pay_num"];
     model.order_no =  dic[@"order_no"];
     model.pay_time =  dic[@"pay_time"];
     model.kefu_tel =  dic[@"kefu_tel"];
    model.mobile = dic[@"mobile"];
    return model;
    
}

+(NSString*)stringFormatting:(NSString*)responseData
{
    
    responseData = [responseData stringByReplacingOccurrencesOfString:@" " withString:@""];
    responseData = [responseData stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return responseData;
}
@end
