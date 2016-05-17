//
//  PersonDramaTicketCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/15.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonDramaTicketCell.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
@implementation PersonDramaTicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.time_lab.textColor = COLOR_THEME;
    // Configure the view for the selected state
}

- (void)setContent:(PersonDramaTicket *)model{
    [self.head_pic sd_setImageWithURL:[NSURL URLWithString:model.opera_cover]];
    self.title_lab.text = model.opera_title;
    self.time_lab.text = model.opera_date;
    self.address_lab.text = model.theater_name;
    self.Count_lab.text = [NSString stringWithFormat:@"数量: %@张   总价: %@",model.pay_num,model.pay_price];
}

@end
