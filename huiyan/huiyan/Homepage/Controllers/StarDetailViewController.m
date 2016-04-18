//
//  StarDetailViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "StarDetailViewController.h"
#import "StarVideoTableViewCell.h"
#import "Constant.h"
#import "UITabBarController+ShowHideBar.h"
#import "StarVideoTableViewCell.h"
#import "StarDetailTableViewCell.h"
#define headCell 180
#define menuCell 32

@interface StarDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation StarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTable];
    _dataSource = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)mainTable
{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"main"];
        [_mainTable registerClass:[StarDetailTableViewCell class] forCellReuseIdentifier:@"starMain"];
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTable;
}

-(UITableView *)videoTable
{
    if (!_videoTable) {
        _videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height -headCell-menuCell) style:UITableViewStylePlain];
        _videoTable.delegate = self;
        _videoTable.dataSource = self;
        [_videoTable registerClass:[StarVideoTableViewCell class] forCellReuseIdentifier:@"video"];
    }
    return _videoTable;
}

#pragma mark TableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mainTable) {
        return 1;
    }
    else
        return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTable) {
        if (indexPath.section == 0) {
            return 200;
        }
    }
    return 200;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _mainTable) {
        if (section == 0) {
            return 0.01;
        }else{
            return 10;
        }
    }
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTable) {
        if (indexPath.section == 0) {
            StarDetailTableViewCell *starDetail = [_mainTable dequeueReusableCellWithIdentifier:@"starMain" forIndexPath:indexPath];
            [starDetail setContent:self.drama];
            starDetail.selectionStyle = UITableViewCellSelectionStyleNone;
            return starDetail;
        }
       StarVideoTableViewCell * cell = [_mainTable dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        StarVideoTableViewCell* cell = [_videoTable dequeueReusableCellWithIdentifier:@"video" forIndexPath:indexPath];
        return cell;
    }
}


@end
