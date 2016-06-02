//
//  PendingListViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/6/1.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PendingListViewController.h"
#import "ServerManager.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"

@interface PendingListViewController()

@property (strong, nonatomic) NSMutableArray* pendingList;
@property (strong, nonatomic) ServerManager* serverManager;

@end

@implementation PendingListViewController

-(void)viewDidLoad
{
    _serverManager = [ServerManager sharedInstance];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pending"];
    
    [self requestPendingList];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pendingList count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"pending" forIndexPath:indexPath];
    
    for (UIView* subview in [cell.contentView subviews]) {
        [subview removeFromSuperview];
    }
    
    NSDictionary* ppl =[_pendingList objectAtIndex:indexPath.row];
    
    UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin, 10, 40, 40)];
    [view sd_setImageWithURL:[NSURL URLWithString:[ppl objectForKey:@"avatar"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxY(view.frame)+kMargin, 0, 200, 60)];
    nameLabel.text = [ppl objectForKey:@"nickname"];
    [cell.contentView addSubview:nameLabel];
    [cell.contentView addSubview:view];
    
    if ([ppl[@"status"] integerValue] == 1) {
        CGFloat buttonWidth = 60;
        UIButton* request = [UIButton buttonWithType:UIButtonTypeCustom];
        [request setFrame:CGRectMake(kScreen_Width - buttonWidth -kMargin, 17, buttonWidth, 26)];
        [request setTitle:@"同  意" forState: UIControlStateNormal];
        [request setBackgroundColor:COLOR_WITH_RGB(10, 170, 20)];
        request.titleLabel.font = kFONT(12);
        request.layer.cornerRadius = 2;
        request.layer.masksToBounds = YES;
        request.tag = indexPath.row;
        [request addTarget:self action:@selector(approved:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:request];
    }
    
    return cell;
}

-(void)requestPendingList
{
    NSDictionary* dic = @{@"access_token": _serverManager.accessToken, @"type":@"receive", @"user_id": [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] };
    [_serverManager AnimatedGET:@"apply_friend_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if([responseObject[@"code"] integerValue] == 100020)
        {
            _pendingList = [[NSMutableArray alloc] init];
            _pendingList = responseObject[@"data"];
            [self.tableView reloadData];
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)approved:(id)sender
{
    UIButton* btn = sender;
    NSDictionary* dic = @{@"access_token": _serverManager.accessToken, @"aid": [[_pendingList objectAtIndex:btn.tag] objectForKey:@"id"], @"agree":@"1" };
    [_serverManager AnimatedPOST:@"agree_friend.php" parameters:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if([responseObject[@"code"] integerValue] == 100030)
        {
            [self requestPendingList];
        }
        else
        {
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
