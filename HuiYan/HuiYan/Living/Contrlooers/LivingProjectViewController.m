//
//  LivingProjectViewController.m
//  huiyan
//
//  Created by zc on 16/8/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "LivingProjectViewController.h"
#import "SendLivigViewController.h"
#import "LivingProjectCell.h"
#import "GifRefresher.h"
#import <MJRefresh.h>
#import "ServerManager.h"
#import <MJExtension.h>
#import "LivingModel.h"
@interface LivingProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView  *navView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@end
static int number_page = 0;
@implementation LivingProjectViewController
static NSString *const livingCell = @"livingCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    self.serverManager  = [ServerManager sharedInstance];
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
    // Do any additional setup after loading the view.
}


- (UIView *)navView{
    if (!_navView) {
        self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
        self.navView.backgroundColor = COLOR_THEME;
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        returnBtn.frame = CGRectMake(15, 20, 30, 50);
        [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        returnBtn.titleLabel.font = kFONT14;
        [returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [returnBtn addTarget:self action:@selector(returnNav) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:returnBtn];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 30, 20, 60, 50)];
        lab.textColor = [UIColor whiteColor];
        lab.font = kFONT14;
        lab.text = @"直播计划";
        [self.navView addSubview:lab];
        UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        postBtn.frame = CGRectMake(kScreen_Width - 65, 20, 60, 50);
        [postBtn setTitle:@"+" forState:UIControlStateNormal];
        postBtn.titleLabel.font = kFONT16;
        [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [postBtn addTarget:self action:@selector(sendLiving) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:postBtn];
    }
    return _navView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Width + 100) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 88;
        [self.tableView registerNib:[UINib nibWithNibName:@"LivingProjectCell" bundle:nil] forCellReuseIdentifier:livingCell];
    }
    return _tableView;
}

#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LivingProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:livingCell];
    [cell setContentModel:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- 网络请求
- (void)getWebcastData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"page":page,@"status":@"0",@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]};
    
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

- (void)sendLiving{
    SendLivigViewController *sendCon = [[SendLivigViewController alloc]init];
    [self presentViewController:sendCon animated:NO completion:nil];
}

- (void)returnNav{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
