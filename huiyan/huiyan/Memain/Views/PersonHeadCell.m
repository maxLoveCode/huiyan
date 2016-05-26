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
#import "UIImage+UIImage_Crop.h"
@implementation PersonHeadCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.bg_image addSubview:self.sex_pic];
    self.head_pic.layer.masksToBounds = YES;
    self.head_pic.layer.cornerRadius = 81 / 2;
}

- (UIImageView *)sex_pic{
    if (!_sex_pic) {
        self.sex_pic  = [[UIImageView alloc]init];
    }
    return _sex_pic;
}

- (void)setContent:(PersonMessage *)model{
    [self.head_pic sd_setImageWithURL:[NSURL URLWithString:model.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    CGSize size =  [model.nickname boundingRectWithSize:CGSizeMake(MAXFLOAT, 16)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{
                                                                 NSFontAttributeName :self.name_lab.font
                                                                 }
                                                       context:nil].size;
    [self.sex_pic setFrame:CGRectMake(CGRectGetMaxX(self.head_pic.frame) + size.width + 25, 69, 16, 16)];
    self.name_lab.text = model.nickname;
    NSString *likiStr  = @"";
    for (NSDictionary *dic in model.like_wiki) {
       likiStr = [likiStr stringByAppendingString:[NSString stringWithFormat:@"%@ ",dic[@"name"]]];
    }
    
    self.likewiki_lab.text = likiStr;
    
    self.flower_lab.text = [NSString stringWithFormat:@"送出%@朵花",model.send_flower_count];
    [self.bg_image sd_setImageWithURL:[NSURL URLWithString:model.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        self.bg_image.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
            UIImage* croped = [self.bg_image.image crop:self.bg_image.frame];
            self.bg_image.image = croped;
    }];
}

@end
