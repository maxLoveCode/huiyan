//
//  MCGifLoadingHUD.m
//  huiyan
//
//  Created by 华印mac-001 on 16/6/8.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MCGifLoadingHUD.h"
#import "Constant.h"

@implementation MCGifLoadingHUD

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (!_imageView) {
        _background = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width/2-50, kScreen_Height/2-50, 100, 100)];
        [_background setBackgroundColor:[UIColor whiteColor]];
        _background.layer.cornerRadius = 5;
        
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 30, 72)];
        _imageView.animationImages = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"gifloading0.png"], [UIImage imageNamed:@"gifloading1.png"],[UIImage imageNamed:@"gifloading2.png"],[UIImage imageNamed:@"gifloading3.png"],[UIImage imageNamed:@"gifloading4.png"],[UIImage imageNamed:@"gifloading5.png"],[UIImage imageNamed:@"gifloading6.png"],[UIImage imageNamed:@"gifloading7.png"],[UIImage imageNamed:@"gifloading8.png"], nil];
        _imageView.animationDuration = 1.5;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame), CGRectGetWidth(_background.frame), CGRectGetHeight(_background.frame)-CGRectGetMaxY(_imageView.frame))];
        _label.font = kFONT12;
        _label.textColor = [UIColor darkTextColor];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    [_background addSubview:_label];
    [_background addSubview:_imageView];
    [self addSubview:_background];
    return self;
}

+(void)animatedwithView:(MCGifLoadingHUD*)gifLoading
{
    gifLoading.label.text = @"加载中";
    [[UIApplication sharedApplication].keyWindow addSubview:gifLoading];
    [gifLoading.imageView startAnimating];
}

+(void)dismissView:(MCGifLoadingHUD*)gifLoading
{
    [UIView animateWithDuration:1.0f animations:^{
        gifLoading.alpha = 0;
    }completion:^(BOOL finished) {
        [gifLoading removeFromSuperview];
    }];
}

@end
