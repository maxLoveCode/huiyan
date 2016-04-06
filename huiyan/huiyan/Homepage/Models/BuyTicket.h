//
//  BuyTicket.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyTicket : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *price_range;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *buy_tip;
@property (nonatomic,strong) NSString *cover;
+ (BuyTicket *)dataWithDic:(NSDictionary *)dic;
@end
