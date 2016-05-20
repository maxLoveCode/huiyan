//
//  UnBindMobileViewController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/16.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnBindMobileViewController : UIViewController
@property (nonatomic,copy) NSString *mobile;
@property (weak, nonatomic) IBOutlet UILabel *text_lab;
@property (weak, nonatomic) IBOutlet UIButton *UnBind;
@property (nonatomic,strong) UIView *bind_view;
@property (weak, nonatomic) IBOutlet UILabel *mobile_lab;
@end
