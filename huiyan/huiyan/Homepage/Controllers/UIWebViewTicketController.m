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
#import "PayViewController.h"
@interface UIWebViewTicketController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property WebViewJavascriptBridge* bridge;
@end

@implementation UIWebViewTicketController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self initNaviBar];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
    
}

- (UIWebView *)webView{
    if (!_webView) {
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height - 64 )];
         _webView.delegate = self;
        ServerManager *serverManager = [ServerManager sharedInstance];
        NSString *user_id = kOBJECTDEFAULTS(@"user_id");
        NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/home/opera/select_floor/access_token/%@/oid/%@/did/%@/uid/%@",kServerUrl,serverManager.accessToken,self.oid,self.ID,user_id];
       // NSLog(@"url = %@",urlStr);
        //activityView
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.center = self.view.center;
        [activityView startAnimating];
        self.activityView = activityView;
        [self.view addSubview:activityView];
        //清除UIWebView的缓存
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0]];
        self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
        [self.bridge registerHandler:@"CallHandlerID" handler:^(id data, WVJBResponseCallback responseCallback) {
            NSLog(@"message from H5: %@", data);
            PayViewController *payCon = [[PayViewController alloc]init];
     
            NSData *jsonData = [data[@"key"]dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            payCon.data_dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
            [self.navigationController pushViewController:payCon animated:YES];
            
        }];

        
    }
    return _webView;
}


- (void)initNaviBar{
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 56, 44)];
    [backItem setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitle:@"返回" forState:UIControlStateNormal];
    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(clickedBackItem:) forControlEvents:UIControlEventTouchUpInside];
    self.backItem = backItem;
    [backView addSubview:backItem];
    
    UIButton * closeItem = [[UIButton alloc]initWithFrame:CGRectMake(44+12, 0, 44, 44)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [closeItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    closeItem.hidden = YES;
    self.closeItem = closeItem;
    [backView addSubview:closeItem];
    
    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftItemBar;
    
}

#pragma mark - clickedBackItem
- (void)clickedBackItem:(UIBarButtonItem *)btn{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        self.closeItem.hidden = NO;
    }else{
        [self clickedCloseItem:nil];
    }
}

#pragma mark - clickedCloseItem
- (void)clickedCloseItem:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    self.activityView.hidden = NO;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSLog(@"url: %@", request.URL.absoluteURL.description);
    
    if (self.webView.canGoBack) {
        self.closeItem.hidden = NO;
    }
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.activityView.hidden = YES;
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.activityView.hidden = YES;
}



@end
