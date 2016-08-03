//
//  PopView.h
//  huiyan
//
//  Created by zc on 16/7/29.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ClickDelegate <NSObject>
- (void)postActivity;
- (void)postLiving;
@end
@interface PopView : UIView
@property (nonatomic, assign) id<ClickDelegate> delegate;
@end
