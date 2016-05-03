//
//  FriendsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FriendsViewController.h"
#define groupHeight 50.0
@interface FriendsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* currentUnfolderedFans;
    UITableViewCell* operation;
}
@property (nonatomic,strong) UITableView *fansTableView;
@property (nonatomic,strong) NSMutableArray *fansGroupArray;
@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"戏友";
    self.view.backgroundColor = [UIColor whiteColor];
     currentUnfolderedFans = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
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
