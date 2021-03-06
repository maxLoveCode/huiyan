//
//  MessageListTableViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MessageListTableViewController.h"
#import "ServerManager.h"
#import "Constant.h"
#import "Message.h"
#import "MessageTableViewCell.h"
#import "UITabBarController+ShowHideBar.h"

@interface MessageListTableViewController ()

@property (strong, nonatomic) ServerManager* server;
@property (assign, nonatomic) NSInteger* page;
@property (strong, nonatomic) NSMutableArray* dataSource;

-(void)getMessageList;

@end

@implementation MessageListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    _page = 0;
    _server = [ServerManager sharedInstance];
    [self.tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"msg"];
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    [_dataSource removeAllObjects];
    [self getMessageList];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MessageTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"msg" forIndexPath:indexPath];
    
    [cell setCellContent:[_dataSource objectAtIndex:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/  
-(void)getMessageList
{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    NSString* type;
    
    type = (_style == MessageTypeSystem)?@"system":@"push";
     NSDictionary *parameters = @{@"access_token":_server.accessToken,@"user_id":user_id, @"type":type};
   // NSLog(@"%@",parameters);
    [_server AnimatedGET:@"get_message_list.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
      //  NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] ==110000) {
            [_dataSource removeAllObjects];
            NSArray* data = responseObject[@"data"];
            for(NSDictionary* msg in data)
            {
                [_dataSource addObject:[Message parseMessageFromJSON:msg]];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
