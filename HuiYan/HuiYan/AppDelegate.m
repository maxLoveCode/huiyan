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
#import <AMapLocationKit/AMapLocationKit.h>

#import "JPUSHService.h"//极光推送
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
    [MAMapServices sharedServices].apiKey = @"6858031d8908c18c7724109124d4125b";
    [AMapLocationServices sharedServices].apiKey = @"6858031d8908c18c7724109124d4125b";
    
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
           // NSString *callbackString =
            [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
             [self logSet:iTags], iAlias];
           // NSLog(@"TagsAlias回调:%@", callbackString);
        }];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"f84d27fb2c1b2db531924006"
                          channel:@"Publish channel"
                 apsForProduction:FALSE
            advertisingIdentifier:nil];
    
    
    //微信支付
   // [[MQPayClient shareInstance]registerWeiXinApp:@"wxf40f735c21d329ae" mch_id:@"1268033901" mch_key:@"aTFiGZRxHCGoEBqj7KTKRMrF8IAYqVJ2" notifyUrl:@"www.qq.com"  withDescription:@"WeixinPay"];
    
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
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"+++++++++收到通知:%@", [self logDic:userInfo]);
}

#pragma mark - 前台收到推送消息
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
     NSLog(@"+++++++++收到通知:%@", [self logDic:userInfo]);
    
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
    NSLog(@"\n ===> 程序进入前台 !");
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
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
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
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

@end
