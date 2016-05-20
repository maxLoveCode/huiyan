//
//  TicketCommentTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/16.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TicketCommentTableViewCell.h"
#import "Constant.h"
@implementation TicketCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.name_lab];
        [self addSubview:self.comment_lab];
        [self addSubview:self.time_lab];
    }
    return self;
}

- (UILabel *)name_lab{
    if (!_name_lab) {
        self.name_lab = [[UILabel alloc]init];
        self.name_lab.font = kFONT12;
        self.name_lab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return _name_lab;
}

- (UILabel *)comment_lab{
    if (!_comment_lab) {
        self.comment_lab = [[UILabel alloc]init];
        self.comment_lab.font = kFONT12;
        self.comment_lab.textColor = COLOR_WithHex(0x565656);
    }
    return _comment_lab;
}

- (UILabel *)time_lab{
    if (!_time_lab) {
        self.time_lab = [[UILabel alloc]init];
        self.time_lab.font = kFONT11;
        self.time_lab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return _time_lab;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.name_lab.frame = CGRectMake(kMargin, 0, kScreen_Width - 2 * kMargin, 12*1.5);
    self.comment_lab.frame = CGRectMake(kMargin, CGRectGetMaxY(self.name_lab.frame), kScreen_Width - 2* kMargin, 24 * 1.5);
    self.time_lab.frame = CGRectMake(kMargin, CGRectGetMaxY(self.comment_lab.frame), kScreen_Width - 2 * kMargin, 15);
}

- (void)setContent:(CommentContent *)comment{
    self.name_lab.text = comment.user_name;
    self.comment_lab.text = comment.content;
    self.time_lab.text = comment.createtime;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
