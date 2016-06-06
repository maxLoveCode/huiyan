//
//  AppDelegate.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import "Constant.h"
#import "LoginViewController.h"
//微信与支付宝支付
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "MQPayClient.h"
//百度统计
#import "BaiduMobstat.h"
#import "UMMobClick/MobClick.h"
//友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
//高德地图
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#import "JPUSHService.h"//极光推送
#import <RongIMKit/RongIMKit.h>
#import "LoginViewController.h"
#import "chatUsers.h"
#import "WXApi.h"
#ifdef DEBUG
    #import "UnitTest.h"
#endif

@interface AppDelegate ()<UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIPageControl *pageControl;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]                     bounds]];
    [self.window makeKeyAndVisible];
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [self updateLocalData];
    //友盟
    [UMSocialData setAppKey:@"57189b72e0f55ad2c30015b6"];
    [UMSocialWechatHandler setWXAppId:@"wx2201898143065bfd" appSecret:@"b38e8146284e786e41402ddcb0b93539" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"1105277071" appKey:@"x0ZYCDoulIQ2jjzi" url:@"http://www.umeng.com/social"];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    //高德
    [MAMapServices sharedServices].apiKey = @"6858031d8908c18c7724109124d4125b";
    [AMapLocationServices sharedServices].apiKey = @"6858031d8908c18c7724109124d4125b";
    //百度统计
    [self startBaiduMobileStat];
    [self umengTrack];
    
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    
    // Required
    NSString *user_id = [[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"];
    if (user_id) {
        NSSet *set = [[NSSet alloc] initWithObjects:@"ios",nil];
        [JPUSHService setTags:set alias:user_id fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
           // NSString *callbackString = [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
             //[self logSet:iTags], iAlias];
           // NSLog(@"TagsAlias回调:%@", callbackString);
        }];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"f84d27fb2c1b2db531924006"
                          channel:@"Publish channel"
                 apsForProduction:false
            advertisingIdentifier:nil];
    
    [WXApi registerApp:@"wxf254787475a723f1"];
    //微信支付
   // [[MQPayClient shareInstance]registerWeiXinApp:@"wxf40f735c21d329ae" mch_id:@"1268033901" mch_key:@"aTFiGZRxHCGoEBqj7KTKRMrF8IAYqVJ2" notifyUrl:@"www.qq.com"  withDescription:@"WeixinPay"];
    
#pragma mark rongyun initialization
    [[RCIM sharedRCIM] initWithAppKey:RongIMKey];
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:RongIdentity];
    if(token)
    {
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            chatUsers* chats = [chatUsers instance];
            NSArray* conversationList = [[RCIMClient sharedRCIMClient]getConversationList:@[@1]];
           // NSLog(@"conversationList is %@", conversationList);
            for (RCConversation* target  in conversationList) {
              //  NSLog(@"target :%@", target);
                [chats getUserInfoWithUserId:[target targetId] completion:^(RCUserInfo *userInfo) {
                    	
                }];
            }

        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            NSLog(@"token错误");
        }];
    }
    if (user_id) {
        MainTabBarViewController *mainTab = [[MainTabBarViewController alloc]init];
        self.window.rootViewController = mainTab;
        [MobClick profileSignInWithPUID:user_id];
    }else{
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *navCon = [[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = navCon;
        [MobClick profileSignInWithPUID:user_id];
    }

    
    //设置UIScrollView和UIPageControl
    //判断当前程序是否是第一次运行.如果不是第一次运行，则直接进入主界面即可，不需要再加载程序启动图
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault boolForKey:@"first"] == NO) {
        //如果取出来的值为NO，说明程序为第一次启动
        [self setUpUIScrollViewAndUIPageControl];
        //将该标志置为yes
        [userDefault setBool:YES forKey:@"first"];
    }else{
       
    }
    return YES;
   
    
#ifdef DEBUG
    UnitTest *test = [UnitTest instance];
//NSLog(@"======== UNIT TEST START ========");
    [test testResult:^(BOOL result) {
        if (result) {
           // NSLog(@"====== UNIT TEST COMPLETION =====");
        }
        else{
           // NSLog(@"======= UNIT TEST FAILURE =======");
        }
    }];
#endif
    return YES;
}

//引导页面
-(void)setUpUIScrollViewAndUIPageControl{
    //创建滚动视图对像
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    //设置内容区域范围 contentSize
    self.scrollView.contentSize = CGSizeMake(kScreen_Width * 4, kScreen_Height);
    //设置整屏滚动
    self.scrollView.pagingEnabled = YES;
    //去掉水平方向上的滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理对象
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    //往scrollview上添加图片
    for (int i = 0; i < 4; i++) {
        UIImageView *_ImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"applinkpage%d",i + 1] ofType:@"png"]]];
        _ImageView.frame = CGRectMake(kScreen_Width * i, 0, kScreen_Width, kScreen_Height);
        _ImageView.userInteractionEnabled = YES;
        if (i == 3) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
            //设置轻拍手势
            tapGesture.numberOfTapsRequired = 1;
            _ImageView.userInteractionEnabled = YES;
            [_ImageView addGestureRecognizer:tapGesture];
        }
        [self.scrollView addSubview:_ImageView];
        
    }
    [self.window addSubview:_scrollView];
    
    //创建UIPageControl
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreen_Height - 40, kScreen_Width, 40)];
    //设置分页数
    //self.pageControl.backgroundColor = [UIColor redColor];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self.pageControl addTarget:self action:@selector(handleClickPage:) forControlEvents:UIControlEventValueChanged];
    [self.window addSubview:self.pageControl];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //先得到偏移量对应的分页下标
    NSInteger index = scrollView.contentOffset.x / kScreen_Width;
    //设置当前页数
    self.pageControl.currentPage = index;
}

- (void)handleClickPage:(UIPageControl *)sender{
    [self.scrollView setContentOffset:CGPointMake(kScreen_Width * sender.currentPage, 0)  animated:YES];
}


//单机手势的方法
- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    //首先移除滚动视图和分页视图
    [self.scrollView removeFromSuperview];
    [self.pageControl removeFromSuperview];
    
}




- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //微信返回
//        if ([sourceApplication hasPrefix:@"com.tencent"]) {
//            [MQPayClient weiXinHandleOpenURL:url];
//        }
//        //跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//           // NSLog(@"result = %@",resultDic);
//        }];
//    }
    return result;
    return YES;
}

 
// 启动百度移动统计
- (void)startBaiduMobileStat{
    /*若应用是基于iOS 9系统开发，需要在程序的info.plist文件中添加一项参数配置，确保日志正常发送，配置如下：
     NSAppTransportSecurity(NSDictionary):
     NSAllowsArbitraryLoads(Boolen):YES
     详情参考本Demo的BaiduMobStatSample-Info.plist文件中的配置
     */
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    statTracker.enableDebugOn = NO;
    
    [statTracker startWithAppId:@"c0e0a9d8df"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}

//友盟统计
- (void)umengTrack {
    //    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick setLogEnabled:NO];
    
    UMConfigInstance.appKey = @"5746548967e58eb1d10025c4";
    
    UMConfigInstance.secret = @"secretstringaldfkals";
    //    UMConfigInstance.eSType = E_UM_GAME;
    [MobClick startWithConfigure:UMConfigInstance];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //微信返回
    if ([url.absoluteString hasPrefix:@"com.tencent"]) {
        [MQPayClient weiXinHandleOpenURL:url];
    };
    return YES;
}

/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark - 后台接到推送消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   // NSLog(@"user info ------------%@", userInfo);
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"+++++++++收到通知:%@", [self logDic:userInfo]);
}

#pragma mark - 前台收到推送消息
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService handleRemoteNotification:userInfo];

     NSLog(@"+++++++++收到通知:%@", [self logDic:userInfo]);
       [[NSNotificationCenter defaultCenter]postNotificationName:@"notiction" object:self userInfo:userInfo];
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   // NSLog(@"\n ===> 程序进入前台 !");
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UMSocialSnsService  applicationDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}


- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}

#pragma mark--version control
-(void)updateLocalData
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString* builds = [userdefault objectForKey:@"version"];
    if (![builds isEqualToString:Build] || !builds || [builds isEqualToString:@""]) {
        [userdefault removeObjectForKey:@"user_id"];
        [userdefault removeObjectForKey:RongIdentity];
    }
    [userdefault setObject:Build forKey:@"version"];
}

@end
