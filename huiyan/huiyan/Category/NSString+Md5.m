//
//  NSString+Md5.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/21.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "NSString+Md5.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation NSString (Md5)
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr),result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:16];
    for(int i = 0; i < 16; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
@end
