//
//  ArticleTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePage.h"
@interface ArticleTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *image_pic;
@property (nonatomic, strong) UILabel *title_lab;
@property (nonatomic, strong) UIView *gray_view;
@property (nonatomic, strong) UIImageView *video_pic;
@property (nonatomic, strong) UIView *head_view;

- (void)setContent:(HomePage *)drama;

+ (CGFloat)cellHeight;
@end
