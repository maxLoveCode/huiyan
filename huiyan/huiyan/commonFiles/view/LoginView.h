//
//  LoginView.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;

@protocol LoginViewEvents <NSObject>

-(void)loginViewDidSelectLogin:(LoginView*)loginView;
-(void)loginViewDidSelectSignUp:(LoginView*)loginView;
-(void)loginViewDidSelectForgotPassword:(LoginView*)loginView;
-(void)loginViewDidSelectVeriCode:(LoginView *)loginView;
-(void)qqLogin;
- (void)weixinLogin;

@end

@interface LoginView : UIView

@property (nonatomic, strong) UIView* u_mobile;
@property (nonatomic, strong) UITextField* mobile;
@property (nonatomic, strong) UITextField* reg_mobile;//注册手机

@property (nonatomic, strong) UIView* u_pass_veri;
@property (nonatomic, strong) UITextField* password;
@property (nonatomic, strong) UITextField* vericode;

@property (nonatomic, strong) UIView* thirdPart;
@property (nonatomic, strong) UIButton* forgotPass;
@property (nonatomic, strong) UITextField* confirmPass;//注册密码

@property (nonatomic, strong) UIView* lastPart;
@property (nonatomic, strong) UIButton* login;
@property (nonatomic, strong) UIButton* signUp;

@property (nonatomic, strong) UILabel* thirdParty;
@property (nonatomic, strong) UIButton* weiXin;
@property (nonatomic, strong) UIButton* QQ;

@property (nonatomic, strong) UIImageView* bgView;

@property (nonatomic,strong) UIButton *timer;
@property (nonatomic, weak) id <LoginViewEvents> delegate;

@end
