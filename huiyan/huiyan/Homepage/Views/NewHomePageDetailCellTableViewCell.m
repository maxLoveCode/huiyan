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
    // Initialization code
    [self addSubview:self.good_btn];
}

- (UIButton *)good_btn{
    if (!_good_btn) {
        self.good_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.good_btn setFrame:CGRectMake(kScreen_Width / 2 - 45, CGRectGetMinY(self.play_btn.frame), 100, 30)];
        self.good_btn.titleLabel.font = kFONT16;
        self.good_btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        self.good_btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        self.good_btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        [self.good_btn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
    }
    return _good_btn;
}

- (void)setContent:(HomePage *)model{
    self.name_lab.text = model.title;
    self.actor_lab.text = model.actor;
    
    if ([model.is_like isEqualToString:@"0"]) {
        [self.good_btn setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    }else{
        [self.good_btn setImage:[UIImage imageNamed:@"heartlike"] forState:UIControlStateNormal];
    }
    [self.play_btn setTitle:model.play_count forState:UIControlStateNormal];
    [self.good_btn setTitle:model.like_count forState:UIControlStateNormal];
    [self.relay_btn setTitle:model.share_count forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
