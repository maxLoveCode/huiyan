//
//  FriendsDetailViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/26.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FriendsDetailViewController.h"

@interface FriendsDetailViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* mainTableView;

@end

@implementation FriendsDetailViewController

-(void)viewDidLoad
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"frienddetail" forIndexPath:indexPath];
    return cell;
}

@end
