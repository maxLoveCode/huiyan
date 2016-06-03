//
//  ImportantNotesCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ImportantNotesCell.h"
#import "Constant.h"
#define kMessage @"1.报名成功后3-5个工作日内,将有工作人员与您联系。\n2.本次报名仅针对18岁以上人群。\n3.活动开始前一周可申请取消。"
@implementation ImportantNotesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.sure_btn.layer.masksToBounds = YES;
    self.sure_btn.layer.cornerRadius = 5;
    self.sure_btn.backgroundColor = COLOR_THEME;
  //  self.mes_lab.text = kMessage;
    self.line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    self.h_lab.layer.masksToBounds = YES;
    self.h_lab.layer.cornerRadius = 3;
    self.h_lab.backgroundColor = COLOR_THEME;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
