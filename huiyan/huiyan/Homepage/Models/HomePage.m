//
//  HomePageModel.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePage.h"

@implementation HomePage

+(HomePage* )parseDramaJSON:(NSDictionary*)json
{
    HomePage* drama = [[HomePage alloc] init];
    [drama setCover: [self stringFormatting:[json objectForKey:@"cover"]]];
    [drama setContent:[json objectForKey:@"content"]];
    [drama setCid:(NSInteger*)[[json objectForKey:@"cid"] integerValue]];
    drama.type = json[@"type"];
    [drama setID:(NSInteger*)[[json objectForKey:@"id"] integerValue]];
    [drama setActor:[json objectForKey:@"actor"]];
    [drama setTitle:[json objectForKey:@"title"]];
    [drama setProfile:[json objectForKey:@"profile"]];
    drama.imgs = json[@"imgs"];
    
    return drama;
}

+(NSString*)stringFormatting:(NSString*)responseData
{

    responseData = [responseData stringByReplacingOccurrencesOfString:@" " withString:@""];
    responseData = [responseData stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return responseData;
}

@end
