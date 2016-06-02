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
    [drama setCover_1:[json objectForKey:@"cover_1"]];
    if ([drama.cover_1 isEqualToString:@""]) {
        [drama setCover_1:drama.cover];
    }
    [drama setID:[[json objectForKey:@"id"] integerValue]];
    [drama setActor:[json objectForKey:@"actor"]];
    [drama setTitle:[json objectForKey:@"title"]];
    [drama setProfile:[json objectForKey:@"profile"]];
    drama.imgs = json[@"imgs"];
    drama.like_count = json[@"like_count"];
    drama.play_count = json[@"play_count"];
    drama.share_count = json[@"share_count"];
    drama.is_like = json[@"is_like"];
    return drama;
}

+(NSString*)stringFormatting:(NSString*)responseData
{

    responseData = [responseData stringByReplacingOccurrencesOfString:@" " withString:@""];
    responseData = [responseData stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    return responseData;
}

@end
