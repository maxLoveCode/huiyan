//
//  HomePageModel.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePage : NSObject

@property (nonatomic,assign) NSInteger *ID;

@property (nonatomic,copy) NSString *type;
@property (nonatomic,assign) NSInteger *cid;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *actor;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *cover_1;
@property (nonatomic,copy) NSString *profile;
@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *createId;

@property (nonatomic,copy) NSString *imgs;
@property (nonatomic,copy) NSString *play_count;
@property (nonatomic,copy) NSString *like_count;
@property (nonatomic,copy) NSString *share_count;

+(HomePage* )parseDramaJSON:(NSDictionary*)json;

@end
