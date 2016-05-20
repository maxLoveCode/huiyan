//
//  NSString+ImageString.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "NSString+ImageString.h"

@implementation NSString (ImageString)
+(NSString*)stringFormatting:(NSString*)responseData
{
    
    responseData = [responseData stringByReplacingOccurrencesOfString:@" " withString:@""];
    responseData = [responseData stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return responseData;
}
@end
