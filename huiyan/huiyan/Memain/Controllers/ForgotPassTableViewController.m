//
//  ForgotPassTableViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/24.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ForgotPassTableViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UIImageView+Webcache.h"
#import "UIImage+ImageEffects.h"
#import "NSString+Md5.h"

#define itemWidth 275
#define itemHeight 38
#define topMargin 71+44
#define gaps 32

#define mobileDefault @"请输入手机号"
#define passwordDefault @"请输入密码"

@interface ForgotPassTableViewController ()<UITextFieldDelegate>
{
    UIColor* _bgColor;
    NSArray* _stringArray;
}

@property (nonatomic, strong) UIImageView* bgView;
@property (nonatomic, strong) UIView* wrapperView;
@property (nonatomic, strong) UITextField* mobile;
@property (nonatomic, strong) UITextField* pass;
@property (strong,nonatomic) ServerManager* serverManager;
@property (strong,nonatomic) UIBarButtonItem* leftItem;
@property (nonatomic, strong) UIButton* login;

@end

@implementation ForgotPassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"忘记密码";
    _serverManager = [ServerManager sharedInstance];
    
    _bgColor = [UIColor colorWithWhite:1 alpha:0.3];
    
    [self navigationBarItem];
    [self.wrapperView addSubview:self.mobile];
    [self.wrapperView addSubview:self.pass];
    [self.wrapperView addSubview:self.login];
    [self.bgView addSubview:self.wrapperView];
    
    _stringArray = @[mobileDefault, passwordDefault];
    self.view = self.bgView;
    
//    if (!_type) {
//        _type = 0;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    self.wrapperView.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        self.wrapperView.alpha = 1;
    }];
    
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    self.tabBarController.tabBar.hidden = NO;
    [super viewDidDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    if (_type ==1) {
//        self.navigationController.navigationBar.barTintColor = COLOR_THEME;
//        [self.navigationController.navigationBar setTitleTextAttributes:
//         @{NSFontAttributeName:[UIFont systemFontOfSize:16],
//           NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    }
}


-(void)navigationBarItem
{
    _leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style: UIBarButtonItemStylePlain target:self action:@selector(back)];
    _leftItem.tag = -1;
    [_leftItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor],  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = _leftItem;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];
    if (_type == 1) {
        [self.navigationController dismissViewControllerAnimated:NO completion:^{
            
        }];
    }
}

-(UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
        [_bgView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        [self.bgView addGestureRecognizer:tap];
        NSURL *url = [NSURL URLWithString:@"http://7xsnr6.com2.z0.glb.clouddn.com/123.png"];
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        [self.bgView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.bgView.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
        }];
    }
    return _bgView;
}

-(UIView *)wrapperView
{
    if (!_wrapperView) {
        _wrapperView = [[UIView alloc] initWithFrame:self.bgView.frame];
    }
    return _wrapperView;
}

-(UITextField *)mobile
{
    if (!_mobile) {
        _mobile = [[UITextField alloc] initWithFrame:CGRectMake((kScreen_Width-itemWidth)/2, topMargin, itemWidth, itemHeight)];
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

-(UITextField *)pass
{
    if (!_pass) {
        _pass = [[UITextField alloc] init];
        [_pass setFrame:CGRectOffset(self.mobile.frame, 0, gaps+itemHeight)];
        [_pass setBackgroundColor:_bgColor];
        _pass.layer.cornerRadius = 5;
        _pass.layer.masksToBounds = YES;
        _pass.text = passwordDefault;
        _pass.textColor = [UIColor whiteColor];
        _pass.delegate = self;
        _pass.userInteractionEnabled = YES;
        _pass.tag = 1;
        _pass.keyboardType = UIKeyboardTypeAlphabet;
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [_pass setLeftViewMode:UITextFieldViewModeAlways];
        [_pass setLeftView:spacerView];
    }
    return _pass;
}

-(UIButton *)login
{
    if (!_login) {
        _login = [[UIButton alloc] init];
        [_login setBackgroundColor:[UIColor whiteColor]];
        [_login setTitleColor:COLOR_WithHex(0xe54863) forState:UIControlStateNormal];
        [_login setTitle:@"修改密码" forState:UIControlStateNormal];
        [_login addTarget:self action:@selector(loginButton) forControlEvents:UIControlEventTouchUpInside];
        [_login setFrame:CGRectOffset(self.pass.frame, 0, gaps*2+itemHeight*2)];
        _login.layer.cornerRadius = 5;
        _login.layer.masksToBounds = YES;
    }
    return _login;
}

-(void)dismissKeyboard {
    [_mobile resignFirstResponder];
    [_pass resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString: [_stringArray objectAtIndex:textField.tag]]) {
        textField.text = @"";
    }
    if (textField == _pass) {
        textField.secureTextEntry = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]) {
        if  (textField == _pass) {
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

-(void)loginButton
{
    NSString* mobile = _mobile.text;
    NSString* password = _pass.text;
    if ([_mobile.text isEqualToString:mobileDefault]) {
        [self showAlert:@"填写正确手机号"];
        return;
    }
    else
        mobile = _mobile.text;
    if ([_pass.text isEqualToString:passwordDefault]) {
        [self showAlert:@"填写正确密码"];
        return;
    }
    else
        password =[NSString getMd5_32Bit_String:_pass.text];
    NSDictionary* params = @{@"access_token": _serverManager.accessToken,
                             @"mobile":mobile,
                             @"password":password};
    [_serverManager AnimatedPOST:@"forget_pwd.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        [self showAlert:responseObject[@"msg"]];
        if ([responseObject[@"code"] integerValue] == 70030) {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)showAlert:(NSString*)string
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:string message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
