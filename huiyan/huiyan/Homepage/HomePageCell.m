//
//  HomePageCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePageCell.h"
#import "Constant.h"
@implementation HomePageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.image_pic = [[UIImageView alloc]init];
        [self addSubview:self.image_pic];
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.font  = kFONT(21);
       self.title_lab.textColor = kTitleBlackColor;
        [self addSubview:self.title_lab];
        self.actor_lab = [[UILabel alloc]init];
        self.actor_lab.font = kFONT16;
        self.actor_lab.textColor = kTitlrGrayColor;
        [self addSubview:self.actor_lab];
        self.description_lab = [[UILabel alloc]init];
        self.description_lab.font = kFONT16;
        self.description_lab.textColor = kTitlrGrayColor;
        self.description_lab.numberOfLines = 2;
        [self addSubview:self.description_lab];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.image_pic.frame = CGRectMake(kMargin, 10, 75, 112.5);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_pic.frame) + 17, CGRectGetMinY(self.image_pic.frame) + 12, kScreen_Width - 150, 21);
    self.actor_lab.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame), CGRectGetMaxY(self.title_lab.frame) + 12, kScreen_Width - 150, 16);
    self.description_lab.frame = CGRectMake(CGRectGetMinX(self.actor_lab.frame), CGRectGetMaxY(self.actor_lab.frame) + 12, kScreen_Width - 150, 32);
}

@end
