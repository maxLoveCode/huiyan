//
//  UITextField+ZCExtension.m
//  ZCBaiSi
//
//  Created by zc on 16/7/18.
//  Copyright © 2016年 zc. All rights reserved.
//

#import "UITextField+ZCExtension.h"
static NSString *const ZCPlaceholderColorKey = @"placeholderLabel.textColor";
@implementation UITextField (ZCExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    NSString *oldPlacehodel = self.placeholder;
    //提前设置占位文字，目的：让它提前创建placehodelLabel
    self.placeholder = @" ";
    self.placeholder = oldPlacehodel;
    if (placeholderColor == nil) {//恢复到默认的占位文字颜色
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    //设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:ZCPlaceholderColorKey];
}

- (UIColor *)placeholderColor{
    return [self valueForKeyPath:ZCPlaceholderColorKey];
}

@end
