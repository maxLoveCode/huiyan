//
//  MCGifLoadingHUD.h
//  huiyan
//
//  Created by 华印mac-001 on 16/6/8.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCGifLoadingHUD : UIView

@property (nonatomic, assign) CGRect gifFrame;

@property (nonatomic, strong) NSMutableArray* imageArray;
@property (nonatomic, strong) NSString* frameName;
@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UIView* background;
@property (nonatomic, strong) UILabel* label;

+(void)animatedwithView:(MCGifLoadingHUD*)gifLoading;
+(void)dismissView:(MCGifLoadingHUD*)gifLoading;

@end
