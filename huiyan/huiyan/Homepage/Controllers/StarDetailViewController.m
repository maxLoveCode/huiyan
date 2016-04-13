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

#define headCell 180
#define menuCell 32

@interface StarDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation StarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)mainTable
{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"main"];
    }
    return _mainTable;
}

-(UITableView *)videoTable
{
    if (!_videoTable) {
        _videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height -headCell-menuCell) style:UITableViewStylePlain];
        [_videoTable registerClass:[StarVideoTableViewCell class] forCellReuseIdentifier:@"video"];
    }
    return _videoTable;
}

#pragma mark TableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _mainTable) {
        return 3;
    }
    else
        return [_dataSource count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTable) {
        UITableViewCell* cell = [_mainTable dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        StarVideoTableViewCell* cell = [_videoTable dequeueReusableCellWithIdentifier:@"video" forIndexPath:indexPath];
        return cell;
    }
}


@end
