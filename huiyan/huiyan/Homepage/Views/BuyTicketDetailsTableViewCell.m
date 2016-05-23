//
//  BuyTicketDetailsTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/8.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "BuyTicketDetailsTableViewCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ImageEffects.h"
@implementation BuyTicketDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.bg_view];
        [self.bg_view addSubview:self.image_pic];
        [self.bg_view  addSubview:self.title_lab];
        [self.bg_view  addSubview:self.time_lab];
        [self.bg_view  addSubview:self.address_lab];
        [self.bg_view  addSubview:self.time_pic];
        [self.bg_view  addSubview:self.address_pic];
        [self.bg_view  addSubview:self.price_pic];
        [self.bg_view  addSubview:self.price_lab];
        [self addSubview:self.write_textField];
        //[self addSubview:self.collect_btn];
        [self addSubview:self.writeComment_btn];
        [self addSubview:self.share_btn];
    }
    return self;
}

- (UITextField *)write_textField{
    if (!_write_textField) {
        self.write_textField = [[UITextField alloc]init];
        self.write_textField.placeholder = @"写点评";
    }
    return _write_textField;
}

- (UIImageView *)bg_view{
    if (!_bg_view) {
        self.bg_view = [[UIImageView alloc]init];
    }
    return _bg_view;
}

- (UIImageView *)image_pic{
    if (!_image_pic) {
        self.image_pic = [[UIImageView alloc]init];
    }
    return _image_pic;
}

- (UIImageView *)time_pic{
    if (!_time_pic) {
        self.time_pic = [[UIImageView alloc]init];
    }
    return _time_pic;
}

- (UIImageView *)address_pic{
    if (!_address_pic) {
        self.address_pic = [[UIImageView alloc]init];
    }
    return _address_pic;
}

- (UIImageView *)price_pic{
    if (!_price_pic) {
        self.price_pic = [[UIImageView alloc]init];
    }
    return _price_pic;
}

- (UILabel *)title_lab{
    if (!_title_lab) {
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.font = kFONT(16);
        self.title_lab.textColor = [UIColor whiteColor];
    }
    return _title_lab;
}

- (UILabel *)time_lab{
    if (!_time_lab) {
        self.time_lab = [[UILabel alloc]init];
        self.time_lab.font = kFONT(14);
        self.time_lab.textColor = [UIColor whiteColor];
    }
    return _time_lab;
}

- (UILabel *)address_lab{
    if (!_address_lab) {
        self.address_lab = [[UILabel alloc]init];
        self.address_lab.font = kFONT(14);
        self.address_lab.textColor = [UIColor whiteColor];
    }
    return _address_lab;
}

- (UILabel *)price_lab{
    if (!_price_lab) {
        self.price_lab = [[UILabel alloc]init];
        self.price_lab.font = kFONT(14);
        self.price_lab.textColor = [UIColor whiteColor];
    }
    return _price_lab;
}

- (UIButton *)collect_btn{
    if (!_collect_btn) {
        self.collect_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collect_btn.layer.masksToBounds = YES;
        self.collect_btn.layer.cornerRadius = 1;
        [self.collect_btn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    }
    return _collect_btn;
}

- (UIButton *)writeComment_btn{
    if (!_writeComment_btn) {
        self.writeComment_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.writeComment_btn.layer.masksToBounds = YES;
        self.writeComment_btn.layer.cornerRadius = 1;
        [self.writeComment_btn setImage:[UIImage imageNamed:@"evaluate"] forState:UIControlStateNormal];
    }
    return _writeComment_btn;
}

- (UIButton *)share_btn{
    if (!_share_btn) {
        self.share_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.share_btn.layer.masksToBounds = YES;
        self.share_btn.layer.cornerRadius = 1;
        [self.share_btn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    }
    return _share_btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bg_view.frame = CGRectMake(0, 0, kScreen_Width, 187);
    self.image_pic.frame = CGRectMake(15, CGRectGetMaxY(self.bg_view.frame) - 122, 94, 122);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_pic.frame) + 15, CGRectGetMinY(self.image_pic.frame), kScreen_Width - 139, 32 * 1.5);
    self.time_pic.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame), CGRectGetMaxY(self.title_lab.frame) + 5, 14, 14);
    self.time_lab.frame = CGRectMake(CGRectGetMaxX(self.time_pic.frame) + 5, CGRectGetMinY(self.time_pic.frame), kScreen_Width - 150, 14);
    self.address_pic.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame) , CGRectGetMaxY(self.time_pic.frame) + 10, 14, 14);
    self.address_lab.frame = CGRectMake(CGRectGetMaxX(self.address_pic.frame) + 5, CGRectGetMinY(self.address_pic.frame) , kScreen_Width - 150, 14);
    self.price_pic.frame = CGRectMake(CGRectGetMinX(self.address_pic.frame), CGRectGetMaxY(self.address_pic.frame) + 10, 14, 14);
    self.write_textField.frame = CGRectMake(kMargin, CGRectGetMaxY(self.bg_view.frame)+ 5, kScreen_Width / 3 * 2 - 20, 40);
    self.price_lab.frame = CGRectMake(CGRectGetMaxX(self.price_pic.frame) + 5, CGRectGetMinY(self.price_pic.frame), kScreen_Width - 150, 14);
    self.collect_btn.frame = CGRectMake(15, CGRectGetMaxY(self.bg_view.frame) + 10, (kScreen_Width - 80) / 3, (kScreen_Width - 80) / 3 / 3.1);
    self.writeComment_btn.frame = CGRectMake(15, CGRectGetMinY(self.collect_btn.frame), (kScreen_Width - 80) / 3, (kScreen_Width - 80) / 3 / 3.1 );
    self.share_btn.frame = CGRectMake(kScreen_Width - (kScreen_Width - 80) / 3 - 15 , CGRectGetMinY(self.writeComment_btn.frame), (kScreen_Width - 80) / 3, (kScreen_Width - 80) / 3 / 3.1);
    
}

+ (CGFloat)cellHeight{
    return 187 + 20 + 30;
}

- (void)setContent:(BuyTicket *)ticket{
    [self.bg_view sd_setImageWithURL:[NSURL URLWithString:ticket.cover]  placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
       self.bg_view.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
        
    }];
    
    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:ticket.cover] placeholderImage:[UIImage imageNamed:@"arrow"]];
    self.title_lab.text = ticket.title;
    self.time_lab.text = ticket.date;
    self.address_lab.text = ticket.address;
    self.price_lab.text = ticket.price_range;
    self.time_pic.image = [UIImage imageNamed:@"ticket_detail_time"];
    self.address_pic.image = [UIImage imageNamed:@"ticket_detail_address"];
    self.price_pic.image = [UIImage imageNamed:@"ticket_detail_price"];

}




@end
