//
//  HomePageCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageModel.h"
#import "UIImageView+WebCache.h"

@interface HomePageCell : UITableViewCell

@property (nonatomic, strong) UIImageView * _Nullable image_pic;
@property (nonatomic, strong) UILabel * _Nonnull title_lab;
@property (nonatomic, strong) UILabel * _Nonnull actor_lab;
@property (nonatomic, strong) UILabel * _Nonnull description_lab;

-(void)setContent:(HomePageModel * _Nonnull)drama;

+ (CGFloat)cellHeight;

@end
