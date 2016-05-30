//
//  DynamicImageTableViewCell.m
//  huiyan
//
//  Created by zc on 16/5/26.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DynamicImageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#define kImageWidth (kScreen_Width - 60) / 3
@implementation DynamicImageTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.onePic];
        [self.contentView addSubview:self.twoPic];
        [self.contentView addSubview:self.threePic];
        [self.contentView addSubview:self.lineLab];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.typePic];
    }
    return self;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.font = kFONT14;
        self.timeLab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return _timeLab;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        self.titleLab = [[UILabel alloc]init];
        self.titleLab.font = kFONT16;
        self.titleLab.numberOfLines = 2;
        self.titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}

- (UIImageView *)onePic{
    if (!_onePic) {
        self.onePic = [[UIImageView alloc]init];
        self.onePic.tag = 100;
    }
    return _onePic;
}

- (UIImageView *)twoPic{
    if (!_twoPic) {
        self.twoPic = [[UIImageView alloc]init];
        self.twoPic.tag = 101;
    }
    return _twoPic;
}

- (UIImageView *)threePic{
    if (!_threePic) {
        self.threePic = [[UIImageView alloc]init];
        self.threePic.tag = 102;
    }
    return _threePic;
}

- (UILabel *)lineLab{
    if (!_lineLab) {
        self.lineLab = [[UILabel alloc]init];
        self.lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _lineLab;
}

- (UIButton *)likeBtn{
    if (!_likeBtn) {
        self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.likeBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
    }
    return _likeBtn;
}

- (UIButton *)commentBtn{
    if (!_commentBtn) {
        self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [self.commentBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
    }
    return _commentBtn;
}

- (UIImageView *)typePic{
    if (!_typePic) {
        self.typePic = [[UIImageView alloc]init];
    }
    return _typePic;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    self.timeLab.frame = CGRectMake(15, 22.5, 200, 14);
    self.titleLab.frame = CGRectMake(15, CGRectGetMaxY(self.timeLab.frame) + 22.5, kScreen_Width - 30, 36);
    self.onePic.frame = CGRectMake(15, CGRectGetMaxY(self.titleLab.frame) + 22.5, kImageWidth, kImageWidth);
    self.twoPic.frame = CGRectMake(CGRectGetMaxX(self.onePic.frame) + 15, CGRectGetMaxY(self.titleLab.frame) + 22.5, kImageWidth, kImageWidth);
    self.threePic.frame = CGRectMake(CGRectGetMaxX(self.twoPic.frame) + 15, CGRectGetMaxY(self.titleLab.frame) + 22.5, kImageWidth, kImageWidth);
    self.lineLab.frame = CGRectMake(15, CGRectGetMaxY(self.onePic.frame) + 10, kScreen_Width - 30, 1);
    self.likeBtn.frame = CGRectMake(15, CGRectGetMaxY(self.lineLab.frame), (kScreen_Width - 30) / 3, 50);
    self.commentBtn.frame = CGRectMake(CGRectGetMaxX(self.likeBtn.frame), CGRectGetMinY(self.likeBtn.frame), CGRectGetWidth(self.likeBtn.frame), 50);
    self.typePic.frame = CGRectMake(kScreen_Width - 45, CGRectGetMaxY(self.lineLab.frame)+ 15, 25, 25);
}

- (void)setContent:(StarVideo *)model{
    self.timeLab.text = model.createtime;
    self.titleLab.text = model.title;
    [self.likeBtn setImage:[UIImage imageNamed:@"dramazan"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[UIImage imageNamed:@"dramavideo"] forState:UIControlStateNormal];
    self.commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    self.likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    [self.likeBtn setTitle:model.like_count forState:UIControlStateNormal];
    [self.commentBtn setTitle:model.comment_count forState:UIControlStateNormal];
    if (model.content.count >=3) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imagePic = [self.contentView viewWithTag:100 + i];
            [imagePic sd_setImageWithURL:[NSURL URLWithString:model.content[i]]];
        }
      
    }else{
        for (int i = 0; i < model.content.count; i++) {
            UIImageView *imagePic = [self.contentView viewWithTag:100 + i];
            [imagePic sd_setImageWithURL:[NSURL URLWithString:model.content[i]]];
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
