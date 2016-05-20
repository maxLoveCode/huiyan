//
//  MessageTableViewCell.m
//  huiyan
//
//  Created by zc on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "Constant.h"

@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.title];
        [self addSubview:self.content];
    }
    return self;
}

-(UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
    }
    return _title;
}

-(UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] init];
    }
    return _content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.title setFrame:CGRectMake(kMargin, kMargin, 100, 14)];
    [self.content setFrame:CGRectMake(kMargin, kMargin+18, 100, 14)];
}

@end
