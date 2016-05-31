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
#import "GifRefresher.h"
#import "InvitationDetailViewController.h"
@interface PersonInvitationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UIImageView *bg_image;
@end
static int number_page = 0;
@implementation PersonInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的邀约";
     self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
  
    self.serverManager = [ServerManager sharedInstance];
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self getmy_invitationData:[NSString stringWithFormat:@"%d",number_page]];
    }];
           [self.tableView.mj_header beginRefreshing];

}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 160;
        self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerNib:[UINib nibWithNibName:@"PersonInvitationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"invatation"];
    }
    return _tableView;
}

- (UIImageView *)bg_image{
    if (!_bg_image) {
        self.bg_image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 94, 100, 188,106)];
      //  self.bg_image.backgroundColor = [UIColor whiteColor];
    }
    return _bg_image;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   // [self.tabBarController setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self.tabBarController setHidden:YES];
    // self.navigationController.navigationBar.translucent = YES;
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
            if (self.dataSource.count % 10 != 0 || self.dataSource.count == 0) {
                self.tableView.mj_footer = nil;
            }else {
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        number_page ++;
                        [self getmy_invitationData:[NSString stringWithFormat:@"%d",number_page]];
                    }];

                }
            }
            if (self.dataSource.count == 0 && [page isEqualToString:@"0"]) {
                self.bg_image.image = [UIImage imageNamed:@"noInvitation"];
                
                [self.tableView addSubview:self.bg_image];
            }else{
                [self.bg_image removeFromSuperview];
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
    InvitationDetailViewController *invitationCon = [[InvitationDetailViewController alloc]init];
    invitationCon.invitation = self.dataSource[sender.tag - 50];
    [self.navigationController pushViewController:invitationCon animated:YES];
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
