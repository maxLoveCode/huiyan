//
//  MessageTableViewCell.m
//  huiyan
//
//  Created by zc on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "Constant.h"
#import "Message.h"

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
        _title.font = kFONT18;
    }
    return _title;
}

-(UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = kFONT14;
        _content.textColor = [UIColor darkTextColor];
        _content.numberOfLines = 0;
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
    [self.title setFrame:CGRectMake(kMargin, kMargin, kScreen_Width, 18)];
    [self.content setFrame:CGRectMake(kMargin, kMargin+18, kScreen_Width, 100-CGRectGetMaxY(self.title.frame)+20)];
}

-(void)setCellContent:(Message*)msg
{
    self.content.text = msg.content;
    self.title.text = msg.title;
}

@end
