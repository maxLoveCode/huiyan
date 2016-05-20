//
//  PersonHeadCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonMessage.h"
@interface PersonHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *head_pic;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (strong, nonatomic) UIImageView *sex_pic;
@property (weak, nonatomic) IBOutlet UIButton *edit_btn;
@property (weak, nonatomic) IBOutlet UILabel *fans_lab;
@property (weak, nonatomic) IBOutlet UILabel *flower_lab;
@property (weak, nonatomic) IBOutlet UIImageView *bg_image;
- (void)setContent:(PersonMessage *)model;
@end
