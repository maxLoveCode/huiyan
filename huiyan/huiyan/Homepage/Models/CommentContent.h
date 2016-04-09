//
//  CommentContent.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/8.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentContent : NSObject
@property (nonatomic,copy) NSString *user_name;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *createtime;
+ (CommentContent *)dataWithDic:(NSDictionary *)dic;
@end
