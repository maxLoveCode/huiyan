//
//  MainTabBarViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/21.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "WikiWorksDetailsViewController.h"
#import "StarDetailViewController.h"
#import "ZFPlayer.h"
#import "DramaStarViewController.h"
@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)awakeFromNib{
    self.selectedIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addAllController];
    
     // Do any additional setup after loading the view.
}

- (void)addAllController{
    UIColor *color  = COLOR_THEME;
    NewHomePageViewController *homepage = [[NewHomePageViewController alloc]init];
    
    DramaStarViewController *drama = [[DramaStarViewController alloc]init];
    
    HomePageController *explore = [[HomePageController alloc]init];
    
    
    MeMainViewController *meMain = [[MeMainViewController alloc]init];
    
    
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homepage];
    homeNav.tabBarItem.title = @"首  页";
    [homeNav.tabBarItem setImage:[UIImage imageNamed:@"home"]];
    [homeNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"homeSel"]];
    homeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [homeNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController *dramaNav = [[UINavigationController alloc]initWithRootViewController:drama];
    dramaNav.tabBarItem.title = @"红  人";
    [dramaNav.tabBarItem setImage:[UIImage imageNamed:@"drama"]];
    [dramaNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"dramaSel"]];
    dramaNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [dramaNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    UINavigationController *exploreNav = [[UINavigationController alloc]initWithRootViewController:explore];
    
    exploreNav.tabBarItem.title  = @"发  现";
    [exploreNav.tabBarItem setImage:[UIImage imageNamed:@"found"]];
    [exploreNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"foundSel"]];
    exploreNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [exploreNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController *meMainNav = [[UINavigationController alloc]initWithRootViewController:meMain];
    meMainNav.tabBarItem.title = @"我  的";
    [meMainNav.tabBarItem setImage:[UIImage imageNamed:@"mine"]];
    [meMainNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"mineSel"]];
    meMainNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [meMainNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    [self.tabBar setTintColor:color];
    self.tabBar.translucent  = NO;
    self.tabBar.opaque = YES;
    NSArray *navCon = @[homeNav,dramaNav,exploreNav,meMainNav];
    [self setViewControllers:navCon animated:YES];
}

//哪些界面支持自动转屏
- (BOOL)shouldAutorotate{
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    if ([nav.topViewController isKindOfClass:[WikiWorksDetailsViewController class]] || [nav.topViewController isKindOfClass:[StarDetailViewController class]]  ) {
        return !ZFPlayerShared.isLockScreen;
    }
    return NO;
}

//viewController 支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    if ([nav.topViewController isKindOfClass:[WikiWorksDetailsViewController class]]) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }else if ([nav.topViewController isKindOfClass:[StarDetailViewController class]]){
        if (ZFPlayerShared.isAllowLandscape) {
            return UIInterfaceOrientationMaskAllButUpsideDown;
        }else{
            return UIInterfaceOrientationMaskPortrait;
        }
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)rightClick:(UIBarButtonItem *)sender{
    NSLog(@"eeee");
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
