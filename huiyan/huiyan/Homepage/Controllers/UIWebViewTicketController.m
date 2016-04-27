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
#import "MQPayClient.h"
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

- (UIWebView *)webView{
    if (!_webView) {
        self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, kScreen_Width, kScreen_Height - 64 )];
         _webView.delegate = self;
        ServerManager *serverManager = [ServerManager sharedInstance];
        NSString *user_id = kOBJECTDEFAULTS(@"user_id");
        NSString *urlStr = [NSString stringWithFormat:@"http://139.196.32.98/huiyan/index.php/Api/Opera/select_floor/access_token/%@/oid/%@/did/%@/uid/%@",serverManager.accessToken,self.oid,self.ID,user_id];
        NSLog(@"url = %@",urlStr);
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
            payCon.data_str = data;
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

//-(void)buy
//{
//    // 获取订单信息
//    NSString *partner = @"2088021412701123";
//    NSString *seller = @"zhifubao@huayinwenhua.com";
//    NSString *privateKey = @"MIICXAIBAAKBgQDEcf//TAUh+3g+LyU08tLclkfp2mqzkQ5XEif23xeXuJhYsDTpzU0Ob15EB16aoUa4E5nOhcxwdnASaB18evvVQtf1ERkC2HQqjf/5fR/inNLtLlJ/nsCIaFQ+fmSPYivvbHYZ1ufpl78smPsVhHKPj9Z3E3zgvo6kAq3/QbUBlQIDAQABAoGAd4rL9saDBRfrJyQ3Zw4xROzqnCM+9UDbUh8JVNCToc9CXg30VSaKsrMQ0SMO7dggmdnLqgJ/0xwvvPPApcSNRDsIzQ+62XoN7oaaSiApDjExeTMRyz/HfR357K4EgDey9gAsh4yxz8aQ5TrIhRnqZJtNmw/QmDm1NASrBBCPN+ECQQDwqN7bDKnMklXXYzzjW4CtcRpAnOc9AaDFrxpkmLuQ2Y3itQDOBo4P+sv+3kGVrQdSmNsUzs0Nfh07YdsTOuHNAkEA0Pehro30WcTTYZLAFvoTd2lOW53/IO1nyiQ6f1Nt6CP6smcsqAvArhdaFrPU2QvUrgXYJT+FQ0ancI/3nC126QJAIm/nw+yh95YRFosq0VXsqeT/XrOVG1O6T89otXBtlqKq/P/tp42kkoDO5B+lvudNnvIkl2uoR//96ttr3+qTGQJAJdhDKtbAoyVXVvt52G9v6RdkPolttCvquRw4j+ivJfSmKXswBjsiqSTHhwcIjEptORsL2ysW2mlIV8VrBZjiSQJBANSRLnRbCM8hn6MlmjkhwEbWCRUBMg8bF1Y2jh0oXR5vBOWdAbFIzHEhw7IXt56F/AYoOi1iKvNEeIKQ3nCslNc=";
//    
//    Order * order = [[Order alloc]init];
//    
//    order.partner = partner;
//    order.seller = seller;
//    if (unpaid) {
//        order.tradeNO = [_dataSource objectForKey:@"order_no"];
//    }
//    else
//    {
//        order.tradeNO = [_dataSource objectForKey:@"clear_order_no"]; //订单ID（由商家自行制定）
//    }
//    order.productName = @"设备出租";
//    NSString *strUrl = kServerPayUrl;
//    
//    NSString *notify;
//    if (unpaid)
//        notify = [NSString stringWithFormat:@"%@index.php/Api/Ajax/alipay_notify_clear",strUrl];
//    else
//        notify = [NSString stringWithFormat:@"%@index.php/Api/Ajax/alipay_notify_order",strUrl];
//    
//    order.notifyURL = notify;
//    // order.productDescription  = [NSString stringWithFormat:@"&body=\"{%@}-{%@}\"",_pos.eventId,[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]];
//    order.productDescription = [NSString stringWithFormat:@"%@这是描述",order.productName];
//    
//    //order.amount = [NSString stringWithFormat:@"%.2f",[_RMB.text doubleValue]]; //商品价格
//    order.amount = @"0.01";
//    if (unpaid)
//    {
//        order.amount = [_dataSource objectForKey:@"first_price"];
//    }
//    else
//        order.amount = [_dataSource objectForKey:@"clear_price"];
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"dreamove";
//    
//    
//    //将商品信息拼接成字符串
//    NSString *orderSpec = [order description];
//    NSLog(@"-----orderSpec = %@--------",orderSpec);
//    
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    
//    //将签名成功字符串格式化为订单字符串,请严格按照该格式
//    NSString *orderString = nil;
//    if (signedString != nil) {
//        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                       orderSpec, signedString, @"RSA"];
//        
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"pay %@",resultDic);
//            NSLog(@"memo %@", [resultDic objectForKey:@"memo"]);
//            NSNumber *resultCode = [resultDic objectForKey:@"resultStatus"];
//            
//            if(resultCode.integerValue == 9000)
//            {
//                _dataSource = nil;
//                [self loadNetData];
//            }
//            else if (resultCode.integerValue  == 6001)
//            {
//                KALERTVIEW(@"用户终止支付");
//            }
//            else
//            {
//                KALERTVIEW(@"购买失败,请联系客服");
//            }
//        }];
//    }
//}

//- (void)payForWeixin
//{
//    
//    
//    NSString *strUrl = @"http://139.196.32.98/huiyan";
//    NSString *notify;
//    NSString* orderstring;
//    if (unpaid) {
//        notify = [NSString stringWithFormat:@"%@index.php/Api/Ajax/wx_notify_order",strUrl];
//        orderstring = [_dataSource objectForKey:@"order_no"];
//    }
//    else
//    {
//        notify = [NSString stringWithFormat:@"%@index.php/Api/Ajax/wx_notify_clear",strUrl];
//        orderstring = [_dataSource objectForKey:@"clear_order_no"];
//    }
//    [MQPayClient shareInstance].notifyUrl = notify;
//    NSString *amount;
//    if (unpaid)
//    {
//        amount = [NSString stringWithFormat:@"%.0lf", [[_dataSource objectForKey:@"first_price"] floatValue]*100 ];
//    }
//    else
//        amount = [NSString stringWithFormat:@"%.0lf", [[_dataSource objectForKey:@"clear_price"] floatValue]*100 ];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//    [[MQPayClient shareInstance]weiXinPayWithTitle:@"设备预约" money:amount tradeNo:orderstring successBlock:^(NSDictionary *res) {
//        NSString* resultcode = [res objectForKey:@"code"];
//        NSLog(@"%@, %@",res, resultcode);
//        [SVProgressHUD dismiss];
//        if ([resultcode integerValue] == 0) {
//            _dataSource = nil;
//            [self loadNetData];
//        }
//        else
//        {
//            KALERTVIEW(@"购买失败,请联系客服");
//        }
//        [SVProgressHUD dismiss];
//    } failureBlock:^(NSDictionary *result) {
//        KALERTVIEW(@"购买失败,请联系客服");
//        [SVProgressHUD dismiss];
//    }];
//}








@end
