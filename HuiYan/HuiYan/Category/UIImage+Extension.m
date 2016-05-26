//
//  UIImage+Extension.m
//  微博个人详情页
//
//  Created by 莫名 on 16/1/18.
//  Copyright © 2016年 黄易. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 使用颜色填充上下文
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    // 渲染图形上下文
    CGContextFillRect(context, rect);
    
    // 获取上下文
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
