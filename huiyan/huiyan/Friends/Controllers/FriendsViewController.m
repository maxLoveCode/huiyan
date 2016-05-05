//
//  FriendsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FriendsViewController.h"
#import "ZCBannerView.h"
#import "LoginViewController.h"


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
    
    self.displayConversationTypeArray = @[@(ConversationType_PRIVATE),@(ConversationType_SYSTEM)];                                                                                                                                                                                                                                                                                                                                                                    
    [[RCIM sharedRCIM] connectWithToken:_token success:^(NSString *userId) {
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

- (void)viewWillAppear:(BOOL)animated
{
    
}

-(UIView *)loginRequest
{
    if (!_loginRequest) {
        _loginRequest = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        [_loginRequest addSubview:self.login];
    }
    return _loginRequest;
}

-(UIButton *)login
{
    if (!_login) {
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        [_login setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@" 请先去登录 "];
        
        [tncString addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:(NSRange){0,[tncString length]}];
        [tncString addAttribute:NSForegroundColorAttributeName  value:[UIColor
                                                                       darkTextColor] range:(NSRange){0,[tncString length]}];
        [tncString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0] range:(NSRange){0,[tncString length]}];
        
        [_login setAttributedTitle:tncString forState:UIControlStateNormal];
        [_login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login;
}

-(void)loginAction{
    LoginViewController* view = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    RCConversationBaseCell* cell = [[RCConversationBaseCell alloc]init];
    cell.model = model;
    return cell;
}

-(void)didTapCellPortrait:(RCConversationModel *)model
{
    
}

@end
