//
//  DramaStarTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStarTableViewCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
@implementation DramaStarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.head_img];
        [self addSubview:self.like_img];
        [self addSubview:self.flower_img];
        [self addSubview:self.name_lab];
        [self addSubview:self.des_lab];
        [self addSubview:self.like_lab];
        [self addSubview:self.flower_lab];
        [self addSubview:self.invatation_btn];
    }
    return self;
}

- (UIImageView *)head_img{
    if (!_head_img) {
        self.head_img = [[UIImageView alloc]init];
    }
    return _head_img;
}

- (UILabel *)name_lab{
    if (!_name_lab) {
        self.name_lab = [[UILabel alloc]init];
        self.name_lab.font = kFONT16;
        self.name_lab.textColor = COLOR_WithHex(0x2f2f2f);
    }
    return _name_lab;
}

- (UILabel *)des_lab{
    if (!_des_lab) {
        self.des_lab = [[UILabel alloc]init];
        self.des_lab.font = kFONT12;
        self.des_lab.numberOfLines = 4;
        self.des_lab.textColor = COLOR_WithHex(0x565656);
    }
    return _des_lab;
}

- (UIImageView *)like_img{
    if (!_like_img) {
        self.like_img = [[UIImageView alloc]init];
    }
    return _like_img;
}

- (UILabel *)like_lab{
    if (!_like_lab) {
        self.like_lab = [[UILabel alloc]init];
        self.like_lab.font = kFONT12;
        self.like_lab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return _like_lab;
}

- (UIImageView *)flower_img{
    if (!_flower_img) {
        self.flower_img = [[UIImageView alloc]init];
    }
    return _flower_img;
}

- (UILabel *)flower_lab{
    if (!_flower_lab) {
        self.flower_lab = [[UILabel alloc]init];
        self.flower_lab.font = kFONT12;
        self.flower_lab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return _flower_lab;
}

- (UIButton *)invatation_btn{
    if (!_invatation_btn) {
        self.invatation_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.invatation_btn setTitle:@"邀约" forState:UIControlStateNormal];
        [self.invatation_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.invatation_btn.backgroundColor = COLOR_THEME;
        self.invatation_btn.layer.masksToBounds = YES;
        self.invatation_btn.layer.cornerRadius = 3;
    }
    return _invatation_btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.head_img.frame = CGRectMake(kMargin, kMargin, 110, 110);
    self.name_lab.frame = CGRectMake(CGRectGetMaxX(self.head_img.frame) + 12, CGRectGetMinY(self.head_img.frame), kScreen_Width - 110 - 2 * kMargin - 12, 16 * 1.5);
    self.des_lab.frame = CGRectMake(CGRectGetMinX(self.name_lab.frame), CGRectGetMaxY(self.name_lab.frame), CGRectGetWidth(self.name_lab.frame), 110 - 24);
    self.like_img.frame = CGRectMake(kMargin, CGRectGetMaxY(self.head_img.frame) + 15, 25, 25);
    self.like_lab.frame = CGRectMake(CGRectGetMaxX(self.like_img.frame), CGRectGetMinY(self.like_img.frame), 60, 25);
    self.flower_img.frame = CGRectMake(CGRectGetMaxX(self.like_lab.frame) + 10, CGRectGetMinY(self.like_lab.frame), 25, 25);
    self.flower_lab.frame = CGRectMake(CGRectGetMaxX(self.flower_img.frame) + 10, CGRectGetMinY(self.flower_img.frame), 80, 25);
    self.invatation_btn.frame = CGRectMake(kScreen_Width - 15 - 70, CGRectGetMinY(self.flower_lab.frame), 70, 25);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
