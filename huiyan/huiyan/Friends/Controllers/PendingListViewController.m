//
//  PendingListViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/6/1.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PendingListViewController.h"
#import "ServerManager.h"

@interface PendingListViewController()

@property (strong, nonatomic) NSMutableArray* pendingList;
@property (strong, nonatomic) ServerManager* serverManager;

@end

@implementation PendingListViewController

-(void)viewDidLoad
{
    _serverManager = [ServerManager sharedInstance];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pending"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pendingList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pending" forIndexPath:indexPath];
    return cell;
}

-(void)requestPendingList
{
    NSDictionary* dic = @{@"access_token": _serverManager.accessToken, @"type":@"receive", @"user_id": [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] };
    [_serverManager AnimatedGET:@"apply_friend_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if([responseObject[@"code"] integerValue] == 100020)
        {
            _pendingList = [[NSMutableArray alloc] init];
            _pendingList = responseObject[@"data"];
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
