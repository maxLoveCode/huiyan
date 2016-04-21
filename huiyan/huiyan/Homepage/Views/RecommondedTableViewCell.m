//
//  RecommondedTableViewCell.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "RecommondedTableViewCell.h"
#import "Constant.h"
@implementation RecommondedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.image_pic];
        [self addSubview:self.title_lab];
        [self addSubview:self.actor_lab];
        [self addSubview:self.description_lab];
        [self addSubview:self.head_view];
        [self.head_view addSubview:self.up_lab];
        [self.head_view addSubview:self.down_lab];
    }
    
    //[self debugData];
    return self;
}

-(UIImageView *)image_pic
{
    if (!_image_pic) {
        self.image_pic = [[UIImageView alloc]init];
        //self.image_pic.backgroundColor  = [UIColor redColor];
    }
    return _image_pic;
}

-(UILabel *)title_lab
{
    if (!_title_lab) {
        self.title_lab = [[UILabel alloc]init];
        self.title_lab.font  = kFONT(14);
        self.title_lab.textColor = COLOR_WithHex(0x2f2f2f);
    }
    return _title_lab;
}

-(UILabel *)actor_lab
{
    if(!_actor_lab){
        
        self.actor_lab = [[UILabel alloc]init];
        self.actor_lab.font = kFONT14;
        self.actor_lab.textColor = COLOR_WithHex(0x565656);
    }
    return _actor_lab;
}

-(UILabel *)description_lab
{
    if (!_description_lab) {
        self.description_lab = [[UILabel alloc]init];
        self.description_lab.font = kFONT12;
        self.description_lab.textColor = COLOR_WithHex(0x565656);
        self.description_lab.numberOfLines = 3;
    }
    return _description_lab;
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


- (void)layoutSubviews{
    [super layoutSubviews];
    self.image_pic.frame = CGRectMake(kMargin, 12, 110, 150);
    self.title_lab.frame = CGRectMake(CGRectGetMaxX(self.image_pic.frame) + 10, CGRectGetMinY(self.image_pic.frame), kScreen_Width - 150, 28 *1.5);
    self.actor_lab.frame = CGRectMake(CGRectGetMinX(self.title_lab.frame), CGRectGetMaxY(self.title_lab.frame) , kScreen_Width - 150, 14 *1.5);
    self.description_lab.frame = CGRectMake(CGRectGetMinX(self.actor_lab.frame), CGRectGetMaxY(self.actor_lab.frame) , kScreen_Width - 150, 36 *1.5);
    self.head_view.frame = CGRectMake(0, CGRectGetMaxY(self.image_pic.frame) + 12, kScreen_Width, 10);
}

+ (CGFloat)cellHeight
{
    return 150+ 34;
}

-(void)setContent:(HomePage*)drama
{
    self.title_lab.text = drama.title;
    self.actor_lab.text = drama.actor;
    self.description_lab.text = drama.profile;
    [self.image_pic sd_setImageWithURL:[NSURL URLWithString:drama.cover] placeholderImage:[UIImage imageNamed:@"arrow.png"]];
}

#pragma mark Debug
- (void)debugData
{
    NSArray *title = @[@"昆剧选段<牡丹亭>", @"沪剧<金陵塔>", @"京剧<嘿嘿嘿>"];
    NSArray *actors = @[@"贾宝玉",@"林黛玉",@"演员甲",@"我是一个人"];
    NSArray *des = @[@"我是第一个介绍非常的短,大概就两行", @"我是第二个介绍就很长了哈哈哈哈哈哈", @"看看我这些话是不是很长我再试一试嘿嘿嘿嘿嘿你好不好今天好吗明天好吗我今天很开心哦,为什么这个介绍那么长呢哈哈哈哈哈哈"];
    NSString* ranTitle = title[arc4random_uniform((int)[title count])];
    NSString* ranActors = actors[arc4random_uniform((int)[actors count])];
    NSString* ranDes = des[arc4random_uniform((int)[des count])];
    
    self.title_lab.text = ranTitle;
    self.actor_lab.text = ranActors;
    self.description_lab.text = ranDes;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end