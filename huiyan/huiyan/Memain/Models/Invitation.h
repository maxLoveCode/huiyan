//
//  Invitation.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Invitation : NSObject
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *content;
+ (Invitation *)invitationWithDic:(NSDictionary *)dic;
@end
