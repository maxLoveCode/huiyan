//
//  TrainOrderDetail.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainOrderDetail.h"
#import "NSString+ImageString.h"
@implementation TrainOrderDetail
+ (TrainOrderDetail *)trainOrderDetailWithDic:(NSDictionary *)dic{
    TrainOrderDetail *train = [[TrainOrderDetail alloc]init];
    NSDictionary *train_info = dic[@"train_info"] ;
    NSDictionary *order_info = dic[@"order_info"];
    train.cover = [NSString stringFormatting:train_info[@"cover"]];
    train.title = train_info[@"title"];
    train.date = train_info[@"date"];
    train.address = train_info[@"address"];
    train.tid = order_info[@"tid"];
    train.createtime = order_info[@"createtime"];
    train.name = order_info[@"name"];
    train.mobile = order_info[@"mobile"];
    train.is_effect = order_info[@"is_effect"];
    train.order_no = order_info[@"order_no"];
    return train;
}
@end
