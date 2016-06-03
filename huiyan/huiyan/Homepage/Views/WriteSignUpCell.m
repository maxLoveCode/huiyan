//
//  WriteSignUpCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WriteSignUpCell.h"
#import "Constant.h"
@implementation WriteSignUpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.h_lab.layer.masksToBounds = YES;
    self.h_lab.layer.cornerRadius = 3;
    self.h_lab.backgroundColor = COLOR_THEME;
    self.name_textField.borderStyle = UITextBorderStyleRoundedRect;
    self.mobile_textField.borderStyle = UITextBorderStyleRoundedRect;
    self.mobile_textField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
