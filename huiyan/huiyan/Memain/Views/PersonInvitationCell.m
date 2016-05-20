//
//  PersonInvitationCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonInvitationCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
@implementation PersonInvitationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUp];
}

- (void)setUp{
    [self.lookBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
}

- (void)setContent:(Invitation *)model{
    [self.headPic sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.nameLab.text = model.nickname;
    self.timeLab.text = model.date;
    self.person_lab.text = model.name;
    self.phonrLab.text = model.phone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
