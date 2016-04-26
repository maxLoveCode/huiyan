//
//  StarVideo.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/18.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StarVideo : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *movie;
@property (nonatomic,copy) NSString *createtime;
@property (nonatomic,copy) NSString *play_count;
@property (nonatomic,copy) NSString *like_count;
@property (nonatomic,copy) NSString *is_like;
@property (nonatomic,copy) NSString *comment_count;
+ (StarVideo *)starVideoWithDic:(NSDictionary *)dic;
@end
