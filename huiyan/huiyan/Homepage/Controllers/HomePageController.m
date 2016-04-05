//
//  HomePageController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePageController.h"

@implementation HomePageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(UITableView *)recommendTableView
{
    if (!_recommendTableView) {
        _recommendTableView = [[UITableView alloc] init];
        _recommendTableView.delegate = self;
        _recommendTableView.dataSource = self;
        
        [_recommendTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"recommends"];
        
#ifdef DEBUG
        [_recommendTableView setBackgroundColor:[UIColor redColor]];
#endif
        
    }
    return _recommendTableView;
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _recommendTableView) {
        return 1;
    }
    else
        return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _recommendTableView) {
        return 1;
    }
    else
    {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _recommendTableView) {
        UITableViewCell* cell;
        return cell;
    }
    else
    {
        UITableViewCell* cell;
        return cell;
    }
    
}

@end
