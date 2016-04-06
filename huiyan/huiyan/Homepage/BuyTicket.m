//
//  WikiViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "BuyTicket.h"
#import "Constant.h"

@interface BuyTicket ()
@property (nonatomic, strong) UIView *head_view;
@end

@implementation BuyTicket
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.image_pic];
        [self addSubview:self.title_lab];
        [self addSubview:self.time_lab];
        [self addSubview:self.address_lab];
        [self addSubview:self.price_lab];
        [self addSubview:self.buy_btn];
    }
    return self;
}
- (UIView *)head_view{
    if (!_head_view) {
        self.head_view = [[UIView alloc]init];
        self.head_view.backgroundColor = COLOR_WithHex(0xefefef);
        UILabel *up_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
        up_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [self.head_view addSubview:up_lab];
        UILabel *down_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, kScreen_Width, 0.5)];
        down_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [self.head_view addSubview:down_lab];
    }
    return _head_view;
}
- (UIImageView *)image_pic{
    if (!_image_pic) {
        self.image_pic = [[UIImageView alloc]init];
    }
    return _image_pic;
}

- (UILabel *)title_lab{
    if (!_title_lab) {
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.font = kFONT14;
        self.title_lab.textColor = COLOR_WithHex(0x2f2f2f);
    }
    return _title_lab;
}

- (UILabel *)time_lab{
    if (!_time_lab) {
        self.time_lab = [[UILabel alloc]init];
        self.time_lab.font = kFONT12;
        self.time_lab.textColor = COLOR_WithHex(0x565656);
    }
    return  _time_lab;
}

- (UILabel *)address_lab{
    if (!_address_lab) {
        self.address_lab = [[UILabel alloc]init];
        self.address_lab.font = kFONT12;
        self.address_lab.textColor = COLOR_WithHex(0x565656);
    }
    return  _address_lab;
}

- (UILabel *)price_lab{
    if (!_price_lab) {
        self.price_lab = [[UILabel alloc]init];
        self.price_lab.font = kFONT12;
        self.price_lab.textColor = COLOR_WithHex(0xf94747);
    }
    return  _price_lab;
}
- (UIButton *)buy_btn{
    if (!_price_lab) {
        self.buy_btn = [[UIButton alloc]init];
    }
    return  _buy_btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.head_view.frame = CGRectMake(0, 0, kScreen_Width, 10);
    self.image_pic.frame = CGRectMake(kMargin, 10, 87, 225 / 2);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_pic.frame) + 17, CGRectGetMinY(self.image_pic.frame) + 12, kScreen_Width - 150, 14);
    self.time_lab.frame = CGRectMake(CGRectGetMaxX(self.title_lab.frame), CGRectGetMaxY(self.title_lab.frame)+ 12, kScreen_Width - 150, 12);
    self.address_lab.frame = CGRectMake(CGRectGetMinX(self.time_lab.frame), CGRectGetMaxY(self.time_lab.frame) + 12, kScreen_Width - 150, 12);
    self.price_lab.frame = CGRectMake(CGRectGetMinX(self.address_lab.frame), CGRectGetMaxY(self.address_lab.frame) + 12, 150, 12);
    self.buy_btn.frame = CGRectMake(kScreen_Width - 30 - 56, CGRectGetMaxY(self.image_pic.frame) - 20, 56, 20);
}
@end
