//
//  PopView.m
//  huiyan
//
//  Created by zc on 16/7/29.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PopView.h"

@interface PopView ()

@end

@implementation PopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (IBAction)player:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(postLiving)]) {
        [self.delegate postLiving];
    }
}

- (IBAction)postActivity:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector  :@selector(postActivity)]) {
         [self.delegate postActivity];
    }
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
