//
//  WikiViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "BuyTicketCell.h"
#import "Constant.h"

@interface BuyTicketCell ()
@property (nonatomic, strong) UIView *head_view;
@property (nonatomic, strong) UILabel *up_lab;
@property (nonatomic, strong) UILabel *down_lab;
@end

@implementation BuyTicketCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.image_pic];
        [self addSubview:self.title_lab];
        [self addSubview:self.time_lab];
        [self addSubview:self.address_lab];
        [self addSubview:self.price_lab];
        [self addSubview:self.buy_btn];
        [self addSubview:self.head_view];
        [self.head_view addSubview:self.up_lab];
        [self.head_view addSubview:self.down_lab];
    }
    return self;
}
- (UIView *)head_view{
    if (!_head_view) {
        self.head_view = [[UIView alloc]init];
        self.head_view.backgroundColor = COLOR_WithHex(0xefefef);
    }
    return _head_view;
}

- (UILabel *)up_lab{
    if (!_up_lab) {
        self.up_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
        self.up_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _up_lab;
    
}

- (UILabel *)down_lab{
    if (!_down_lab) {
        self.down_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, kScreen_Width, 0.5)];
        self.down_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _down_lab;
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
    if (!_buy_btn) {
        self.buy_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buy_btn.backgroundColor = COLOR_THEME;
        [self.buy_btn setTitle:@"购票" forState:UIControlStateNormal];
        self.buy_btn.titleLabel.font = kFONT15;
        [self.buy_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.buy_btn.layer.masksToBounds = YES;
        self.buy_btn.layer.cornerRadius = 3;
    }
    return  _buy_btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.head_view.frame = CGRectMake(0, 0, kScreen_Width, 10);
    self.image_pic.frame = CGRectMake(kMargin, 20, 87, 225 / 2);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_pic.frame) + kMargin , CGRectGetMinY(self.image_pic.frame) , kScreen_Width - 150, 14 * 1.5);
    self.time_lab.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame) , CGRectGetMaxY(self.title_lab.frame), kScreen_Width - 150, 12 * 1.5);
    self.address_lab.frame = CGRectMake(CGRectGetMinX(self.time_lab.frame) , CGRectGetMaxY(self.time_lab.frame) , kScreen_Width - 150, 12 * 1.5);
    self.price_lab.frame = CGRectMake(CGRectGetMinX(self.address_lab.frame) , CGRectGetMaxY(self.image_pic.frame) - 12 * 1.5, 150, 12 * 1.5);
    self.buy_btn.frame = CGRectMake(kScreen_Width - 56- 15, CGRectGetMaxY(self.image_pic.frame) - 20, 56, 20);
}
- (void)setContent:(BuyTicket *)ticket{
    self.title_lab.text = ticket.title;
    self.time_lab.text  = ticket.date;
    self.address_lab.text = ticket.address;
    self.price_lab.text = ticket.price_range;
    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:ticket.cover] placeholderImage:[UIImage imageNamed:@"arrow"]];
  
}
@end
