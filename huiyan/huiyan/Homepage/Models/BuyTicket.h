//
//  BuyTicket.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyTicket : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *price_range;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *buy_tip;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *cid;

+ (BuyTicket *)dataWithDic:(NSDictionary *)dic;
@end
