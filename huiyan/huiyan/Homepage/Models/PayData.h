//
//  PayData.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/4.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayData : NSObject
@property (nonatomic,copy) NSString *opera_title;
@property (nonatomic,copy) NSString *opera_date;
@property (nonatomic,copy) NSString *floor;
@property (nonatomic,copy) NSString *tickets;
@property (nonatomic,copy) NSString *code_num;
@property (nonatomic,copy) NSString *code_img;
@property (nonatomic,copy) NSString *theater_name;
@property (nonatomic,copy) NSString *theater_addr;
@property (nonatomic,copy) NSString *theater_tel;
@property (nonatomic,copy) NSString *pay_price;
@property (nonatomic,copy) NSString *pay_num;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *pay_time;
@property (nonatomic,copy) NSString *kefu_tel;
+ (PayData *)paydataWithDic:(NSDictionary *)dic;

@end
