//
//  FindTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/27.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FindTableViewCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
@implementation FindTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.head_pic];
        [self addSubview:self.name_lab];
        [self addSubview:self.sex_pic];
        [self addSubview:self.occupation_one];
        [self addSubview:self.distance_lab];
    }
    return self;
}

- (UIImageView *)head_pic{
    if (!_head_pic) {
        self.head_pic  = [[UIImageView alloc]init];
        self.head_pic.layer.masksToBounds = YES;
        self.head_pic.layer.cornerRadius = 41 / 2;
    }
    return _head_pic;
}

- (UILabel *)name_lab{
    if (!_name_lab) {
        self.name_lab = [[UILabel alloc]init];
        self.name_lab.font = kFONT13;
        self.name_lab.textColor = COLOR_WithHex(0x2f2f2f);
    }
    return _name_lab;
}

- (UIImageView *)sex_pic{
    if (!_sex_pic) {
        self.sex_pic = [[UIImageView alloc]init];
        self.sex_pic.backgroundColor = [UIColor yellowColor];
    }
    return _sex_pic;
}

-(UILabel *)occupation_one{
    if (!_occupation_one) {
        self.occupation_one = [[UILabel alloc]init];
        self.occupation_one.font = kFONT13;
        self.occupation_one.backgroundColor = COLOR_WithHex(0xdddddd);
        self.occupation_one.layer.masksToBounds = YES;
        self.occupation_one.layer.cornerRadius = 5;
        self.occupation_one.textAlignment = NSTextAlignmentCenter;
        self.occupation_one.textColor = COLOR_WithHex(0x565656);
    }
    return _occupation_one;
}

- (UILabel *)distance_lab{
    if (!_distance_lab) {
        self.distance_lab = [[UILabel alloc]init];
        self.distance_lab.textAlignment = NSTextAlignmentRight;
        self.distance_lab.font = kFONT12;
        self.distance_lab.textColor = COLOR_WithHex(0x565656);
    }
    return _distance_lab;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.head_pic.frame = CGRectMake(kMargin, 10, 41, 41);
    self.name_lab.frame = CGRectMake(CGRectGetMaxX(self.head_pic.frame) + 12, CGRectGetMinX(self.head_pic.frame), 60, 16);
    self.sex_pic.frame = CGRectMake(CGRectGetMaxX(self.name_lab.frame), CGRectGetMinY(self.name_lab.frame), 16, 16);
    self.occupation_one.frame = CGRectMake(CGRectGetMinX(self.name_lab.frame), CGRectGetMaxY(self.name_lab.frame) + 5, self.occwidth, 18);
    self.distance_lab.frame = CGRectMake(kScreen_Width - kMargin - 100, 0, 100, 60);
}

- (void)setContent:(FindFriend *)model{
    [self.head_pic sd_setImageWithURL:[NSURL URLWithString:model.avatar] ];
    self.name_lab.text = model.nickname;
    
    NSString *wikiStr = @"";
    for (NSString *str in model.like_wiki) {
       wikiStr =  [wikiStr stringByAppendingString:[NSString stringWithFormat:@"%@ ",str]];
    }
    CGSize size =  [wikiStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 18)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{
                                                          NSFontAttributeName :self.occupation_one.font
                                                          }
                                                context:nil].size;
    if ([wikiStr isEqualToString:@""]) {
        self.occupation_one.hidden = YES;
    }
    self.occupation_one.text = wikiStr;
    self.occwidth = size.width;
    self.distance_lab.text = model.distance;
    if ([model.sex isEqualToString:@"1"]) {
        self.sex_pic.image = [UIImage imageNamed:@"male"];
    }else{
        self.sex_pic.image = [UIImage imageNamed:@"female"];
    }
    
}

@end
