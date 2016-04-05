//
//  HomePageCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageCell : UITableViewCell

@property (nonatomic, strong) UIImageView *image_pic;
@property (nonatomic, strong) UILabel *title_lab;
@property (nonatomic, strong) UILabel *actor_lab;
@property (nonatomic, strong) UILabel *description_lab;

+ (CGFloat)cellHeight;

@end
