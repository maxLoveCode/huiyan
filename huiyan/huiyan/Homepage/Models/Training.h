//
//  Training.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Training : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSArray *imgs;

+ (Training *)dataWithDic:(NSDictionary *)dic;
@end
