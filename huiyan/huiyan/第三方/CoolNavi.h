//
//  CoolNavi.h
//  CoolNaviDemo
//
//  Created by ian on 15/1/19.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaStar.h"
typedef void(^FocusActorBlock) (UIButton *);
@interface CoolNavi : UIView
@property (nonatomic, weak) UIScrollView *scrollView;
// image action
@property (nonatomic, copy) void(^imgActionBlock)();
@property (nonatomic,strong) UIImageView *bg_img;
@property (nonatomic,strong) UIButton *edit_btn;
@property (nonatomic,strong) UIImageView *head_img;
@property (nonatomic,strong) UIImageView *fans_first_img;
@property (nonatomic,strong) UIImageView *fans_second_img;
@property (nonatomic,strong) UIImageView *fans_third_img;
@property (nonatomic,strong) UIImageView *more_img;
@property (nonatomic,strong) UILabel *giftList_lab;
@property (nonatomic,strong) UILabel *name_lab;
@property (nonatomic,strong) UILabel *fansNum_lab;
@property (nonatomic,strong) UIButton *focus_btn;
@property (nonatomic,copy) FocusActorBlock focus;
- (void)setContent:(DramaStar *)drama;
-(void)updateSubViewsWithScrollOffset:(CGPoint)newOffset;

@end
