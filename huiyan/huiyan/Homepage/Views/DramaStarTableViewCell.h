//
//  DramaStarTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DramaStarTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *head_img;
@property (nonatomic, strong) UIImageView *like_img;
@property (nonatomic, strong) UIImageView *flower_img;
@property (nonatomic, strong) UILabel *name_lab;
@property (nonatomic, strong) UILabel *des_lab;
@property (nonatomic, strong) UILabel *like_lab;
@property (nonatomic, strong) UILabel *flower_lab;
@property (nonatomic, strong) UIButton *invatation_btn;
- (void)setContent;

@end
