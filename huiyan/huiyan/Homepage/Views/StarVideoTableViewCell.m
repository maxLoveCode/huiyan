//
//  StarVideoTableViewCell.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "StarVideoTableViewCell.h"

@implementation StarVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.videoIcon];
        [self.contentView addSubview:self.timeLabel];
        
        [self.cellContent addSubview:self.player];
        [self.cellContent addSubview:self.titleLabel];
        
        [self.contentView addSubview:self.cellContent];
    }
    return self;
}

-(UIImageView *)videoIcon:(int)number
{
    if (!_videoIcon) {
        _videoIcon = [[UIImageView alloc] init];
    }
    return _videoIcon;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
    }
    return _timeLabel;
}

-(UIView *)cellContent
{
    if (!_cellContent) {
        _cellContent = [[UIView alloc] init];
    }
    return _cellContent;
}

-(ZFPlayerView*)player
{
    if (!_player) {
        _player = [[ZFPlayerView alloc] init];
    }
    return _player;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    
}

@end
