//
//  MoreCommentTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/16.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MoreCommentTableViewController.h"
#import "ServerManager.h"
#import "CommentContent.h"
#import "TicketCommentTableViewCell.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
#import <MJRefresh.h>
#import "GifRefresher.h"
@interface MoreCommentTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UITableView *tableView;
@end
static int number_page = 0;
@implementation MoreCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc]init];;
        self.serverManager = [ServerManager sharedInstance];
       [self.view addSubview:self.tableView];
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self get_opera_commentData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    [self.tableView.mj_header beginRefreshing];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[TicketCommentTableViewCell class] forCellReuseIdentifier:@"comment"];
        self.tableView.rowHeight = 80;
    }
    return _tableView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
    if (self.dataSource.count > 0) {
         [cell setContent:self.dataSource[indexPath.section]];
    }
   
    
    // Configure the cell...
    
    return cell;
}

- (void)get_opera_commentData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":_serverManager.accessToken, @"oid":self.oid,@"page":page};

    [self.serverManager GETWithoutAnimation:@"get_opera_comment.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 30020) {
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                CommentContent *model = [CommentContent dataWithDic:dic];
                [self.dataSource addObject:model];
            }
            if (self.dataSource.count % 10 != 0 || self.dataSource.count == 0) {
                self.tableView.mj_footer = nil;
            }else {
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        number_page ++;
                        [self get_opera_commentData:[NSString stringWithFormat:@"%d",number_page]];
                    }];
                }
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
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
