//
//  Message.h
//  HuiYan
//
//  Created by zc on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) BOOL isRead;
@property (nonatomic,assign) NSString* mid;

+(Message*)parseMessageFromJSON:(NSDictionary*)json;

@end