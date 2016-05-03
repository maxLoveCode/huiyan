//
//  FriendsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FriendsViewController.h"
#import "Constant.h"
#import "ServerManager.h"
@interface FriendsViewController ()

@property (nonatomic, assign) NSString* token;
@property (nonatomic, strong) ServerManager* serverManager;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"戏友";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:RongIdentity];
    if (!_token) {
        
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
