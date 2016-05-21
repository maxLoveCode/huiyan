//
//  DramaStarInvatationCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/18.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStarInvatationCell.h"
#import "Constant.h"
@implementation DramaStarInvatationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.name_textField setValue:COLOR_WithHex(0xa5a5a5) forKeyPath:@"_placeholderLabel.textColor"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
