//
//  User.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, assign) NSInteger* userID;
@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* mobile;
@property (nonatomic, copy) NSString* password;

-(instancetype)initWithMobile:(NSString*)mobile Password:(NSString*)password;

@end
