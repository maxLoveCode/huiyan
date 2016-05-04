//
//  FriendsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FriendsViewController.h"
#import "ZCBannerView.h"


@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"戏友";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:RongIdentity];
    if (!_token) {
        [self.view addSubview:self.loginRequest];
    }
    
    [[RCIM sharedRCIM] connectWithToken:@"YourTestUserToken" success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token错误");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UIView *)loginRequest
{
    if (!_loginRequest) {
        _loginRequest = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        [_loginRequest setBackgroundColor:[UIColor redColor]];
        [_loginRequest addSubview:self.login];
    }
    return _loginRequest;
}

-(UIButton *)login
{
    if (!_login) {
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        [_login setTitle:@"前往登录" forState: UIControlStateNormal];
        [_login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login;
}

-(void)loginAction{
    
}

@end
