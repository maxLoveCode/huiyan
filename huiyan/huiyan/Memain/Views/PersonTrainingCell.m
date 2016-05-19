//
//  PersonTrainingCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonTrainingCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
@implementation PersonTrainingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(TrainOrderDetail *)model{
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    self.nameLab.text = model.title;
    self.timeLab.text = model.date;
    self.addressLab.text = model.address;
    self.orderLab.text = [NSString stringWithFormat:@"订单号  %@",model.order_no];
    if ([model.is_effect isEqualToString:@"0"]) {
        self.statusLab.text = @"组团失败";
    }else if ([model.is_effect isEqualToString:@"1"]){
        self.statusLab.text = @"组团成功";
    }else{
        self.statusLab.text = @"组团中";
    }
    
    
    
}

@end
