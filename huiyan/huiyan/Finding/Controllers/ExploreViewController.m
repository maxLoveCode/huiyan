//
//  ExploreViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ExploreViewController.h"
#import "FindTableViewCell.h"
#import "Constant.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "ServerManager.h"
#import "FindFriend.h"
#import <MJRefresh.h>
#import "UITabBarController+ShowHideBar.h"
#import "GifRefresher.h"
@interface ExploreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *x_point;
@property (nonatomic, copy) NSString *y_point;

@end
static int number_page = 0;
@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附近的人";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:self.tableView];
      self.dataSource = [NSMutableArray array];
    self.serverManager = [ServerManager sharedInstance];
    [self configLocationManager];
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self getfind_listData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        number_page ++;
        [self getfind_listData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    [self.tableView.mj_header beginRefreshing];
        // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController setHidden:YES];
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        self.navigationController.navigationBar.barTintColor = COLOR_THEME;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.tabBarController setHidden:NO];
}

//获得位置
- (void)configLocationManager{
    self.locationManager = [[AMapLocationManager alloc] init];
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //   定位超时时间，可修改，最小2s
    self.locationManager.locationTimeout = 3;
    //   逆地理请求超时时间，可修改，最小2s
    self.locationManager.reGeocodeTimeout = 3;
    // 带逆地理（返回坐标和地址信息）
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
                      // NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            return;
            
        }
        CLLocationCoordinate2D cll = location.coordinate;
        self.x_point = [NSString stringWithFormat:@"%f",cll.longitude];
        self.y_point = [NSString stringWithFormat:@"%f",cll.latitude];
        NSLog(@"location:%@ x = %@ y = %@", location,self.x_point,self.y_point);
        [self getfind_listData:@"0"];
        if (regeocode)
        {
           // NSLog(@"reGeocode:%@", regeocode);
        }
    }];

}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 60;
      //  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[FindTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

#pragma mark - tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.dataSource.count > 0) {
         [cell setContent:self.dataSource[indexPath.section]];
    }
   
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getfind_listData:(NSString *)page{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    if (self.x_point && self.y_point && user_id) {
        NSDictionary *parmars = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id,@"x_point":self.x_point,@"y_point":self.y_point,@"page":page};
        [self.serverManager AnimatedGET:@"find_list.php" parameters:parmars success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == 100000) {
                for (NSDictionary *dic in responseObject[@"data"]) {
                    FindFriend *model = [FindFriend findFriendWithData:dic];
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
