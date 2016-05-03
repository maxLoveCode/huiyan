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
//友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
//高德地图
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import <RongIMKit/RongIMKit.h>

#ifdef DEBUG
    #import "UnitTest.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    //友盟
    [UMSocialData setAppKey:@"57189b72e0f55ad2c30015b6"];
    [UMSocialWechatHandler setWXAppId:@"wx2201898143065bfd" appSecret:@"b38e8146284e786e41402ddcb0b93539" url:@"http://www.umeng.com/social"];
    [UMSocialQQHandler setQQWithAppId:@"1105277071" appKey:@"x0ZYCDoulIQ2jjzi" url:@"http://www.umeng.com/social"];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    //高德
    [MAMapServices sharedServices].apiKey = @"f14d06129778c6fa6b9ee5c5f108b099";
    [AMapSearchServices sharedServices].apiKey = @"f14d06129778c6fa6b9ee5c5f108b099";
    //微信支付
    [[MQPayClient shareInstance]registerWeiXinApp:@"wxf40f735c21d329ae" mch_id:@"1268033901" mch_key:@"aTFiGZRxHCGoEBqj7KTKRMrF8IAYqVJ2" notifyUrl:@"www.qq.com"  withDescription:@"WeixinPay"];
    
#pragma mark rongyun initialization
    [[RCIM sharedRCIM] initWithAppKey:RongIMKey];
    
    MainTabBarViewController *mainTab = [[MainTabBarViewController alloc]init];
    self.window.rootViewController = mainTab;
    
#ifdef DEBUG
    UnitTest *test = [UnitTest instance];
    NSLog(@"======== UNIT TEST START ========");
    [test testResult:^(BOOL result) {
        if (result) {
            NSLog(@"====== UNIT TEST COMPLETION =====");
        }
        else{
            NSLog(@"======= UNIT TEST FAILURE =======");
        }
    }];
#endif
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //微信返回
        if ([sourceApplication hasPrefix:@"com.tencent"]) {
            [MQPayClient weiXinHandleOpenURL:url];
        }
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return result;
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //微信返回
    if ([url.absoluteString hasPrefix:@"com.tencent"]) {
        [MQPayClient weiXinHandleOpenURL:url];
    };
    return YES;
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
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UMSocialSnsService  applicationDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
