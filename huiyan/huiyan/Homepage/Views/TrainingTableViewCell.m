//
//  TrainingTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainingTableViewCell.h"
#import "Constant.h"
@implementation TrainingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.image_pic];
        [self addSubview:self.title_lab];
        [self addSubview:self.time_lab];
        [self addSubview:self.count_lab];
        [self addSubview:self.enroll_btn];
    }
    return self;
}

- (UIImageView *)image_pic{
    if (!_image_pic) {
        self.image_pic = [[UIImageView alloc]init];
    }
    return _image_pic;
}

- (UILabel *)title_lab{
    if (!_title_lab) {
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.font = kFONT14;
        self.title_lab.textColor = COLOR_WithHex(0x2f2f2f);
    }
    return _title_lab;
}

- (UILabel *)time_lab{
    if (!_time_lab) {
        self.time_lab = [[UILabel alloc]init];
        self.time_lab.font = kFONT12;
        self.time_lab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return  _time_lab;
}

- (UILabel *)count_lab{
    if (!_count_lab) {
        self.count_lab = [[UILabel alloc]init];
        self.count_lab.font = kFONT12;
        self.count_lab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return  _count_lab;
}
- (UIButton *)enroll_btn{
    if (!_enroll_btn) {
        self.enroll_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.enroll_btn.backgroundColor = [UIColor whiteColor];
        [self.enroll_btn setTitle:@"立即报名" forState:UIControlStateNormal];
        self.enroll_btn.titleLabel.font = kFONT15;
        UIColor *color = COLOR_THEME
        [self.enroll_btn setTitleColor:color forState:UIControlStateNormal];
        self.enroll_btn.layer.masksToBounds = YES;
        self.enroll_btn.layer.cornerRadius = 3;
        self.enroll_btn.layer.borderColor = color.CGColor;
        self.enroll_btn.layer.borderWidth = 2;
    }
    return  _enroll_btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.image_pic.frame = CGRectMake(kMargin, 15, 94, 122);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_pic.frame) + kMargin , CGRectGetMinY(self.image_pic.frame) , kScreen_Width - 150, 16 * 1.5);
    self.time_lab.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame) , CGRectGetMaxY(self.title_lab.frame), kScreen_Width - 150, 14 * 1.5);
    self.count_lab.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame) , CGRectGetMaxY(self.time_lab.frame), 150, 14 * 1.5);
    self.enroll_btn.frame = CGRectMake(kScreen_Width - 91 - 15, CGRectGetMaxY(self.image_pic.frame) - 29, 91, 29);
}
- (void)setContent:(Training *)train{
    self.title_lab.text = train.title;
    self.time_lab.text  = train.date;
    self.count_lab.text = [NSString stringWithFormat:@"%d人报名",[train.count integerValue]];
    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:train.cover] placeholderImage:[UIImage imageNamed:@"arrow"]];
    
}


@end
