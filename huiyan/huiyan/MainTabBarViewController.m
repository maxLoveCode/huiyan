//
//  MainTabBarViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/21.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "WikiWorksDetailsViewController.h"
#import "ZFPlayer.h"
#import "DramaStarViewController.h"
#import "DynamicDetailViewController.h"
#import <TSMessage.h>
#import <TSBlurView.h>
#import <TSMessageView.h>
#import "UIImage+Extension.h"
#import "PendingListViewController.h"
#import "ZCTabBar.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   //  [self setupItemTitleTextAttributes];
    [self addAllController];
     [self setupTabBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotifictionView:) name:@"notiction" object:nil];
    // [self setupItemTitleTextAttributes];
    
    
    
     // Do any additional setup after loading the view.
}
    
- (void)setupTabBar{
    [self setValue:[[ZCTabBar alloc]init] forKey:@"tabBar"];

}

//- (void)setupItemTitleTextAttributes{
//    UITabBarItem *item = [UITabBarItem appearance];
//    
//    //普通状态下文字属性
//    NSMutableDictionary *normalAtts = [NSMutableDictionary dictionary];
//    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    normalAtts[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
//    //选中状态下文字属性
//    NSMutableDictionary *selectedAtts = [NSMutableDictionary dictionary];
//    selectedAtts[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    [item setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
//}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showNotifictionView:(NSNotification *)notifation{
    NSDictionary *userInfo = notifation.userInfo;
   [[TSMessageView appearance] setContentTextColor:[UIColor whiteColor]];
    [[TSMessageView appearance] setTitleTextColor:[UIColor whiteColor]];
    
    NSDictionary *aps = userInfo[@"aps"];
    if ([userInfo[@"type "] isEqualToString:@"add_friend"]) {
        [TSMessage showNotificationInViewController:self
                                              title:@"您有一条新的消息"
                                           subtitle:aps[@"alert"]
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationAutomatic
                                           callback:nil
                                        buttonTitle:@"去看看"
                                     buttonCallback:^{
                                         NSLog(@"按钮事件");
                                         
                                         NewHomePageViewController *vc = (NewHomePageViewController *)((UINavigationController *)self.selectedViewController).viewControllers[0];
                                         [vc.navigationController popToRootViewControllerAnimated:NO];
                                         PendingListViewController *followCon = [[PendingListViewController alloc]init];
                                         [vc.navigationController pushViewController:followCon animated:YES];
                                         
                                     }
                                         atPosition:TSMessageNotificationPositionNavBarOverlay
                               canBeDismissedByUser:YES];
    }else{
          [TSMessage showNotificationWithTitle:@"您有一条新的消息" subtitle:aps[@"alert"] type:TSMessageNotificationTypeMessage];
    }
    
    
 
}

- (void)addAllController{
     //UIColor *color  = COLOR_THEME;
    NewHomePageViewController *homepage = [[NewHomePageViewController alloc]init];
    DramaStarViewController *drama = [[DramaStarViewController alloc]init];
    HomePageController *explore = [[HomePageController alloc]init];
    MeMainViewController *meMain = [[MeMainViewController alloc]init];
    [self setNavigationController:@"首页" Image:@"home" selectedImage:@"homeSel" controller:homepage];
      [self setNavigationController:@"红人" Image:@"drama" selectedImage:@"dramaSel" controller:drama];
     [self setNavigationController:@"发现" Image:@"found" selectedImage:@"foundSel" controller:explore];
     [self setNavigationController:@"我的" Image:@"mine" selectedImage:@"mineSel" controller:meMain];
    
//    [self.tabBar setTintColor:color];
//    self.tabBar.translucent  = NO;
//    self.tabBar.opaque = YES;
//    NSArray *navCon = @[homeNav,dramaNav,exploreNav,meMainNav];
//    [self setViewControllers:navCon animated:YES];
    
}




- (void)setNavigationController:(NSString *)title Image:(NSString *)imageStr selectedImage:(NSString *)selectedImageStr controller:(UIViewController *)controller{
       UIColor *color  = COLOR_THEME;
    UINavigationController *Nav = [[UINavigationController alloc]initWithRootViewController:controller];
    
    [self addChildViewController:Nav];
    
   Nav.tabBarItem.title = title;
   Nav.tabBarItem.image = [UIImage imageNamed:imageStr];
    UIImage *image = [UIImage imageNamed:selectedImageStr];
    image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Nav.tabBarItem.selectedImage = image;
    [Nav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}

//哪些界面支持自动转屏
//- (BOOL)shouldAutorotate{
//    UINavigationController *nav = self.viewControllers[self.selectedIndex];
//    if ([nav.topViewController isKindOfClass:[WikiWorksDetailsViewController class]] || [nav.topViewController isKindOfClass:[DynamicDetailViewController class]]  ) {
//        return !ZFPlayerShared.isLockScreen;
//    }
//    return NO;
//}

//viewController 支持哪些转屏方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
////    UINavigationController *nav = self.viewControllers[self.selectedIndex];
//    
//    NSLog(@"----+++++%@",self.childViewControllers[self.selectedIndex]);
//   UINavigationController *nav = self.childViewControllers[self.selectedIndex];
//    if ([nav.topViewController isKindOfClass:[WikiWorksDetailsViewController class]]) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }else if ([nav.topViewController isKindOfClass:[DynamicDetailViewController class]]){
//        if (ZFPlayerShared.isAllowLandscape) {
//            return UIInterfaceOrientationMaskAllButUpsideDown;
//        }else{
//            return UIInterfaceOrientationMaskPortrait;
//        }
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)rightClick:(UIBarButtonItem *)sender{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
