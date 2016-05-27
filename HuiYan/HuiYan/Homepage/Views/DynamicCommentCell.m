//
//  DynamicCommentCell.m
//  HuiYan
//
//  Created by zc on 16/5/27.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DynamicCommentCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "NSString+ImageString.h"
@implementation DynamicCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headPic];
        [self addSubview:self.nameLab];
        [self addSubview:self.timeLab];
        [self addSubview:self.commentLab];
    }
    return self;
}

- (UIImageView *)headPic{
    if (!_headPic) {
        self.headPic = [[UIImageView alloc]init];
        self.headPic.layer.masksToBounds = YES;
        self.headPic.layer.cornerRadius = 15;
    }
    return _headPic;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        self.nameLab = [[UILabel alloc]init];
        self.nameLab.textColor = COLOR_WithHex(0xa5a5a5);
        self.nameLab.font = kFONT16;
    }
    return _nameLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        self.timeLab = [[UILabel alloc]init];
        self.timeLab.textColor = COLOR_WithHex(0xa5a5a5);
        self.timeLab.font = kFONT14;
        self.timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

- (UILabel *)commentLab{
    if (!_commentLab) {
        self.commentLab = [[UILabel alloc]init];
        self.commentLab.textColor = COLOR_WithHex(0x565656);
        self.commentLab.font = kFONT14;
    }
    return _commentLab;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.headPic.frame = CGRectMake(14, 8, 30, 30);
    self.nameLab.frame = CGRectMake(CGRectGetMaxX(self.headPic.frame) + 15, 8, 150, 30);
    self.timeLab.frame = CGRectMake(kScreen_Width - 165, 8, 150, 30);
}

- (void)setContent:(NSDictionary *)dic{
    CGSize size =  [dic[@"comment"] boundingRectWithSize:CGSizeMake(kScreen_Width - 30, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{
                                                          NSFontAttributeName :self.commentLab.font
                                                          }
                                                context:nil].size;
    self.commentLab.frame = CGRectMake(15, 38, kScreen_Width - 30, size.height);
    [self.headPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringFormatting:dic[@"avatar"]]]];
    self.nameLab.text = dic[@"nickname"];
    self.timeLab.text = dic[@"createtime"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
