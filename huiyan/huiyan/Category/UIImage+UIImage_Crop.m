//
//  UIImage+UIImage_Crop.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/24.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "UIImage+UIImage_Crop.h"

@implementation UIImage (UIImage_Crop)

- (UIImage *)crop:(CGRect)rect {
    
    rect = CGRectMake(rect.origin.x*self.scale,
                      rect.origin.y*self.scale,
                      rect.size.width*self.scale,
                      rect.size.height*self.scale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef
                                          scale:self.scale
                                    orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return result;
}

@end
