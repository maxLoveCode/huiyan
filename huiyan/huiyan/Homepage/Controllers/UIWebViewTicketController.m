//
//  UIWebViewTicketController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "UIWebViewTicketController.h"
#import "UITabBarController+ShowHideBar.h"
#import "ServerManager.h"
#import "Constant.h"
@interface UIWebViewTicketController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation UIWebViewTicketController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]init];
    _webView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64);
    _webView.delegate = self;
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
    ServerManager *serverManager = [ServerManager sharedInstance];
    NSString *urlStr = [NSString stringWithFormat:@"http://139.196.32.98/huiyan/index.php/Api/Opera/select_floor/access_token/%@/oid/%@/did/%@",serverManager.accessToken,self.oid,self.ID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [_webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

@end
