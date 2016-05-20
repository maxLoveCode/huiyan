//
//  CommentContent.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/8.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "CommentContent.h"

@implementation CommentContent
+ (CommentContent *)dataWithDic:(NSDictionary *)dic{
    CommentContent *comment = [[CommentContent alloc]init];
    if (![dic[@"user_name"] isKindOfClass:[NSNull class]]) {
         comment.user_name = dic[@"user_name"];
    }
    comment.content = dic[@"content"];
    comment.createtime = dic[@"createtime"];
    return comment;
}
@end
