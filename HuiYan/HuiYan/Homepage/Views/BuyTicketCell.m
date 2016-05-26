//
//  WikiViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "BuyTicketCell.h"
#import "Constant.h"

#define titleFontSize 14
#define imageWidth 87
#define imageHeight 225/2
#define cellTopMargin 10
#define buttonWidth 56

@interface BuyTicketCell ()
@property (nonatomic, strong) UIView *down_lab;
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
        [self addSubview:self.down_lab];
    }
    return self;
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
        self.time_lab.font = kFONT13;
        self.time_lab.textColor = COLOR_WithHex(0x565656);
    }
    return  _time_lab;
}

- (UILabel *)address_lab{
    if (!_address_lab) {
        self.address_lab = [[UILabel alloc]init];
        self.address_lab.font = kFONT13;
        self.address_lab.textColor = COLOR_WithHex(0x565656);
    }
    return  _address_lab;
}

- (UILabel *)price_lab{
    if (!_price_lab) {
        self.price_lab = [[UILabel alloc]init];
        self.price_lab.font = kFONT13;
        self.price_lab.textColor = COLOR_WithHex(0xf94747);
    }
    return  _price_lab;
}

- (UIView *)down_lab
{
    if (!_down_lab) {
        self.down_lab = [[UIView alloc] init];
        [self.down_lab setBackgroundColor:COLOR_WithHex(0xdddddd)];
    }
    return _down_lab;
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
    CGFloat labelWidth = kScreen_Width- imageWidth- 4*kMargin - buttonWidth;
    self.image_pic.frame = CGRectMake(kMargin, cellTopMargin, imageWidth, imageHeight);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_pic.frame) + kMargin , CGRectGetMinY(self.image_pic.frame)+cellTopMargin/2 , labelWidth + buttonWidth, titleFontSize * 1.5);
    self.time_lab.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame) , CGRectGetMaxY(self.title_lab.frame)+cellTopMargin/2, labelWidth + buttonWidth, 13 * 1.5);
    self.address_lab.frame = CGRectMake(CGRectGetMinX(self.time_lab.frame) , CGRectGetMaxY(self.time_lab.frame) , labelWidth + buttonWidth, 13 * 1.5);
    self.price_lab.frame = CGRectMake(CGRectGetMinX(self.address_lab.frame) , CGRectGetMaxY(self.image_pic.frame) - 12 * 1.5, 150, 13 * 1.5);
    self.buy_btn.frame = CGRectMake(kScreen_Width - buttonWidth- kMargin, CGRectGetMaxY(self.image_pic.frame) - 20, buttonWidth, 20);
    [self.down_lab setFrame:CGRectMake(0, CGRectGetMaxY(self.image_pic.frame)+9, kScreen_Width, 1)];
}

- (void)setContent:(BuyTicket *)ticket{
    self.title_lab.text = ticket.title;
    self.time_lab.text  = ticket.date;
    self.address_lab.text = ticket.theater_addr;
    self.price_lab.text = ticket.price_range;
    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:ticket.cover] placeholderImage:[UIImage imageNamed:@"arrow"]];
}

@end
