//
//  CoolNavi.m
//  CoolNaviDemo
//
//  Created by ian on 15/1/19.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import "CoolNavi.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "UIImage+ImageEffects.h"
@implementation CoolNavi

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.bg_img];
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
    return self;
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
    self.bg_img.frame = CGRectMake(0 , -25, self.frame.size.width, self.frame.size.height +20);
    self.edit_btn.frame = CGRectMake(kScreen_Width - kMargin - 20 - 40,80, 40, 50);
    self.head_img.frame = CGRectMake(kMargin, 64, 81, 81);
    self.focus_btn.frame = CGRectMake(kScreen_Width - 15 - 88, CGRectGetMaxY(self.fansNum_lab.frame), 88, 33);
    self.giftList_lab.frame = CGRectMake(kMargin, 244- 36, 100, 16);
    self.name_lab.frame = CGRectMake(108, 84, 200, 18 * 1.5);
    self.fansNum_lab.frame = CGRectMake(108, 114, 300, 16 * 1.5);
    
    self.more_img.frame = CGRectMake(kScreen_Width - 15 - 20, 182+ 11, 20, 20);
    self.fans_third_img.frame = CGRectMake(kScreen_Width - 210+56+56, 182, 42, 42);
    self.fans_second_img.frame  = CGRectMake(kScreen_Width - 210 + 56, 182, 42, 42);
    self.fans_first_img.frame = CGRectMake(kScreen_Width - 210, 182, 42, 42);
}

- (void)setContent:(DramaStar *)drama{
    [self.bg_img sd_setImageWithURL:[NSURL URLWithString:drama.avator] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        self.bg_img.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
    }];
    [self.head_img sd_setImageWithURL:[NSURL URLWithString:drama.avator] placeholderImage:[UIImage imageNamed:@"1"]];
    self.name_lab.text = drama.nickName;
    self.fansNum_lab.text = [NSString stringWithFormat:@"粉丝数: %@人",drama.is_fans];
    
}

- (void)focus:(UIButton *)sender{
    if (self.focus) {
        self.focus(sender);
    }
}

@end
