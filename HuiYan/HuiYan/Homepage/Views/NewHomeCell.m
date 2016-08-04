//
//  NewHomeCell.m
//  huiyan
//
//  Created by zc on 16/7/31.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "NewHomeCell.h"
#import <UIImageView+WebCache.h>
@interface NewHomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *headPic;
@property (weak, nonatomic) IBOutlet UILabel *peopleCount;
@property (weak, nonatomic) IBOutlet UIImageView *coverPic;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *professionLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@end

@implementation NewHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupOther];
    // Initialization code
}

- (void)setupOther{
    self.statusLab.backgroundColor = COLOR_THEME;
    self.statusLab.layer.masksToBounds = YES;
    self.statusLab.layer.cornerRadius = 3;
}

- (void)setContent:(LivingModel *)model{
    [self.headPic sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    self.nameLab.text = model.nickname;
    self.professionLab.text = model.catename;
    [self.coverPic sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.peopleCount.text = [NSString stringWithFormat:@"%@人在看",@22];
    self.titleLab.text = model.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
