//
//  ArticleTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
@implementation ArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.head_view];
        [self addSubview:self.image_pic];
        [self addSubview:self.video_pic];
        [self addSubview:self.gray_view];
        [self addSubview:self.title_lab];
        
    }
    return self;
}
- (UIView *)head_view{
    if (!_head_view) {
        self.head_view = [[UIView alloc]init];
        self.head_view.backgroundColor = COLOR_WithHex(0xefefef);
        UILabel *up_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
        up_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [self.head_view addSubview:up_lab];
        UILabel *down_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, kScreen_Width, 0.5)];
        down_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [self.head_view addSubview:down_lab];
    }
    return _head_view;
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
        self.title_lab.numberOfLines = 2;
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
        self.video_pic  = [[UIImageView alloc]init];
    }
    return _video_pic;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.image_pic.frame = CGRectMake(0, 0, kScreen_Width, 187);
    self.gray_view.frame = CGRectMake(0, CGRectGetMaxY(self.image_pic.frame) - 32, kScreen_Width, 32);
    self.video_pic.frame = CGRectMake(15, CGRectGetMaxY(self.image_pic.frame) - 32, 32, 32);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.video_pic.frame) + 15, CGRectGetMinY(self.gray_view.frame) + 9, 150, 14);
    self.head_view.frame = CGRectMake(0, CGRectGetMaxY(self.gray_view.frame), kScreen_Width, 10);
}

+ (CGFloat)cellHeight{
    return 197.0;
}

- (void)setContent:(HomePage *)drama{
    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:drama.cover] placeholderImage:[UIImage imageNamed:@"arrow"]];
    self.video_pic.image = [UIImage imageNamed:@"arrow"];
    self.title_lab.text = drama.title;
    
}
@end
