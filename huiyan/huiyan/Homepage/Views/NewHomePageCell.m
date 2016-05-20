//
//  NewHomePageCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "NewHomePageCell.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
@implementation NewHomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.name_lab];
        [self addSubview:self.image_pic];
    }
    return  self;
}

- (UIImageView *)image_pic{
    if (!_image_pic) {
        self.image_pic = [[UIImageView alloc]init];
    }
    return _image_pic;
}

- (UILabel *)name_lab{
    if (!_name_lab) {
        self.name_lab = [[UILabel alloc]init];
        self.name_lab.font = kFONT16;
        self.name_lab.textColor = COLOR_WithHex(0x2f2f2f);
        self.name_lab.text = @"标题";
        self.name_lab.textAlignment = NSTextAlignmentCenter;
    }
    return _name_lab;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.image_pic setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width / 1.6)];
    [self.name_lab setFrame:CGRectMake(0, CGRectGetMaxY(self.image_pic.frame), kScreen_Width, 50)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-  (void)setContent:(HomePage *)model{
    self.name_lab.text = model.title;
    NSData *jsonData = [model.imgs dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *data_arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    NSString *video_pic = [NSString stringWithFormat:@"%@?vframe/jpg/offset/1/w/800/h/500",data_arr[0]];

    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:video_pic]];
}

@end