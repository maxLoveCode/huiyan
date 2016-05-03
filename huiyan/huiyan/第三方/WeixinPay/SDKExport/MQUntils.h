//
//  MQUntils.h
//  WeixinPayDemo
//
//  Created by WsdlDev on 15/10/6.
//  Copyright © 2015年 mazengyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface MQUntils : NSObject

/*
 加密实现MD5和SHA1
 */
+ (NSString *)md5:(NSString *)str;

+ (NSString*)sha1:(NSString *)str;

+ (NSData *)httpSend:(NSString *)url method:(NSString *)method data:(NSString *)data;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

@end
