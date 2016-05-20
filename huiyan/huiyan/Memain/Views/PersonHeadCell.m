//
//  PersonHeadCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonHeadCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ImageEffects.h"
@implementation PersonHeadCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.head_pic.layer.masksToBounds = YES;
    self.head_pic.layer.cornerRadius = 81 / 2;
}

- (void)setContent:(PersonMessage *)model{
    [self.head_pic sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.name_lab.text = model.nickname;
    self.fans_lab.text = @"粉丝数:";
    self.flower_lab.text = @"送出";
    [self.bg_image sd_setImageWithURL:[NSURL URLWithString:model.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        self.bg_image.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
    }];
}

@end
