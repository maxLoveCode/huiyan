//
//  StarVideoTableViewCell.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "StarVideoTableViewCell.h"
#import <Masonry.h>
#import "Constant.h"
#import "UIImageView+WebCache.h"
@implementation StarVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.picView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.v_lab];
        [self.contentView addSubview:self.typePic];
        [self.contentView addSubview:self.number_likeBtn];
        [self.contentView addSubview:self.number_mesBtn];
        [self.picView addSubview:self.playBtn];

        
    }
    return self;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = kFONT14;
        _timeLabel.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return _timeLabel;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFONT16;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)v_lab{
    if (!_v_lab) {
        self.v_lab = [[UILabel alloc]init];
        self.v_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _v_lab;
}


- (UIButton *)playBtn{
    if (!_playBtn) {
        self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
        [self.playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)number_mesBtn{
    if (!_number_mesBtn) {
        self.number_mesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.number_mesBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        self.number_mesBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.number_mesBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.number_mesBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _number_mesBtn;
}

- (UIButton *)number_likeBtn{
    if (!_number_likeBtn) {
        self.number_likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.number_likeBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        self.number_likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
         self.number_likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.number_likeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _number_likeBtn;
}


- (UIImageView *)typePic{
    if (!_typePic) {
    self.typePic = [[UIImageView alloc]init];
    }
    return _typePic;
}

- (UIImageView *)picView{
    if (!_picView) {
        self.picView = [[UIImageView alloc]init];
        self.picView.tag = 101;
    }
    return _picView;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.timeLabel.frame = CGRectMake(15, 22.5, 200, 14 );
     self.titleLabel.frame = CGRectMake(15,CGRectGetMaxY(self.timeLabel.frame)+ 22.5, kScreen_Width - 30, 36);
    self.picView.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) + 22.5, kScreen_Width - 30, (kScreen_Width - 30) / 2);
   
    self.v_lab.frame = CGRectMake(15, CGRectGetMaxY(self.picView.frame) + 10, CGRectGetWidth(self.picView.frame), 1);
    self.number_likeBtn.frame = CGRectMake(15, CGRectGetMaxY(self.v_lab.frame) + 5, CGRectGetWidth(self.v_lab.frame) / 3, 40);
    self.typePic.frame = CGRectMake(kScreen_Width - 15 - 30, CGRectGetMaxY(self.v_lab.frame)+ 8, 30, 30);
    self.number_mesBtn.frame = CGRectMake(CGRectGetMaxX(self.number_likeBtn.frame), CGRectGetMinY(self.number_likeBtn.frame) + 5, CGRectGetWidth(self.number_likeBtn.frame), 40);
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.picView);
    }];
    
    
    
}

- (void)setContent:(StarVideo *)starVideo{
    NSString *pic = [NSString stringWithFormat:@"%@?vframe/png/offset/1",starVideo.content[0]];
    [self.picView sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:@"bg_view"]];
    self.timeLabel.text = starVideo.createtime;
    self.titleLabel.text = starVideo.title;
    [self.number_likeBtn setImage:[UIImage imageNamed:@"likewrong"] forState:UIControlStateNormal];
    [self.number_mesBtn setImage:[UIImage imageNamed:@"dramavideo"] forState:UIControlStateNormal];
    [self.number_likeBtn setTitle:starVideo.like_count forState:UIControlStateNormal];
    [self.number_mesBtn setTitle:starVideo.comment_count forState:UIControlStateNormal];
        self.playBtn.userInteractionEnabled = YES;
    self.picView.userInteractionEnabled = YES;
}

- (void)play:(UIButton *)sender{
    if (self.playBlock) {
        self.playBlock(sender);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
