//
//  AppDelegate.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageController.h"
#import "Constant.h"

#ifdef DEBUG
    #import "UnitTest.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self addAllController];
    
#ifdef DEBUG
    UnitTest *test = [UnitTest instance];
    NSLog(@"======== UNIT TEST START ========");
    [test testResult:^(BOOL result) {
        if (result) {
            NSLog(@"====== UNIT TEST COMPLETION =====");
        }
        else{
            NSLog(@"====== UNIT TEST FAILURE ======");
        }
    }];
#endif
    
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)addAllController{
    HomePageController *homepage = [[HomePageController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homepage]; 
    UITabBarController *tabCon = [[UITabBarController alloc]init];
    tabCon.viewControllers = @[homeNav];
    self.window.rootViewController = tabCon;
}

@end
