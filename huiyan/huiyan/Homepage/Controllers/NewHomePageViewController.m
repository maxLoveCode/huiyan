//
//  NewHomePageViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "NewHomePageViewController.h"
#import "Constant.h"
#import "HomePage.h"
#import "ServerManager.h"
#import "WikiWorksDetailsViewController.h"
#import <MJRefresh.h>
#import "MessageViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "GifRefresher.h"
#import "UITabBarController+ShowHideBar.h"
#import "NewHomeCell.h"
#import "HomePageHeadView.h"
#import "LivingNoticesController.h"
#import <MJExtension.h>

@interface NewHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,NoticesDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, strong) HomePageHeadView *headView;
@property (nonatomic, strong) NSArray *bannerPic;
@end
static int number_page = 0;
@implementation NewHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.title = @"首  页";
    
    self.dataSource = [[NSMutableArray alloc]init];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"interaction"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
     self.navigationItem.rightBarButtonItem = rightItem;
    //侧滑关闭
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.navigationController.navigationBar.barTintColor = COLOR_THEME;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.tableView];
    [self getappbannerData];
    [self getappVersionData];
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
    self.tabBarController.tabBar.translucent = YES;
    _hidden = NO;
}

- (HomePageHeadView *)headView{
    if (!_headView) {
        NSArray *Views = [[NSBundle mainBundle]loadNibNamed:@"HomePageHeadView" owner:self options:nil];
        self.headView = [Views firstObject];
        self.headView.delegate = self;
        self.headView.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Width / 2 + 50);
    }
    return _headView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tabBarController.tabBar.hidden == YES) {
        self.tabBarController.tabBar.hidden = NO;
    }
    [self getNoticesData:@"0"];
    [self.tabBarController setHidden:NO];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.tableView.alpha = 0;
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [UIView animateWithDuration:1 animations:^{
        self.tableView.alpha = 1;
    }];
    [self.tabBarController setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickNotices{
    LivingNoticesController *livCon = [[LivingNoticesController alloc]init];
    livCon.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:livCon animated:NO];
}

#pragma mark -- tableViewDelegate

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height )];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"NewHomeCell" bundle:nil] forCellReuseIdentifier:@"home"];
        self.tableView.rowHeight =  kScreen_Width + 98;
        self.tableView.tableHeaderView = self.headView;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

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
    NewHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home" forIndexPath:indexPath];
    [cell setContent:self.dataSource[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    WikiWorksDetailsViewController *wikiCon = [[WikiWorksDetailsViewController alloc]init];
//    wikiCon.homePage = self.dataSource[indexPath.section];
//    //NewHomePageCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^(void) {
//                         //cell.transform = CGAffineTransformMakeScale(-1, kScreen_Height/cell.frame.size.height);
//                     }
//                    completion:^(BOOL finished) {
//                        [self.navigationController pushViewController:wikiCon animated:NO];
//                        //cell.transform = CGAffineTransformMakeScale(1, 1);
//                    }];

    //[self.navigationController pushViewController:wikiCon animated:YES];
}

#pragma mark - 网络请求
- (void)getWebcastData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"page":page,@"status":@"1"};

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

#pragma mark --直播预告
- (void)getNoticesData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"page":page,@"status":@"0"};
    [self.serverManager GETWithoutAnimation:@"get_webcast.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 130010) {
           LivingModel *livingModel = [[LivingModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]] firstObject];
            self.headView.timeLab.text = livingModel.time;
            self.headView.nameLab.text = livingModel.title;
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}


- (void)rightClick:(UIBarButtonItem *)sender{
     MessageViewController *mes = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:mes animated:YES];
}


#pragma mark scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (!_hidden) {
        [self.tabBarController setHidden:YES];
        _hidden = !_hidden;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_hidden) {
        [self.tabBarController setHidden:NO];
        _hidden = !_hidden;
    }
}

- (void)getappVersionData{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"key":@"ios_app_version"};
    
    [self.serverManager GETWithoutAnimation:@"get_app_config.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 60000) {
            NSLog(@"-------%@",[responseObject[@"data"] objectForKey:@"value"]);
            NSDictionary *value = [responseObject[@"data"] objectForKey:@"value"];
            NSString *version = value[@"version"];
            kSETDEFAULTS(version, @"version");
            NSString *localVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"version"] isEqualToString:localVersion]) {
                UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:value[@"tip"] preferredStyle:UIAlertControllerStyleAlert];
                [alertCon addAction:[UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/palringo-group-messenger-chat/id1116890013?mt=8"]];
                    
                }]];
                [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [self presentViewController:alertCon animated:YES completion:nil];
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

#pragma mark -- 请求banner数据
- (void)getappbannerData{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken};
    [self.serverManager AnimatedGET:@"get_app_banner.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 60010) {
            self.bannerPic = responseObject[@"data"];
            [self.headView uploaData:self.bannerPic];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
}

#pragma mark -- ScrollViewDelegate


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
