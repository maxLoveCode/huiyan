//
//  UIWebViewTicketController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewTicketController : UIViewController
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *oid;
@property (nonatomic, weak) UIButton * backItem;
@property (nonatomic, weak) UIButton * closeItem;
@property (nonatomic, weak) UIActivityIndicatorView * activityView;
@end
