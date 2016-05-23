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
#import "NewHomePageCell.h"
#import "ServerManager.h"
#import "WikiWorksDetailsViewController.h"
#import <MJRefresh.h>
#import "MessageViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "GifRefresher.h"
@interface NewHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL hidden;
@end
static int number_page = 0;
@implementation NewHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
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
    [self.view addSubview:self.tableView];
    self.serverManager = [ServerManager sharedInstance];
    [self get_wiki_listData:@"0"];
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self get_wiki_listData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        number_page ++;
        [self get_wiki_listData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    [self.tableView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.translucent = YES;
    _hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- tableViewDelegate

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height )];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[NewHomePageCell class] forCellReuseIdentifier:@"home"];
        self.tableView.rowHeight =  kScreen_Width *5/7-1;
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
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewHomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home" forIndexPath:indexPath];
    if (self.dataSource.count > 0) {
        [cell setContent:self.dataSource[indexPath.section]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WikiWorksDetailsViewController *wikiCon = [[WikiWorksDetailsViewController alloc]init];
    wikiCon.homePage = self.dataSource[indexPath.section];
    //NewHomePageCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         //cell.transform = CGAffineTransformMakeScale(-1, kScreen_Height/cell.frame.size.height);
                     }
                    completion:^(BOOL finished) {
                        [self.navigationController pushViewController:wikiCon animated:NO];
                        //cell.transform = CGAffineTransformMakeScale(1, 1);
                    }];

    //[self.navigationController pushViewController:wikiCon animated:YES];
}

#pragma mark - 网络请求
- (void)get_wiki_listData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"page":page,@"type":@"2"};
    [self.serverManager AnimatedGET:@"get_wiki_list.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 20010) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                HomePage *model = [HomePage parseDramaJSON:dic];
                [self.dataSource addObject:model];
            }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
