//
//  LoginView.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "LoginView.h"
#import "Constant.h"


#define itemWidth 275
#define itemHeight 38
#define topMargin 71+44
#define gaps 32
#define botMargin 48
#define buttonGap 66
#define buttonWidth 53
#define botGap 30

@interface LoginView()<UITextFieldDelegate>
{
    CGRect _referenceFrame;
    UIColor* _bgColor;
}

@end

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _referenceFrame = CGRectMake((kScreen_Width-itemWidth)/2, topMargin, itemWidth, itemHeight);
    _bgColor = [UIColor colorWithWhite:1 alpha:0.3];
    
    [self.bgView addSubview:self.mobile];
    [self.bgView addSubview:self.password];
    [self.bgView addSubview:self.forgotPass];
    [self.bgView addSubview:self.login];
    [self.bgView addSubview:self.weiXin];
    [self.bgView addSubview:self.QQ];
    [self.bgView addSubview:self.thirdParty];
    
    [self addSubview:self.bgView];
    
    return self;
}

-(UITextField *)mobile
{
    if (!_mobile) {
        _mobile = [[UITextField alloc] init];
        [_mobile setBackgroundColor:_bgColor];
        _mobile.layer.cornerRadius = 5;
        _mobile.layer.masksToBounds = YES;
        _mobile.text = @"请输入手机号";
        _mobile.textColor = [UIColor whiteColor];
        _mobile.delegate = self;
        _mobile.userInteractionEnabled = YES;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_mobile setLeftViewMode:UITextFieldViewModeAlways];
        [_mobile setLeftView:spacerView];
    }
    return _mobile;
}

-(UITextField *)password
{
    if (!_password) {
        _password = [[UITextField alloc] init];
        [_password setBackgroundColor:_bgColor];
        _password.layer.cornerRadius = 5;
        _password.layer.masksToBounds = YES;
        _password.text = @"请输入密码";
        _password.textColor = [UIColor whiteColor];
        _password.delegate = self;
        _password.userInteractionEnabled = YES;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_password setLeftViewMode:UITextFieldViewModeAlways];
        [_password setLeftView:spacerView];
    }
    return _password;
}

-(UIButton *)forgotPass
{
    if (!_forgotPass) {
        _forgotPass = [[UIButton alloc] init];
       
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@" 忘记密码 ?"];

        [tncString addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:(NSRange){0,[tncString length]}];
        [tncString addAttribute:NSForegroundColorAttributeName  value:[UIColor
                                                                        whiteColor] range:(NSRange){0,[tncString length]}];
        [tncString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:(NSRange){0,[tncString length]}];
        
        [_forgotPass setAttributedTitle:tncString forState:UIControlStateNormal];
        
    }
    return _forgotPass;
}

-(UIButton *)login
{
    if (!_login) {
        _login = [[UIButton alloc] init];
        [_login setBackgroundColor:[UIColor whiteColor]];
        [_login setTitleColor:COLOR_WithHex(0xe54863) forState:UIControlStateNormal];
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        _login.layer.cornerRadius = 5;
        _login.layer.masksToBounds = YES;
    }
    return _login;
}

-(UILabel *)thirdParty
{
    if (!_thirdParty) {
        _thirdParty = [[UILabel alloc] init];
        _thirdParty.text = @"第三方账号登录";
        _thirdParty.textColor = [UIColor whiteColor];
        _thirdParty.textAlignment = NSTextAlignmentCenter;
    }
    return _thirdParty;
}

-(UIButton *)weiXin
{
    if(!_weiXin){
        _weiXin = [[UIButton alloc] init];
        [_weiXin setImage:[UIImage imageNamed:@"weChat"] forState:UIControlStateNormal];
    }
    return _weiXin;
}

-(UIButton *)QQ
{
    if (!_QQ) {
        _QQ = [[UIButton alloc] init];
        [_QQ setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
    }
    return _QQ;
}

-(UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:self.frame];
        [_bgView setUserInteractionEnabled:YES];
    }
    return _bgView;
}

-(void)layoutSubviews
{
    [self.mobile setFrame:_referenceFrame];
    [self.password setFrame:CGRectOffset(_referenceFrame, 0, gaps+itemHeight)];
    [self.forgotPass setFrame:CGRectOffset(self.password.frame, 0, gaps+itemHeight)];
    [self.login setFrame:CGRectOffset(self.forgotPass.frame, 0, gaps+itemHeight)];
    [self.weiXin setFrame:CGRectMake(kScreen_Width/2-buttonGap/2-buttonWidth, kScreen_Height-botMargin-buttonWidth, buttonWidth, buttonWidth)];
    [self.QQ setFrame:CGRectOffset(self.weiXin.frame, buttonWidth+buttonGap, 0)];
    [self.thirdParty setFrame:CGRectMake(0, kScreen_Height-buttonGap-botMargin-buttonWidth-20, kScreen_Width, 20)];
}


@end
