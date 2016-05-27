//
//  StarVideo.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/18.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "StarVideo.h"

@implementation StarVideo
+ (StarVideo *)starVideoWithDic:(NSDictionary *)dic{
    StarVideo *starVideo = [[StarVideo alloc]init];
    starVideo.ID = dic[@"id"];
    starVideo.title = dic[@"title"];
    starVideo.content = dic[@"content"];
    starVideo.createtime = dic[@"createtime"];
    starVideo.play_count = dic[@"play_count"];
    starVideo.like_count = dic[@"like_count"];
    starVideo.is_like = dic[@"is_like"];
    starVideo.type = dic[@"type"];
    starVideo.comment_count = dic[@"comment_count"];
    return starVideo;
}
@end
