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
    [self.view addSubview:self.webView];
}

- (UIWebView *)webView{
    if (!_webView) {
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height - 64 )];
         _webView.delegate = self;
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
    return _webView;
}

#pragma mark -- UIWebViewDelegate

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
      [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];

    self.view.backgroundColor = [UIColor redColor];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];

}

@end
