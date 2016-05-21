//
//  GifRefresher.m
//  huiyan
//
//  Created by zc on 16/5/21.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "GifRefresher.h"

@implementation GifRefresher


- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 0; i<=7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"gifrefesh%zd", i]];
        [idleImages addObject:image];
    }

    [self setImages:idleImages duration:1 forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"gifrefesh%zd", i]];
        [refreshingImages addObject:image];
    }
    self.lastUpdatedTimeLabel.hidden =YES;
    self.stateLabel.hidden = YES;
    self.backgroundColor = [UIColor lightGrayColor];
    
    [self setImages:idleImages duration:1 forState:MJRefreshStatePulling];
    [self setImages:idleImages duration:1 forState:MJRefreshStateRefreshing];
}

@end
