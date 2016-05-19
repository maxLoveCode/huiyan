//
//  NewHomePageDetailCellTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/17.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePage.h"
@interface NewHomePageDetailCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *actor_lab;
@property (weak, nonatomic) IBOutlet UIButton *play_btn;
@property (weak, nonatomic) IBOutlet UIButton *good_btn;
@property (weak, nonatomic) IBOutlet UIButton *relay_btn;
- (void)setContent:(HomePage *)model;
@end
