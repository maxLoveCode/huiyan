//
//  DynamicTextTableViewCell.m
//  HuiYan
//
//  Created by zc on 16/5/26.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DynamicTextTableViewCell.h"
#import "Constant.h"
@implementation DynamicTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUp];
}

- (void)setUp{
    self.timeLab.textColor = COLOR_WithHex(0xa5a5a5);
    [self.likeBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
}

- (void)setContent:(StarVideo *)model{
    self.timeLab.text = model.createtime;
    self.contentLab.text = model.title;
    [self.likeBtn setTitle:model.like_count forState:UIControlStateNormal];
    [self.commentBtn setTitle:model.comment_count forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
