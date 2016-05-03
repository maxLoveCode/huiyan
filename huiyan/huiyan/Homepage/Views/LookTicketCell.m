//
//  LookTicketCell.m
//  
//
//  Created by 华印mac－002 on 16/5/3.
//
//

#import "LookTicketCell.h"
#import "Constant.h"
@implementation LookTicketCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.bg_view];
        [self.bg_view addSubview:self.title_lab];
        [self.bg_view addSubview:self.time_lab];
        [self.bg_view addSubview:self.name_lab];
        [self.bg_view addSubview:self.seat_lab];
        [self.bg_view addSubview:self.mobile_lab];
        [self.bg_view addSubview:self.line_lab];
        [self.bg_view addSubview:self.code_lab];
        [self.bg_view addSubview:self.barCode_pic];
    }
    return self;
}

- (UIView *)bg_view{
    if (!_bg_view) {
        self.bg_view = [[UIView alloc]init];
        self.bg_view.backgroundColor = [UIColor whiteColor];
    }
    return _bg_view;
}

- (UILabel *)title_lab{
    if (!_title_lab) {
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.font = kFONT16;
        self.title_lab.numberOfLines = 2;
        self.title_lab.textAlignment = NSTextAlignmentLeft;

    }
    return _title_lab;
}

- (UILabel *)time_lab{
    if (!_time_lab) {
        self.time_lab = [[UILabel alloc]init];
        self.time_lab.font = kFONT14;
        self.time_lab.textColor = COLOR_THEME;
        self.time_lab.textAlignment = NSTextAlignmentLeft;

    }
    return _time_lab;
}

- (UILabel *)name_lab{
    if (!_name_lab) {
        self.name_lab = [[UILabel alloc]init];
        self.name_lab.font = kFONT14;
        self.name_lab.textAlignment = NSTextAlignmentLeft;
    }
    return _name_lab;
}

- (UILabel *)seat_lab{
    if (!_seat_lab) {
        self.seat_lab = [[UILabel alloc]init];
        self.seat_lab.font = kFONT14;
        self.seat_lab.textAlignment = NSTextAlignmentLeft;
    }
    return _seat_lab;
}

- (UILabel *)mobile_lab{
    if (!_seat_lab) {
        self.seat_lab = [[UILabel alloc]init];
        self.seat_lab.font = kFONT14;
        self.seat_lab.textAlignment = NSTextAlignmentLeft;
    }
    return _seat_lab;
}

- (UILabel *)line_lab{
    if (!_line_lab) {
        self.line_lab = [[UILabel alloc]init];
        self.line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _line_lab;
}

- (UILabel *)code_lab{
    if (!_code_lab) {
        self.code_lab = [[UILabel alloc]init];
        self.code_lab.textColor = COLOR_THEME;
    }
    return _code_lab;
}

- (UIImageView *)barCode_pic{
    if (!_barCode_pic) {
        self.barCode_pic = [[UIImageView alloc]init];
    }
    return _barCode_pic;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bg_view.frame = CGRectMake(kMargin, 0, kScreen_Width - 2 * kMargin, 200);
    self.title_lab.frame = CGRectMake(10, 10, CGRectGetWidth(self.bg_view.frame), 32 * 1.5);
    self.time_lab.frame = CGRectMake(10, CGRectGetMaxY(self.title_lab.frame), CGRectGetWidth(self.title_lab.frame), 14 * 1.5);
    self.name_lab.frame = CGRectMake(10, CGRectGetMaxY(self.time_lab.frame), CGRectGetWidth(self.time_lab.frame), 14 * 1.5);
    self.seat_lab.frame = CGRectMake(10, CGRectGetMaxY(self.name_lab.frame), CGRectGetWidth(self.name_lab.frame), 14 * 1.5);
    self.mobile_lab.frame = CGRectMake(10, CGRectGetMaxY(self.seat_lab.frame), CGRectGetWidth(self.seat_lab.frame), 14 * 1.5);
    self.line_lab.frame = CGRectMake(0, CGRectGetMaxY(self.mobile_lab.frame), CGRectGetWidth(self.bg_view.frame), 1);
    self.code_lab.frame = CGRectMake(CGRectGetWidth(self.bg_view.frame) / 2 - 100, CGRectGetMaxY(self.line_lab.frame) + 10, 200, 14);
    self.barCode_pic.frame = CGRectMake(CGRectGetWidth(self.line_lab.frame) / 2 - 75, CGRectGetMaxY(self.code_lab.frame) + 5, 150, 150);
}


@end
