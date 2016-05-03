//
//  StarDetailTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/18.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaStar.h"
typedef void(^FocusActorBlock) (UIButton *);
@interface StarDetailTableViewCell : UIView
@property (nonatomic,strong) UIImageView *bg_img;
@property (nonatomic,strong) UIButton *return_btn;
@property (nonatomic,strong) UIImageView *head_img;
@property (nonatomic,strong) UIButton *focus_btn;

@property (nonatomic,strong) UIButton *edit_btn;
@property (nonatomic,strong) UIImageView *fans_first_img;
@property (nonatomic,strong) UIImageView *fans_second_img;
@property (nonatomic,strong) UIImageView *fans_third_img;
@property (nonatomic,strong) UIImageView *more_img;
@property (nonatomic,strong) UILabel *giftList_lab;
@property (nonatomic,strong) UILabel *name_lab;
@property (nonatomic,strong) UILabel *fansNum_lab;

- (void)setContent:(DramaStar *)drama;
@property (nonatomic,copy) FocusActorBlock focus;
@end
