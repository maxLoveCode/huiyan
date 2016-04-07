//
//  ArticleTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "Constant.h"
@implementation ArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.image_pic];
        [self addSubview:self.gray_view];
        [self addSubview:self.title_lab];
        
    }
    return self;
}

-(UIImageView *)image_pic
{
    if (!_image_pic) {
        self.image_pic = [[UIImageView alloc]init];
        //self.image_pic.backgroundColor  = [UIColor redColor];
    }
    return _image_pic;
}

-(UILabel *)title_lab
{
    if (!_title_lab) {
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.font  = kFONT(14);
        self.title_lab.textColor = COLOR_WithHex(0xffffff);
    }
    return _title_lab;
}

- (UIView *)gray_view{
    if (!_gray_view) {
        self.gray_view = [[UIView alloc]init];
        self.gray_view.backgroundColor = COLOR_WithHex(0x000000);
        self.gray_view.alpha = 0.5;
        
    }
    return _gray_view;
}

- (UIImageView *)video_pic{
    if (!_video_pic) {
        self.video_pic  = [UIImageView alloc];
    }
    return _video_pic;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.image_pic.frame = CGRectMake(0, 10, kScreen_Width, 187);
    self.gray_view.frame = CGRectMake(0, CGRectGetMaxY(self.image_pic.frame) - 32, kScreen_Width, 32);
    self.video_pic.frame = CGRectMake(15, CGRectGetMaxY(self.image_pic.frame) - 32, 32, 32);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.video_pic.frame) + 15, CGRectGetMinX(self.gray_view.frame) + 9, 150, 14);
}
+ (CGFloat)cellHeight{
    return 197.0;
}

@end
