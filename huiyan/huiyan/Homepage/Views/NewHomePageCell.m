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
#define fontsize 18
#define maskalpha 0.9
@implementation NewHomePageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.image_pic];
        [self.image_pic addSubview:self.mask];
        [self.image_pic addSubview:self.name_lab];
        [self setBackgroundColor:[UIColor blackColor]];
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
        self.name_lab.font = [UIFont boldSystemFontOfSize:fontsize];
        self.name_lab.shadowColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
        self.name_lab.shadowOffset = CGSizeMake(1, 1);
        self.name_lab.textAlignment = NSTextAlignmentCenter;
    }
    return _name_lab;
}

-(UIImageView *)mask
{
    if (!_mask) {
        _mask = [[UIImageView alloc] init];
        _mask.alpha = maskalpha;
        _mask.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    }
    return _mask;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.image_pic setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width *5/7)];
    [self.mask setFrame:self.image_pic.frame];
    [self.name_lab setFrame:CGRectMake(0, CGRectGetHeight(self.image_pic.frame) / 2 - fontsize/2, kScreen_Width, fontsize)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-  (void)setContent:(HomePage *)model{
//    self.name_lab.text = model.title;
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: model.title];
    [attrStr addAttribute:NSKernAttributeName value:@(4.0) range:NSMakeRange(0, attrStr.length)];
    self.name_lab.attributedText = attrStr;
//    NSData *jsonData = [model.imgs dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSArray *data_arr = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    NSString *video_pic = [NSString stringWithFormat:@"%@?vframe/jpg/offset/1/w/800/h/500",data_arr[0]];
    NSURL *url = [NSURL URLWithString: model.cover_1];
    [self.mask setImage:[UIImage imageNamed:@"mask.png"]];
    [self.image_pic sd_setImageWithURL:url
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         //if (cacheType == SDImageCacheTypeNone) {
             self.image_pic.alpha = 0;
            self.name_lab.alpha = 0;
             [UIView animateWithDuration:0.6 animations:^{
                 self.image_pic.alpha = 1;
                 self.name_lab.alpha = 1;
             }];
         //}
     }];

}

@end
