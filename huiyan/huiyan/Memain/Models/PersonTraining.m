//
//  PersonTraining.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonTraining.h"
#import "NSString+ImageString.h"
@implementation PersonTraining


+ (PersonTraining *)PersonTrainingWithDic:(NSDictionary *)dic{
    PersonTraining *train = [[PersonTraining alloc]init];
    [train setValuesForKeysWithDictionary:dic];
    return train;
}
@end
