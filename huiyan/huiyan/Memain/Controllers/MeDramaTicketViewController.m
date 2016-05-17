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
@interface MeDramaTicketViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@end

@implementation MeDramaTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.view addSubview:self.tableView];
    self.serverManager = [ServerManager sharedInstance];
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    if (user_id) {
         [self getmy_opera_ticketData];
    }
   
   
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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
    if (section == self.dataSource.count) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonDramaTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"drama"];
    [cell setContent:self.dataSource[indexPath.section]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark-- 网络请求
- (void)getmy_opera_ticketData{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    self.dataSource = [NSMutableArray array];
    NSDictionary *paramars = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id};
    [self.serverManager AnimatedGET:@"my_opera_ticket.php" parameters:paramars success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80040) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                PersonDramaTicket *model = [PersonDramaTicket personDramaTicketWithDic:dic];
                [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
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
