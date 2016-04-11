//
//  TrainingTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Training.h"
#import "UIImageView+WebCache.h"
@interface TrainingTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * _Nonnull  image_pic;
@property (nonatomic, strong) UILabel *_Nonnull time_lab;
@property (nonatomic, strong) UILabel *_Nonnull title_lab;
@property (nonatomic, strong) UILabel *_Nonnull count_lab;
@property (nonatomic, strong) UIButton *_Nonnull enroll_btn;

- (void) setContent:(Training  *_Nonnull)train;
@end
