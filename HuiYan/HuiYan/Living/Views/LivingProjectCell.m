//
//  LivingProjectCell.m
//  huiyan
//
//  Created by zc on 16/8/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "LivingProjectCell.h"
@interface LivingProjectCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imagePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *playLiving;
@end

@implementation LivingProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupOther];
    // Initialization code
}

- (void)setupOther{
    self.imagePic.layer.masksToBounds = YES;
    self.imagePic.layer.cornerRadius = 10;
    self.timeLab.textColor = COLOR_THEME;
    self.playLiving.layer.masksToBounds = YES;
    self.playLiving.layer.cornerRadius = 3;
    self.playLiving.backgroundColor = COLOR_THEME;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
