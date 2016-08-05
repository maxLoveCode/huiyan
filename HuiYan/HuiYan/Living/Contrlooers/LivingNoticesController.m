//
//  LivingNoticesController.m
//  HuiYan
//
//  Created by zc on 16/8/4.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "LivingNoticesController.h"
#import "LivingProjectCell.h"
#import "GifRefresher.h"
#import <MJRefresh.h>
#import "ServerManager.h"
#import <MJExtension.h>
#import "LivingModel.h"
@interface LivingNoticesController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@end
static int number_page = 0;
static NSString *const noticesCell = @"livingNotices";
@implementation LivingNoticesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.title = @"直播预告";
    self.serverManager = [ServerManager sharedInstance];
    [self.tableView registerNib:[UINib nibWithNibName:@"LivingProjectCell" bundle:nil] forCellReuseIdentifier:noticesCell];
    self.tableView.rowHeight = 88;
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self getWebcastData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        number_page ++;
        [self getWebcastData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    [self.tableView.mj_header beginRefreshing];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LivingProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:noticesCell forIndexPath:indexPath];
    cell.playLiving.hidden = YES;
    [cell setContentModel:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- 网络请求
- (void)getWebcastData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"page":page,@"status":@"1"};
    
    [self.serverManager GETWithoutAnimation:@"get_webcast.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 130010) {
            self.dataSource = [LivingModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            if ([responseObject[@"data"] count] %10 !=0) {
                self.tableView.mj_footer = nil;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
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

@end
