//
//  LookTicketDetailViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "LookTicketDetailViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import "LookTicketCell.h"
@interface LookTicketDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UITableView *mainTableView;
@end
@implementation LookTicketDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64) style:UITableViewStyleGrouped];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.mainTableView registerClass:[LookTicketCell class] forCellReuseIdentifier:@"one"];
        [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"two"];
        [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"three"];
        [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"four"];
        
    }
    return _mainTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LookTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
        UILabel *name_lab = [cell viewWithTag:1000];
      
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"third" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

@end
