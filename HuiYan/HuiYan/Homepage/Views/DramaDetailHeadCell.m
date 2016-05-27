//
//  DramaDetailHeadCell.m
//  huiyan
//
//  Created by zc on 16/5/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaDetailHeadCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ImageEffects.h"
#import "Constant.h"
@implementation DramaDetailHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUp];
    // Initialization code
}

- (void) setUp{
    self.headPic.layer.masksToBounds = YES;
    self.headPic.layer.cornerRadius = 40.5;
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [self viewWithTag:100 + i];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 21;
    }
    [self addSubview:self.lineLab];
    UIColor *color = COLOR_THEME;
    [self.videoBtn setTitleColor:color forState:UIControlStateNormal];
    [self.descriptionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (UILabel *)lineLab{
    if (!_lineLab) {
        self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 0.5, CGRectGetMaxY(self.bgPic.frame)+ 4, 1, 36)];
        self.lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _lineLab;
}

- (void)setContent:(DramaStar *)model{
    [self.headPic sd_setImageWithURL:[NSURL URLWithString:model.avator]];
    self.nameLab.text = model.nickName;
    self.focusBtn.backgroundColor = COLOR_THEME;
    self.focusBtn.layer.masksToBounds = YES;
    self.focusBtn.layer.cornerRadius = 3;
    [self.bgPic sd_setImageWithURL:[NSURL URLWithString:model.avator] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        self.bgPic.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
    }];
    [self.focusBtn addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
    self.fansLab.text = [NSString stringWithFormat:@"粉丝数 : %@人",model.fans_count];
    if (model.gift_list.count >= 3) {
        for (int i = 0; i < 3; i++) {
            UIImageView *imageView = [self viewWithTag:100 + i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[model.gift_list[i] objectForKey:@"avatar"]]];
        }
    }else{
        for (int i = 0; i < model.gift_list.count; i++) {
            UIImageView *imageView = [self viewWithTag:100 + i];
         [imageView sd_setImageWithURL:[NSURL URLWithString:[model.gift_list[i] objectForKey:@"avatar"]]];        }
    }
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
