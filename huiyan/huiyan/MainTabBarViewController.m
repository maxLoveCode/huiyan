//
//  MainTabBarViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/21.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllController];
    // Do any additional setup after loading the view.
}

- (void)addAllController{
    UIColor *color  = COLOR_THEME;
    HomePageController *homepage = [[HomePageController alloc]initWithStyle:UITableViewStyleGrouped];
    
    FriendsViewController *friend = [[FriendsViewController alloc]init];
    
    ExploreViewController *explore = [[ExploreViewController alloc]init];
    
    
    MeMainViewController *meMain = [[MeMainViewController alloc]init];
    
    
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homepage];
    homeNav.tabBarItem.title = @"首页";
    [homeNav.tabBarItem setImage:[UIImage imageNamed:@"tab_homePage"]];
    [homeNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_homePage_selected"]];
    homeNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [homeNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController *friendNav = [[UINavigationController alloc]initWithRootViewController:friend];
    friendNav.tabBarItem.title = @"戏友";
    [friendNav.tabBarItem setImage:[UIImage imageNamed:@"tab_firend"]];
    [friendNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_firend_selected"]];
    friendNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [friendNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController *exploreNav = [[UINavigationController alloc]initWithRootViewController:explore];
    exploreNav.tabBarItem.title  = @"发现";
    [exploreNav.tabBarItem setImage:[UIImage imageNamed:@"tab_explorer"]];
    [exploreNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_explorer_selected"]];
    exploreNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [exploreNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    UINavigationController *meMainNav = [[UINavigationController alloc]initWithRootViewController:meMain];
    meMainNav.tabBarItem.title = @"我的";
    [meMainNav.tabBarItem setImage:[UIImage imageNamed:@"tab_mine"]];
    [meMainNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"tab_mine_selected"]];
    meMainNav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [meMainNav.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    [self.tabBar setTintColor:color];
    self.tabBar.translucent  = NO;
    self.tabBar.opaque = YES;
    NSArray *navCon = @[homeNav,friendNav,exploreNav,meMainNav];
    [self setViewControllers:navCon animated:YES];
}

//哪些界面支持自动转屏



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
