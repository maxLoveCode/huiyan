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

#define mobileDefault @"请输入手机号"
#define passwordDefault @"请输入密码"
#define veriDefault @"请输入验证码"

@interface LoginView()<UITextFieldDelegate>
{
    CGRect _referenceFrame;
    CGRect _referenceBgFrame;
    UIColor* _bgColor;
    NSArray* _stringArray;
}

@end

@implementation LoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //_referenceFrame = CGRectMake((kScreen_Width-itemWidth)/2, topMargin, itemWidth, itemHeight);
    _referenceFrame = CGRectMake((kScreen_Width-itemWidth)/2, 0, itemWidth, itemHeight);
    
    _referenceBgFrame = CGRectMake(0, topMargin, kScreen_Width*2, itemHeight);
    _bgColor = [UIColor colorWithWhite:1 alpha:0.3];
    
    _stringArray = @[mobileDefault, passwordDefault, veriDefault];
    
    [self.bgView addSubview:self.u_mobile];
    [self.bgView addSubview:self.u_pass_veri];
    [self.bgView addSubview:self.thirdPart];
    [self.bgView addSubview:self.lastPart];
    
    [self.bgView addSubview:self.weiXin];
    [self.bgView addSubview:self.QQ];
    [self.bgView addSubview:self.thirdParty];
  
    [self addSubview:self.bgView];
    
    return self;
}

-(UIView *)u_mobile
{
    if (!_u_mobile) {
        _u_mobile = [[UIView alloc] init];
        [_u_mobile addSubview:self.mobile];
        [_u_mobile addSubview:self.reg_mobile];
    }
    return _u_mobile;
}

-(UITextField *)mobile
{
    if (!_mobile) {
        _mobile = [[UITextField alloc] init];
        [_mobile setBackgroundColor:_bgColor];
        _mobile.layer.cornerRadius = 5;
        _mobile.layer.masksToBounds = YES;
        _mobile.text =  mobileDefault;
        _mobile.textColor = [UIColor whiteColor];
        _mobile.delegate = self;
        _mobile.userInteractionEnabled = YES;
        _mobile.tag = 0;
        _mobile.keyboardType = UIKeyboardTypePhonePad;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_mobile setLeftViewMode:UITextFieldViewModeAlways];
        [_mobile setLeftView:spacerView];
    }
    return _mobile;
}

-(UITextField *)reg_mobile
{
    if (!_reg_mobile) {
        _reg_mobile = [[UITextField alloc] init];
        [_reg_mobile setBackgroundColor:_bgColor];
        _reg_mobile.layer.cornerRadius = 5;
        _reg_mobile.layer.masksToBounds = YES;
        _reg_mobile.text = mobileDefault;
        _reg_mobile.textColor = [UIColor whiteColor];
        _reg_mobile.delegate = self;
        _reg_mobile.userInteractionEnabled = YES;
        _reg_mobile.tag = 0;
        _reg_mobile.keyboardType = UIKeyboardTypePhonePad;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_reg_mobile setLeftViewMode:UITextFieldViewModeAlways];
        [_reg_mobile setLeftView:spacerView];
    }
    return _reg_mobile;
}

-(UIView *)u_pass_veri
{
    if (!_u_pass_veri) {
        _u_pass_veri = [[UIView alloc] init];
        [_u_pass_veri addSubview:self.password];
        [_u_pass_veri addSubview:self.vericode];
    }
    return _u_pass_veri;
}

-(UITextField *)password
{
    if (!_password) {
        _password = [[UITextField alloc] init];
        [_password setBackgroundColor:_bgColor];
        _password.layer.cornerRadius = 5;
        _password.layer.masksToBounds = YES;
        _password.text = passwordDefault;
        _password.textColor = [UIColor whiteColor];
        _password.delegate = self;
        _password.userInteractionEnabled = YES;
        _password.tag = 1;
        _password.keyboardType = UIKeyboardTypeAlphabet;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_password setLeftViewMode:UITextFieldViewModeAlways];
        [_password setLeftView:spacerView];
    }
    return _password;
}

-(UITextField *)vericode
{
    if (!_vericode) {
        _vericode = [[UITextField alloc] init];
        [_vericode setBackgroundColor:_bgColor];
        _vericode.layer.cornerRadius = 5;
        _vericode.layer.masksToBounds = YES;
        _vericode.text = veriDefault;
        _vericode.textColor = [UIColor whiteColor];
        _vericode.delegate = self;
        _vericode.userInteractionEnabled = YES;
        _vericode.tag = 2;
        _vericode.keyboardType = UIKeyboardTypeNumberPad;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_vericode setLeftViewMode:UITextFieldViewModeAlways];
        [_vericode setLeftView:spacerView];
        
        UIButton *timer = [[UIButton alloc] initWithFrame:CGRectMake(itemWidth/3*2+15, 0, itemWidth/3-15, itemHeight-20)];
        timer.titleLabel.font = [UIFont systemFontOfSize:12];
        [timer setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.timer = timer;
        [_vericode setRightViewMode:UITextFieldViewModeAlways];
        [_vericode setRightView:timer];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(timer.frame), 1, 1, itemHeight-2)];
        [label setBackgroundColor:[UIColor whiteColor]];
        [_vericode addSubview:label];
    }
    return _vericode;
}

-(UIView *)thirdPart
{
    if (!_thirdPart) {
        _thirdPart = [[UIView alloc] init];
        [_thirdPart addSubview:self.forgotPass];
        [_thirdPart addSubview:self.confirmPass];
    }
    return _thirdPart;
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

-(UITextField *)confirmPass
{
    if (!_confirmPass) {
        _confirmPass = [[UITextField alloc] init];
        [_confirmPass setBackgroundColor:_bgColor];
        _confirmPass.layer.cornerRadius = 5;
        _confirmPass.layer.masksToBounds = YES;
        _confirmPass.text = passwordDefault;
        _confirmPass.textColor = [UIColor whiteColor];
        _confirmPass.delegate = self;
        _confirmPass.userInteractionEnabled = YES;
        _confirmPass.tag = 1;
        _confirmPass.keyboardType = UIKeyboardTypeAlphabet;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_confirmPass setLeftViewMode:UITextFieldViewModeAlways];
        [_confirmPass setLeftView:spacerView];
    }
    return _confirmPass;
}

-(UIButton *)login
{
    if (!_login) {
        _login = [[UIButton alloc] init];
        [_login setBackgroundColor:[UIColor whiteColor]];
        [_login setTitleColor:COLOR_WithHex(0xe54863) forState:UIControlStateNormal];
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        [_login addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
        _login.layer.cornerRadius = 5;
        _login.layer.masksToBounds = YES;
    }
    return _login;
}

-(UIButton *)signUp
{
    if (!_signUp) {
        _signUp = [[UIButton alloc] init];
        [_signUp setBackgroundColor:[UIColor whiteColor]];
        [_signUp setTitleColor:COLOR_WithHex(0xe54863) forState:UIControlStateNormal];
        [_signUp setTitle:@"注册" forState:UIControlStateNormal];
        [_signUp addTarget:self action:@selector(signUpButton) forControlEvents:UIControlEventTouchUpInside];
        _signUp.layer.cornerRadius = 5;
        _signUp.layer.masksToBounds = YES;
    }
    return _signUp;
}

-(UIView *)lastPart
{
    if (!_lastPart) {
        _lastPart = [[UIView alloc] init];
        [_lastPart addSubview:self.signUp];
        [_lastPart addSubview:self.login];
    }
    return _lastPart;
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
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}

-(void)layoutSubviews
{
    [self.mobile setFrame:_referenceFrame];
    [self.reg_mobile setFrame:CGRectOffset(_referenceFrame, kScreen_Width, 0)];
    [self.u_mobile setFrame:_referenceBgFrame];
    
    [self.password setFrame:_referenceFrame];
    [self.vericode setFrame:CGRectOffset(_referenceFrame, kScreen_Width, 0)];
    [self.u_pass_veri setFrame:CGRectOffset(_referenceBgFrame, 0, gaps+itemHeight)];
    
    [self.forgotPass setFrame:_referenceFrame];
    [self.confirmPass setFrame:CGRectOffset(_referenceFrame, kScreen_Width, 0)];
    [self.thirdPart setFrame:CGRectOffset(self.u_pass_veri.frame, 0, gaps+itemHeight)];
    
    [self.login setFrame:_referenceFrame];
    [self.signUp setFrame:CGRectOffset(_referenceFrame, kScreen_Width, 0)];
    [self.lastPart setFrame:CGRectOffset(self.thirdPart.frame, 0, gaps+itemHeight)];
    
    [self.weiXin setFrame:CGRectMake(kScreen_Width/2-buttonGap/2-buttonWidth, kScreen_Height-botMargin-buttonWidth, buttonWidth, buttonWidth)];
    [self.QQ setFrame:CGRectOffset(self.weiXin.frame, buttonWidth+buttonGap, 0)];
    [self.thirdParty setFrame:CGRectMake(0, kScreen_Height-buttonGap-botMargin-buttonWidth-20, kScreen_Width, 20)];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString: [_stringArray objectAtIndex:textField.tag]]) {
        textField.text = @"";
    }
    if (textField == _confirmPass || textField == _password) {
        textField.secureTextEntry = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        if (textField == _confirmPass || textField == _password) {
            textField.secureTextEntry = NO;
        }
        textField.text = [_stringArray objectAtIndex:textField.tag];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard {
    [_mobile resignFirstResponder];
    [_reg_mobile resignFirstResponder];
    [_password resignFirstResponder];
    [_vericode resignFirstResponder];
    [_confirmPass resignFirstResponder];
}

#pragma mark button event listener
-(void)loginButton{
    [self.delegate loginViewDidSelectLogin:self];
}

-(void)signUpButton{
    [self.delegate loginViewDidSelectSignUp:self];
}

@end
