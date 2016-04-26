//
//  StarDetailTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/18.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "StarDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "UIImage+ImageEffects.h"
#define KHEADHight 20
@implementation StarDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.bg_img];
        [self.bg_img addSubview:self.return_btn];
        [self.bg_img addSubview:self.edit_btn];
        [self.bg_img addSubview:self.head_img];
        [self.bg_img addSubview:self.fansNum_lab];
        [self.bg_img addSubview:self.fans_first_img];
        [self.bg_img addSubview:self.fans_second_img];
        [self.bg_img addSubview:self.fans_third_img];
        [self.bg_img addSubview:self.more_img];
        [self.bg_img addSubview:self.giftList_lab];
        [self.bg_img addSubview:self.name_lab];
        [self.bg_img addSubview:self.focus_btn];
        self.userInteractionEnabled = YES;
    }
    return  self;
}

- (UIImageView *)bg_img{
    if (!_bg_img) {
        self.bg_img = [[UIImageView alloc]init];
        self.bg_img.userInteractionEnabled = YES;
    }
    return _bg_img;
}

- (UIImageView *)head_img{
    if (!_head_img) {
        self.head_img = [[UIImageView alloc]init];
        self.head_img.layer.masksToBounds = YES;
        self.head_img.layer.cornerRadius = 81/ 2;
    }
    return _head_img;
}

- (UIButton *)return_btn{
    if (!_return_btn) {
        self.return_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _return_btn;
}

- (UIButton *)edit_btn{
    if (!_edit_btn) {
        self.edit_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.edit_btn setTitle:@"编辑" forState:UIControlStateNormal];
        self.edit_btn.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.edit_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _edit_btn;
}

- (UIImageView *)fans_first_img{
    if (!_fans_first_img) {
        self.fans_first_img = [[UIImageView alloc]init];
        self.fans_first_img.backgroundColor = [UIColor blueColor];
        self.fans_first_img.layer.masksToBounds = YES;
        self.fans_first_img.layer.cornerRadius = 21;
        self.fans_first_img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.fans_first_img.layer.borderWidth = 2;

    }
    return _fans_first_img;
}

- (UIImageView *)fans_second_img{
    if (!_fans_second_img) {
        self.fans_second_img = [[UIImageView alloc]init];
        self.fans_second_img.backgroundColor = [UIColor blackColor];
        self.fans_second_img.layer.masksToBounds = YES;
        self.fans_second_img.layer.cornerRadius = 21;
        self.fans_second_img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.fans_second_img.layer.borderWidth = 2;
    }
    return _fans_second_img;
}

- (UIImageView *)fans_third_img{
    if (!_fans_third_img) {
        self.fans_third_img = [[UIImageView alloc]init];
        self.fans_third_img.backgroundColor = [UIColor yellowColor];
        self.fans_third_img.layer.masksToBounds = YES;
        self.fans_third_img.layer.cornerRadius = 21;
        self.fans_third_img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.fans_third_img.layer.borderWidth = 2;

    }
    return _fans_third_img;
}

- (UIImageView *)more_img{
    if (!_more_img) {
        self.more_img = [[UIImageView alloc]init];
        self.more_img.backgroundColor = [UIColor redColor];
    }
    return _more_img;
}

- (UILabel *)giftList_lab{
    if (!_giftList_lab) {
        self.giftList_lab = [[UILabel alloc]init];;
        self.giftList_lab.textColor = [UIColor whiteColor];
        self.giftList_lab.font = kFONT16;
        self.giftList_lab.text = @"礼物贡献榜";
    }
    return _giftList_lab;
}

- (UILabel *)name_lab{
    if (!_name_lab) {
        self.name_lab = [[UILabel alloc]init];
        self.name_lab.textColor = [UIColor whiteColor];
        self.name_lab.font = kFONT18;
    }
    return _name_lab;
}

- (UILabel *)fansNum_lab{
    if (!_fansNum_lab) {
        self.fansNum_lab = [[UILabel alloc]init];
        self.fansNum_lab.textColor = [UIColor whiteColor];
        self.fansNum_lab.font = kFONT16;
    }
    return _fansNum_lab;
}

- (UIButton *)focus_btn{
    if (!_focus_btn) {
        self.focus_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.focus_btn setTitle:@"+关注" forState:UIControlStateNormal];
        self.focus_btn.backgroundColor = COLOR_THEME;
        self.focus_btn.layer.masksToBounds = YES;
        self.focus_btn.layer.cornerRadius = 3;
        [self.focus_btn addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
        [self.focus_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _focus_btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bg_img.frame = CGRectMake(0, 0, kScreen_Width, 200);
    self.return_btn.frame = CGRectMake(kMargin, kMargin, 20, 20);
    self.edit_btn.frame = CGRectMake(kScreen_Width - kMargin - 20 - 40, CGRectGetMinY(self.return_btn.frame), 40, 50);
    self.head_img.frame = CGRectMake(kMargin, CGRectGetMaxY(self.return_btn.frame) + 20, 81, 81);
    self.focus_btn.frame = CGRectMake(kScreen_Width - 15 - 88, CGRectGetMaxY(self.fansNum_lab.frame), 88, 33);
    self.giftList_lab.frame = CGRectMake(kMargin, CGRectGetMaxY(self.focus_btn.frame) + 30, 100, 16);
    self.name_lab.frame = CGRectMake(CGRectGetMaxX(self.head_img.frame) + kMargin, CGRectGetMinY(self.head_img.frame), 200, 18 * 1.5);
    self.fansNum_lab.frame = CGRectMake(CGRectGetMinX(self.name_lab.frame), CGRectGetMaxY(self.name_lab.frame), 300, 16 * 1.5);

    self.more_img.frame = CGRectMake(kScreen_Width - 15 - 20, CGRectGetMaxY(self.focus_btn.frame) + 20, 20, 20);
    self.fans_third_img.frame = CGRectMake(CGRectGetMinX(self.more_img.frame) - 14 - 42, CGRectGetMaxY(self.focus_btn.frame) + 10, 42, 42);
    self.fans_second_img.frame  = CGRectMake(CGRectGetMinX(self.fans_third_img.frame) - 14 - 42,CGRectGetMaxY(self.focus_btn.frame) + 10, 42, 42);
    self.fans_first_img.frame = CGRectMake(CGRectGetMinX(self.fans_second_img.frame) - 14 - 42,CGRectGetMaxY(self.focus_btn.frame) + 10, 42, 42);
}

- (void)setContent:(DramaStar *)drama{
   [self.bg_img sd_setImageWithURL:[NSURL URLWithString:drama.avator] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        self.bg_img.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
    }];
    [self.return_btn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [self.head_img sd_setImageWithURL:[NSURL URLWithString:drama.avator] placeholderImage:[UIImage imageNamed:@"1"]];
    self.name_lab.text = drama.nickName;
    self.fansNum_lab.text = [NSString stringWithFormat:@"粉丝数: %@人",drama.is_fans];
    
}

- (void)focus:(UIButton *)sender{
    if (self.focus) {
        self.focus(sender);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
