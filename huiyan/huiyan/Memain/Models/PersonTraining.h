//
//  PersonTraining.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonTraining : NSObject
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *tid;
@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *is_effect;
@property (nonatomic,copy) NSString *order_no;
@property (nonatomic,copy) NSString *oid;
+ (PersonTraining *)PersonTrainingWithDic:(NSDictionary *)dic;
@end
