//
//  UIView+ZCExtension.m
//  huiyan
//
//  Created by zc on 16/7/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "UIView+ZCExtension.h"

@implementation UIView (ZCExtension)
- (CGSize)zc_size{
    return self.frame.size;
}

- (void)setZc_size:(CGSize)zc_size{
    CGRect frame = self.frame;
    frame.size = zc_size;
    self.frame = frame;
}

- (CGFloat)zc_width{
    return self.frame.size.width;
}

- (CGFloat)zc_height{
    return self.frame.size.height;
}

- (void)setZc_width:(CGFloat)zc_width{
    CGRect frame = self.frame;
    frame.size.width = zc_width;
    self.frame = frame;
}

- (void)setZc_height:(CGFloat)zc_height{
    CGRect frame = self.frame;
    frame.size.height = zc_height;
    self.frame = frame;
}

- (CGFloat)zc_x{
    return self.frame.origin.x;
}

- (void)setZc_x:(CGFloat)zc_x{
    CGRect frame = self.frame;
    frame.origin.x = zc_x;
    self.frame = frame;
}

- (CGFloat)zc_y{
    return self.frame.origin.y;
}

- (void)setZc_y:(CGFloat)zc_y{
    CGRect frame = self.frame;
    frame.origin.y = zc_y;
    self.frame = frame;
}

- (CGFloat)zc_centerX{
    return self.center.x;
}

- (void)setZc_centerX:(CGFloat)zc_centerX{
    CGPoint center = self.center;
    center.x = zc_centerX;
    self.center = center;
}

- (CGFloat)zc_centerY{
    return self.center.y;
}

- (void)setZc_centerY:(CGFloat)zc_centerY{
    CGPoint center = self.center;
    center.y = zc_centerY;
    self.center = center;
}

- (CGFloat)zc_right{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)zc_bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setZc_right:(CGFloat)zc_right{
    self.zc_x = zc_right - self.zc_width;
}

- (void)setZc_bottom:(CGFloat)zc_bottom{
    self.zc_y = zc_bottom - self.zc_height;
}
@end
