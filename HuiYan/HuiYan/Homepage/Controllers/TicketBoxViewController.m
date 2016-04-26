//
//  TicketBoxViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TicketBoxViewController.h"
#import "Constant.h"
#import "BuyTicketCell.h"
#import "ServerManager.h"
#import "BuyTicket.h"
#import "MCSwipeMenu.h"
#import "BuyTicketDetailsViewController.h"
#import "UITabBarController+ShowHideBar.h"
#define ticketHeight 142

@interface TicketBoxViewController ()<UITableViewDelegate,UITableViewDataSource,MCSwipeMenuDelegate>
@property (nonatomic, strong) UITableView *ticketBoxTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) MCSwipeMenu *head_view;
@end

@implementation TicketBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购票";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.head_view];
    [self.view addSubview:self.ticketBoxTableView];
    _serverManager = [ServerManager sharedInstance];
    [self getDataTicket:@"0"];
    [self get_opera_cateData];
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

- (UITableView *)ticketBoxTableView{
    if (!_ticketBoxTableView) {
        self.ticketBoxTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.head_view.frame), kScreen_Width, ticketHeight * 5) style:UITableViewStylePlain];
        self.ticketBoxTableView.delegate  = self;
        self.ticketBoxTableView.dataSource = self;
        self.ticketBoxTableView.backgroundColor = [UIColor whiteColor];
        self.ticketBoxTableView.rowHeight = ticketHeight;
        self.ticketBoxTableView.separatorStyle  = NO;
        [self.ticketBoxTableView registerClass:[BuyTicketCell class] forCellReuseIdentifier:@"ticketBox"];
    }
    return _ticketBoxTableView;
}
- (MCSwipeMenu *)head_view{
    if (!_head_view) {
        self.head_view = [[MCSwipeMenu alloc]init];
        self.head_view.delegate = self;
    }
    return _head_view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticketBox" forIndexPath:indexPath];
    [cell setContent:_dataSource[indexPath.row]];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyTicketDetailsViewController *btdCon = [[BuyTicketDetailsViewController alloc]init];
    btdCon.ticket = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:btdCon animated:YES];
    
}

- (void)get_opera_cateData{
    NSDictionary *params = @{@"access_token":_serverManager.accessToken};
    [_serverManager AnimatedGET:@"get_opera_cate.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
       // NSLog(@"responseObject = %@",responseObject);
        if ([responseObject[@"code"] integerValue] ==
            30000) {
                [self.head_view setDataSource:responseObject[@"data"]];
            [self.head_view reloadMenu];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)getDataTicket:(NSString *)cid{
    _dataSource = [NSMutableArray array];
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,@"cid":cid};
    [_serverManager AnimatedGET:@"get_opera_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 30010) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                BuyTicket *model = [BuyTicket dataWithDic:dic];
                [_dataSource addObject:model];
            }
            [self.ticketBoxTableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - menuDelegate
- (void)swipeMenu:(MCSwipeMenu *)menu didSelectAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *source = menu.dataSource;
    NSString *cate = [source[indexPath.item]objectForKey:@"id"];
    [self getDataTicket:cate];
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
