//
//  Training.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "Training.h"

@implementation Training
+ (Training *)dataWithDic:(NSDictionary *)dic{
    Training *train = [[Training alloc]init];
    train.date = dic[@"date"];
    train.address = dic[@"address"];
    train.content = dic[@"content"];
    train.title = dic[@"title"];
    train.cover = [self stringFormatting:dic[@"cover"]];
    train.ID = dic[@"id"];
    train.count = dic[@"count"];
    train.price = dic[@"price"];
    return train;
}
+(NSString*)stringFormatting:(NSString*)responseData
{
    
    responseData = [responseData stringByReplacingOccurrencesOfString:@" " withString:@""];
    responseData = [responseData stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return responseData;
}
@end
