//
//  PersonInvitationViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PersonInvitationViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import "PersonInvitationCell.h"
#import "Invitation.h"
#import <MJRefresh.h>
#import "ArticalViewController.h"
@interface PersonInvitationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@end
static int number_page = 0;
@implementation PersonInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的邀约";
    // Do any additional setup after loading the view.
    self.serverManager = [ServerManager sharedInstance];
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self getmy_invitationData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        number_page ++;
        [self getmy_invitationData:[NSString stringWithFormat:@"%d",number_page]];
    }];
        [self.tableView.mj_header beginRefreshing];

}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, - 64, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 160;
        [self.tableView registerNib:[UINib nibWithNibName:@"PersonInvitationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"invatation"];
    }
    return _tableView;
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
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height)];
     [self.tabBarController setHidden:YES];
}

#pragma mark -- TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonInvitationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"invatation"];
    if (self.dataSource.count > 0) {
        [cell setContent:self.dataSource[indexPath.section]];
    }
    cell.lookBtn.tag = indexPath.section + 50;
    [cell.lookBtn addTarget:self action:@selector(lookMore:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)getmy_invitationData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"page":page};
    [self.serverManager AnimatedGET:@"my_invitation.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80080) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                Invitation *model = [Invitation invitationWithDic:dic];
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

- (void)lookMore:(UIButton *)sender{
    ArticalViewController *artCon = [[ArticalViewController alloc]init];
    Invitation *model = self.dataSource[sender.tag - 50];
    artCon.originData = model.content;
    [self.navigationController pushViewController:artCon animated:NO];
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
