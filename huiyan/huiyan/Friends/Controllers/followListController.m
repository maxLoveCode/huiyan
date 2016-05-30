//
//  followListController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/30.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "followListController.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import <RongIMKit/RongIMKit.h>
#import "chatUsers.h"

@interface followListController()

@property (nonatomic, strong) ServerManager* servermanager;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) chatUsers* users;

@end


@implementation followListController

-(void)viewDidLoad
{
    self.title = @"我的关注";
    _servermanager = [ServerManager sharedInstance];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ppl"];
    _users = [chatUsers instance];
    [self requestData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    // [self.tabBarController setHidden:NO];
    self.tabBarController.tabBar.hidden = NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell= [tableView dequeueReusableCellWithIdentifier:@"ppl" forIndexPath:indexPath];
    cell.textLabel.text = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"nickname"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCConversationViewController* chat = [[RCConversationViewController alloc] init];
    chat.conversationType = ConversationType_PRIVATE;
    chat.targetId = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"id"];
    chat.title = [[_dataSource objectAtIndex:indexPath.row] objectForKey:@"nickname"];
    [self.navigationController pushViewController:chat animated:YES];
}

#pragma mark---load list data
-(void)requestData
{
    NSString* userid;
    userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSDictionary* params =@{@"access_token":_servermanager.accessToken, @"user_id":userid};
    [_servermanager AnimatedGET:@"get_fans_list.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        
        NSLog(@"response %@", responseObject);
        if ([[responseObject objectForKey:@"code"] integerValue] == 80030) {
            self.dataSource = [[NSMutableArray alloc] init];
            for (NSDictionary* ppl in responseObject[@"data"]) {
                [self.dataSource addObject:ppl];
                [_users getUserInfoWithUserId:[ppl objectForKey:@"id"] completion:^(RCUserInfo *userInfo) {
                    
                }];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
