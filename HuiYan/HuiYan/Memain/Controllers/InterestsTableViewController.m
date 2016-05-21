//
//  InterestsTableViewController.m
//  huiyan
//
//  Created by zc on 16/5/21.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "InterestsTableViewController.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"

@interface InterestsTableViewController ()

@property (nonatomic, strong) ServerManager* serverManager;
@property (nonatomic, assign) BOOL edited;

@end

@implementation InterestsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"interests"];
    _edited = NO;
    _serverManager = [ServerManager sharedInstance];
    [self getDramaCates];
    [self getSelfInterests];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController setHidden:YES];
    [super viewDidAppear:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (_edited) {
        [self updateInfo];
    }
    [self.tabBarController setHidden:NO];
    [super viewWillDisappear:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_Interests count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"interests" forIndexPath:indexPath];
    
    cell.textLabel.text = [[_Interests objectAtIndex:indexPath.row] objectForKey:@"name"];
    //NSLog(@"select:%@, hit %@", _selected, [_Interests objectAtIndex:indexPath.row]);
    if([_selected containsObject:[_Interests objectAtIndex:indexPath.row]])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSMutableArray* mutablecopy = [_selected mutableCopy];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [mutablecopy removeObject:[_Interests objectAtIndex:indexPath.row]];
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [mutablecopy addObject:[_Interests objectAtIndex:indexPath.row]];
    }
    _edited = YES;
    _selected = mutablecopy;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)getDramaCates
{
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken};
    
    [_serverManager AnimatedGET:@"get_wiki_cate.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 20000) {
            _Interests = responseObject[@"data"];
            [self trimAll];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)getSelfInterests
{
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,
                          @"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"],
                          @"field":@"like_wiki"};
    
    [_serverManager AnimatedGET:@"get_user_info.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 80000) {
            _selected = (responseObject[@"data"])[@"like_wiki"];
            [self.tableView reloadData];
            _edited = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

-(void)updateInfo
{
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,
                          @"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"],
                          @"like_wiki":[self formatString]};
    NSLog(@"%@", dic);
    [_serverManager AnimatedPOST:@"edit_user_info.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"code"] integerValue] == 80010) {
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

-(NSString*)formatString
{
    NSString*result=@"";
    if ([_selected count] ==0) {
        return @"";
    }
    for(NSDictionary* dic in _selected)
    {
        result = [NSString stringWithFormat:@"%@%@_",result, [dic objectForKey:@"id"]];
    }
    NSRange range = NSMakeRange(0, [result length]-1);
    return [result substringWithRange:range];
}

-(void)trimAll
{
    NSMutableArray* mutablecopy = [_Interests mutableCopy];
    for (NSDictionary* dic in _Interests) {
        if ([[dic objectForKey:@"id"] integerValue] ==0) {
            [mutablecopy removeObject:dic];
            _Interests = mutablecopy;
            break;
        }
    }
}

@end
