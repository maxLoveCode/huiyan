//
//  FindTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/27.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindFriend.h"
@interface FindTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *head_pic;
@property (nonatomic,strong) UILabel *name_lab;
@property (nonatomic,strong) UIImageView *sex_pic;
@property (nonatomic,strong) UILabel *occupation_one;
@property (nonatomic,strong) UILabel *distance_lab;
@property (nonatomic,assign) CGFloat occwidth;
- (void)setContent:(FindFriend *)model;
@end
