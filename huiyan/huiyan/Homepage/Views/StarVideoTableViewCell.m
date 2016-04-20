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
        [self.contentView addSubview:self.videoIcon];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.cellContent];
        [self.contentView addSubview:self.v_lab];
        [self.cellContent addSubview:self.picView];
        [self.cellContent addSubview:self.titleLabel];
        [self.cellContent addSubview:self.h_lab];
        [self.cellContent addSubview:self.number_playBtn];
        [self.cellContent addSubview:self.number_likeBtn];
        [self.cellContent addSubview:self.number_mesBtn];
        [self.picView addSubview:self.playBtn];

        
    }
    return self;
}

-(UIImageView *)videoIcon:(int)number
{
    if (!_videoIcon) {
        self.videoIcon = [[UIImageView alloc] init];
        self.videoIcon.backgroundColor = [UIColor redColor];
    }
    return _videoIcon;
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

-(UIView *)cellContent
{
    if (!_cellContent) {
        _cellContent = [[UIView alloc] init];
        _cellContent.backgroundColor = COLOR_WithHex(0xf5f5f5);
    }
    return _cellContent;
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

-(UILabel *)h_lab{
    if (!_h_lab) {
        self.h_lab = [[UILabel alloc]init];
        self.h_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _h_lab;
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
        [self.number_mesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.number_mesBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _number_mesBtn;
}

- (UIButton *)number_likeBtn{
    if (!_number_likeBtn) {
        self.number_likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.number_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.number_likeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _number_likeBtn;
}


- (UIButton *)number_playBtn{
    if (!_number_playBtn) {
        self.number_playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.number_playBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.number_playBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _number_playBtn;
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
    self.videoIcon.frame = CGRectMake(6, 8, 20, 20);
    self.timeLabel.frame = CGRectMake(31, 8, kScreen_Width - 31, 14 * 1.5);
    self.cellContent.frame = CGRectMake(31, CGRectGetMaxY(self.timeLabel.frame), kScreen_Width - 62, 235);
    self.v_lab.frame = CGRectMake(15.5, 28, 1, CGRectGetHeight(self.cellContent.frame));
    self.picView.frame = CGRectMake(7, 7, CGRectGetWidth(self.cellContent.frame) - 14, 167);
    self.titleLabel.frame = CGRectMake(7, 7 + 167, CGRectGetWidth(self.picView.frame), 34);
    self.h_lab.frame = CGRectMake(7, CGRectGetMaxY(self.picView.frame) + 32, CGRectGetWidth(self.picView.frame), 1);
    self.number_playBtn.frame = CGRectMake(CGRectGetMinX(self.timeLabel.frame), CGRectGetMaxY(self.h_lab.frame), CGRectGetWidth(self.titleLabel.frame) / 3, 27);
    self.number_likeBtn.frame = CGRectMake(CGRectGetMaxX(self.number_playBtn.frame), CGRectGetMaxY(self.h_lab.frame), CGRectGetWidth(self.titleLabel.frame) / 3, 27);
    self.number_mesBtn.frame = CGRectMake(CGRectGetMaxX(self.number_likeBtn.frame), CGRectGetMaxY(self.h_lab.frame), CGRectGetWidth(self.titleLabel.frame) / 3, 27);
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.picView);
    }];
    
    
    
}

- (void)setContent:(StarVideo *)starVideo{
    self.videoIcon.backgroundColor = [UIColor redColor];
    NSString *pic = [NSString stringWithFormat:@"%@?vframe/png/offset/1",starVideo.movie];
    [self.picView sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:@"bg_view"]];
    self.timeLabel.text = starVideo.createtime;
    self.titleLabel.text = starVideo.title;
    [self.number_playBtn setTitle:starVideo.play_count forState:UIControlStateNormal];
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
