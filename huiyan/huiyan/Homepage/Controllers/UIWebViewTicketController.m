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
#import "WebViewJavascriptBridge.h"
@interface UIWebViewTicketController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property WebViewJavascriptBridge* bridge;
@end

@implementation UIWebViewTicketController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]init];

    _webView.frame = CGRectMake(0,0, kScreen_Width, kScreen_Height );
    _webView.delegate = self;
    self.webView.userInteractionEnabled = YES;
    [self.view addSubview:_webView];
    ServerManager *serverManager = [ServerManager sharedInstance];
    NSString *urlStr = [NSString stringWithFormat:@"http://139.196.32.98/huiyan/index.php/Api/Opera/select_floor/access_token/%@/oid/%@/did/%@",serverManager.accessToken,self.oid,self.ID];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSLog(@"url = %@",urlStr);
    [_webView loadRequest:request];
    
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    
    [self.bridge registerHandler:@"CallHandlerID" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"message from H5: %@", data);
    }];
}


#pragma mark -- UIWebViewDelegate



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    
    NSLog(@"%@",error);
  
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@",self.view);
      [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
     NSLog(@"%@",self.view);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
      [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor redColor];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.alpha=1.0;
}

@end
