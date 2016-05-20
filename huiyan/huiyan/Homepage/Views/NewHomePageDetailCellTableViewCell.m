//
//  NewHomePageDetailCellTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/17.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "NewHomePageDetailCellTableViewCell.h"
#import "Constant.h"
@implementation NewHomePageDetailCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.good_btn setFrame:CGRectMake(kScreen_Width / 2 - 50, CGRectGetMinY(self.play_btn.frame), 100, 30)];
    // Initialization code
}

- (void)setContent:(HomePage *)model{
    self.name_lab.text = model.title;
    self.actor_lab.text = model.actor;
    [self.play_btn setTitle:model.play_count forState:UIControlStateNormal];
    [self.good_btn setTitle:model.like_count forState:UIControlStateNormal];
    [self.relay_btn setTitle:model.share_count forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
