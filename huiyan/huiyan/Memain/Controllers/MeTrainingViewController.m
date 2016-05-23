//
//  MeTrainingViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MeTrainingViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import "PersonTrainingCell.h"
#import "PersonTraining.h"
#import "TrainOrdersTableViewController.h"
#import <MJRefresh.h>
#import "GifRefresher.h"
@interface MeTrainingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@end
static int number_page = 0;
@implementation MeTrainingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.serverManager = [ServerManager sharedInstance];
    self.dataSource = [NSMutableArray array];
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self getMy_train_orderData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        number_page ++;
        [self getMy_train_orderData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    [self.tableView.mj_header beginRefreshing];
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
        self.tableView.rowHeight = 200;
        [self.tableView registerNib:[UINib nibWithNibName:@"PersonTrainingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"train"];
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
    PersonTrainingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"train"];
    if (self.dataSource.count > 0) {
        [cell setContent:self.dataSource[indexPath.section]];

    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonTraining *train = self.dataSource[indexPath.section];
    TrainOrdersTableViewController *trainCon = [[TrainOrdersTableViewController alloc]init];
    trainCon.oid = train.oid;
    [self.navigationController pushViewController:trainCon animated:NO];
}

- (void)getMy_train_orderData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"page":page};
    [self.serverManager AnimatedGET:@"my_train_order.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80050) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                PersonTraining *model = [PersonTraining PersonTrainingWithDic:dic];
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
