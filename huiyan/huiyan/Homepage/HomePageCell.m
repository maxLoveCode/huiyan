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
        [self addSubview:self.title_lab];
        self.actor_lab = [[UILabel alloc]init];
        [self addSubview:self.actor_lab];
        self.description_lab = [[UILabel alloc]init];
        [self addSubview:self.description_lab];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.image_pic.frame = CGRectMake(kMargin, 10, 75, 112.5);
  //  self.title_lab.frame = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}

@end
