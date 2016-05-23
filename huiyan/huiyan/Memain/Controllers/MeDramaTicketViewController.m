//
//  MeDramaTicketViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/15.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MeDramaTicketViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "PersonDramaTicketCell.h"
#import "UITabBarController+ShowHideBar.h"
#import "LookTicketDetailViewController.h"
#import <MJRefresh.h>
#import "GifRefresher.h"
@interface MeDramaTicketViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@end
static int number_page = 0;
@implementation MeDramaTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.tableView];
    self.serverManager = [ServerManager sharedInstance];
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
     self.dataSource = [NSMutableArray array];
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self getmy_opera_ticketData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        number_page ++;
        [self getmy_opera_ticketData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    if (user_id) {
         [self.tableView.mj_header beginRefreshing];
    }
   
   
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
 //   [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 130;
        [self.tableView registerNib:[UINib nibWithNibName:@"PersonDramaTicketCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"drama"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark -- tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonDramaTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drama"];
    if (self.dataSource.count > 0) {
          [cell setContent:self.dataSource[indexPath.section]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LookTicketDetailViewController *lookCon = [[LookTicketDetailViewController alloc]init];
    lookCon.payData = self.dataSource[indexPath.section];
    [self.navigationController pushViewController:lookCon animated:NO];
}

#pragma mark-- 网络请求
- (void)getmy_opera_ticketData:(NSString *)page{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    NSDictionary *paramars = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id,@"page":page};
    [self.serverManager AnimatedGET:@"my_opera_ticket.php" parameters:paramars success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80040) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                PayData *model = [PayData paydataWithDic:dic];
                [self.dataSource addObject:model];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
