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
        [self addSubview:self.image_pic];
        [self.image_pic addSubview:self.name_lab];
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
        self.name_lab.textColor = [UIColor whiteColor];
        self.name_lab.text = @"标题";
        self.name_lab.font = [UIFont boldSystemFontOfSize:16];
        self.name_lab.textAlignment = NSTextAlignmentCenter;
    }
    return _name_lab;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.image_pic setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width *0.75)];
    [self.name_lab setFrame:CGRectMake(0, CGRectGetHeight(self.image_pic.frame) / 2 - 8, kScreen_Width, 16)];
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

    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:video_pic]
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         self.image_pic.alpha = 0;
         [UIView animateWithDuration:0.2 animations:^{
             self.image_pic.alpha = 1;
         }];
     }];

}

@end
