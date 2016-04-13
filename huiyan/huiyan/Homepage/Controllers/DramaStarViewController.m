//
//  DramaStarViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStarViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "MCSwipeMenu.h"
#import "ZCBannerView.h"
#define kSwipeMenu 41
#define kBanner
@interface DramaStarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *dramaStarTableView;

@end

@implementation DramaStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UITableView *)dramaStarTableView{
    if (!_dramaStarTableView) {
        self.dramaStarTableView = [[UITableView alloc]init];
    }
    return _dramaStarTableView;
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
