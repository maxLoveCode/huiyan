//
//  TrainOrdersCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainOrdersCell.h"
#import "UIImageView+WebCache.h"
@implementation TrainOrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContent:(TrainOrderDetail *)model{
    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.title_lab.text = model.title;
    self.time_lab.text = model.date;
    self.address_lab.text = model.address;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
