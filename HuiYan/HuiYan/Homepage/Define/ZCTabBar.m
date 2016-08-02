//
//  ZCTabBar.m
//  huiyan
//
//  Created by zc on 16/7/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ZCTabBar.h"
#import "PopView.h"
#import "PostActivityController.h"
@interface ZCTabBar()<ClickDelegate>
@property (nonatomic, weak) UIButton *publishBtn;
@property (nonatomic, strong) UIView *bgView;
@end
@implementation ZCTabBar

#pragma mark --懒加载
- (UIButton *)publishBtn{
    if (!_publishBtn) {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal
         ];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted
         ];
        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [publishBtn sizeToFit];
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;
    }
    return _publishBtn;
}

//发布按钮点击事件
- (void)publishClick{
    if (self.publishBtn.selected == NO) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 48)];
        self.bgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        NSArray *clickArr = [[NSBundle mainBundle] loadNibNamed:@"PopView" owner:self options:nil];
        PopView *clickView = [clickArr firstObject];
        clickView.delegate = self;
        clickView.frame = CGRectMake(0, kScreen_Height - 48 - 140, kScreen_Width, 140);
        [self.bgView addSubview:clickView];
        [[UIApplication sharedApplication].keyWindow addSubview:self.bgView];
        self.publishBtn.selected = YES;
    }else{
        [self.bgView removeFromSuperview];
        self.publishBtn.selected = NO;
    }
   
}

- (void)postActivity{
    PostActivityController *postCon = [[PostActivityController alloc]init];
    [self.window.rootViewController presentViewController:postCon animated:NO completion:^{
        self.publishBtn.selected = NO;
        [self.bgView removeFromSuperview];
    }];
}

#pragma mark --初始化

//布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.zc_width;
    CGFloat height = self.zc_height;
    
    self.publishBtn.center = CGPointMake(width * 0.5, height * 0.5);
    int index = 0;
    CGFloat tabBarBtnW = width / 5;
    CGFloat tabBarBtnH = height;
    CGFloat tabBarBtnY = 0;
    
    for (UIView *tabBarBtn in self.subviews) {
        if (![NSStringFromClass(tabBarBtn.class) isEqualToString:@"UITabBarButton"]) {
            continue;
        }
        CGFloat tabBarBtnX = index *tabBarBtnW;
        if (index >= 2) {
            tabBarBtnX += tabBarBtnW;
        }
        tabBarBtn.frame = CGRectMake(tabBarBtnX, tabBarBtnY, tabBarBtnW, tabBarBtnH);
        index ++;
    }
    //NSClassFromString(@"UITabBarButton") = [UITabBarButton class]
    //设置所有UITabBarButton的frame
//    CGFloat buttonW = self.frame.size.width / 5;
//    CGFloat buttonH = self.frame.size.height;
//    CGFloat buttonY = 0;
//    //a按钮索引
//    int buttonIndex = 0;
//    for (UIView *subView in self.subviews) {
//        //过滤掉非UITabBarButton
//        if (subView.class !=NSClassFromString(@"UITabBarButton")) continue;
//        CGFloat buttonX = buttonIndex * buttonW;
//        if (buttonIndex >= 2) {
//            buttonX += buttonW;
//        }
//        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        //增加索引
//        buttonIndex++;
//    }
//    //设置中间按钮的frame
//    self.publishBtn.zc_width = buttonW + 25;
//    self.publishBtn.zc_height = buttonH + 25;
//    self.publishBtn.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 10);
}
@end
