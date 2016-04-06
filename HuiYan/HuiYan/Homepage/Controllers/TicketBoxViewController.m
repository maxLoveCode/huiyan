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
#define ticketHeight 107

@interface TicketBoxViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *ticketBoxTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@end

@implementation TicketBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.ticketBoxTableView];
    _serverManager = [ServerManager sharedInstance];
    [self getDataTicket:@"0"];
    // Do any additional setup after loading the view.
}

- (UITableView *)ticketBoxTableView{
    if (!_ticketBoxTableView) {
        self.ticketBoxTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 41, kScreen_Width, ticketHeight * 5) style:UITableViewStylePlain];
        self.ticketBoxTableView.delegate  = self;
        self.ticketBoxTableView.dataSource = self;
        self.ticketBoxTableView.backgroundColor = [UIColor whiteColor];
        self.ticketBoxTableView.rowHeight = ticketHeight;
        [self.ticketBoxTableView registerClass:[BuyTicketCell class] forCellReuseIdentifier:@"ticketBox"];
    }
    return _ticketBoxTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticketBox" forIndexPath:indexPath];
    return cell;
}

- (void)getDataTicket:(NSString *)cid{
    _dataSource = [NSMutableArray array];
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,@"cid":cid};
    [_serverManager AnimatedPOST:@"get_opera_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"----%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
