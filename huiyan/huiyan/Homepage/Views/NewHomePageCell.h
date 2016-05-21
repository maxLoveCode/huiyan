//
//  NewHomePageCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePage.h"
@interface NewHomePageCell : UITableViewCell
@property (strong, nonatomic) UIImageView *image_pic;
@property (strong, nonatomic) UILabel *name_lab;
@property (strong, nonatomic) UIImageView *mask;
- (void)setContent:(HomePage *)model;
@end
