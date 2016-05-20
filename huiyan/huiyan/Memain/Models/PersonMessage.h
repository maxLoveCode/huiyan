//
//  PersonMessage.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonMessage : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *like_wiki;
@property (nonatomic,copy) NSString *send_flower_count;
+ (PersonMessage *)personWithDic:(NSDictionary *)dic;
@end
