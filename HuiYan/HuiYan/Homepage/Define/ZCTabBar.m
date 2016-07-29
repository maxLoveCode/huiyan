//
//  ZCTabBar.m
//  huiyan
//
//  Created by zc on 16/7/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ZCTabBar.h"
@interface ZCTabBar()
@property (nonatomic, weak) UIButton *publishBtn;
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
        [publishBtn sizeToFit];
        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;
    }
    return _publishBtn;
}

//发布按钮点击事件
- (void)publishClick{
    ZCLogFunc
}

#pragma mark --初始化

//布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    //NSClassFromString(@"UITabBarButton") = [UITabBarButton class]
    //设置所有UITabBarButton的frame
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    //a按钮索引
    int buttonIndex = 0;
    for (UIView *subView in self.subviews) {
        //过滤掉非UITabBarButton
        if (subView.class !=NSClassFromString(@"UITabBarButton")) continue;
        CGFloat buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) {
            buttonX += buttonW;
        }
        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //增加索引
        buttonIndex++;
    }
    //设置中间按钮的frame
    self.publishBtn.zc_width = buttonW;
    self.publishBtn.zc_height = buttonH;
    self.publishBtn.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 10);
}
@end
