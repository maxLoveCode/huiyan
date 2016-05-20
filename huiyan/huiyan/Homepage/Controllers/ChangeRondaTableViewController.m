//
//  ChangeRondaTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ChangeRondaTableViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UIWebViewTicketController.h"
#import "UITabBarController+ShowHideBar.h"
@interface ChangeRondaTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ChangeRondaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择场次";
    self.serverManager = [ServerManager sharedInstance];
     self.dataSource = [NSArray array];
    
    [self get_opera_dateData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalcell"];
    self.tableView.rowHeight = 45;
    [self.view addSubview:self.tableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tabBarController setHidden:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
    UILabel *time_lab = [cell viewWithTag:1000];
    if (!time_lab) {
        time_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 150, 0, 300, 45)];
        time_lab.font = kFONT14;
        time_lab.textColor = COLOR_WithHex(0xe54863);
        time_lab.textAlignment = NSTextAlignmentCenter;
        time_lab.text = [self.dataSource[indexPath.row] objectForKey:@"date"];
        [cell.contentView addSubview:time_lab];
        time_lab.tag = 1000;
    }
    
    
    
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)get_opera_dateData{
   
    NSDictionary *params = @{@"access_token":_serverManager.accessToken,@"oid":self.oid};
    [self.serverManager AnimatedGET:@"get_opera_date.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 30030) {
            self.dataSource = responseObject[@"data"];
           // NSLog(@"--- %@",responseObject[@"data"]);
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = self.dataSource[indexPath.section];
    UIWebViewTicketController *webCon = [[UIWebViewTicketController alloc]init];
    webCon.ID = dic[@"id"];
    webCon.oid = dic[@"oid"];
    [self.navigationController pushViewController:webCon animated:YES];
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
