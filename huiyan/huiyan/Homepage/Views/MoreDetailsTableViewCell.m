//
//  MoreDetailsTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MoreDetailsTableViewCell.h"
#import "Constant.h"
@implementation MoreDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.title_lab];
        [self addSubview:self.image_pic];
    }
    return self;
}

- (UILabel *)title_lab{
    if (!_title_lab) {
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.text = @"查看更多详情";
        self.title_lab.textColor = [UIColor blackColor];
        self.title_lab.font = kFONT12;
    }
    return _title_lab;
}

- (UIImageView *)image_pic{
    if (!_image_pic) {
        self.image_pic = [[UIImageView alloc]init];
        self.image_pic.backgroundColor = [UIColor redColor];
    }
    return _image_pic;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.title_lab.frame = CGRectMake(kMargin, 0, 100, 32);
    self.image_pic.frame = CGRectMake(kScreen_Width - 50 - kMargin, 0, 32, 32);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
