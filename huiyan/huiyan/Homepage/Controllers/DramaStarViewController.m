//
//  DramaStarViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStarViewController.h"
#import "MCSwipeMenu.h"
#import "ZCBannerView.h"
#import "Constant.h"
#import "DramaStarTableViewCell.h"
#import "ServerManager.h"
#import "MCSwipeMenu.h"
#import "DramaStar.h"
#import "DramaStarDetailViewController.h"
#import "MessageViewController.h"
#import "SignUpMessageTableViewController.h"
#import "DramaStarInvitionViewController.h"
#import "UITabBarController+ShowHideBar.h"
#define kSwipeMenu 41
#define kBannerHeight kScreen_Width / 2
@interface DramaStarViewController ()<UITableViewDelegate,UITableViewDataSource,MCSwipeMenuDelegate>
@property (nonatomic, strong) UITableView *dramaStarTableView;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *img_arr;
@property (nonatomic, strong) NSArray *imgSource_arr;
@property (nonatomic, strong) MCSwipeMenu *head_view;
@property (nonatomic, strong) ZCBannerView *banner_view;

@end

@implementation DramaStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = @"红  人";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"interaction"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    //侧滑关闭
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
  

    self.serverManager = [ServerManager sharedInstance];
    [self get_actor_cateData];
    [self get_actor_bannerData];
    [self get_actor_listData:@"0" page:@"0"];
    [self.view addSubview:self.head_view];
    [self.view addSubview:self.dramaStarTableView];
   // self.automaticallyAdjustsScrollViewInsets  = NO;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _dramaStarTableView.alpha = 0;
    self.navigationController.navigationBar.translucent = NO;


    [self.view setBackgroundColor:[UIColor blackColor]];
    [UIView animateWithDuration:1 animations:^{
        _dramaStarTableView.alpha = 1;
        [self.dramaStarTableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }];
    
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.tabBarController.tabBar.hidden == YES) {
        self.tabBarController.tabBar.hidden = NO;
    }
    [self.tabBarController setHidden:NO];
    self.navigationController.navigationBar.barTintColor = COLOR_THEME;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (MCSwipeMenu *)head_view{
    if (!_head_view) {
        self.head_view = [[MCSwipeMenu alloc]init];
        self.head_view.delegate = self;
    }
    return _head_view;
}

- (UITableView *)dramaStarTableView{
    if (!_dramaStarTableView) {
        self.dramaStarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSwipeMenu, kScreen_Width, kScreen_Height - 48 - 64- kSwipeMenu) style:UITableViewStyleGrouped];
        self.dramaStarTableView.delegate = self;
        self.dramaStarTableView.dataSource = self;
        self.dramaStarTableView.separatorStyle = UITableViewCellAccessoryNone;
        [self.dramaStarTableView registerClass:[DramaStarTableViewCell class] forCellReuseIdentifier:@"dramaStar"];
        [self.dramaStarTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normal"];
    //    [self.dramaStarTableView setBackgroundColor:[UIColor blackColor]];
    }
    return _dramaStarTableView;
}

#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kBannerHeight;
    }else{
        return 160;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal"];
        }
        self.banner_view = [cell viewWithTag:1000];
        if (!self.banner_view) {
            self.banner_view = [[ZCBannerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kBannerHeight )];
            self.banner_view.bannerCollection.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:self.banner_view];
            self.banner_view.tag = 1000;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
        
    }else{
    DramaStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dramaStar" forIndexPath:indexPath];
        [cell setContent:self.dataSource[indexPath.section -1]];
        DramaStar *star = self.dataSource[indexPath.section -1];
        cell.invatation_btn.tag = [star.cid integerValue];
        [cell.invatation_btn addTarget:self action:@selector(invatation:) forControlEvents:UIControlEventTouchUpInside];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DramaStarDetailViewController *star = [[DramaStarDetailViewController alloc]init];
    star.drama = self.dataSource[indexPath.section -1];
    [self.navigationController pushViewController:star animated:YES];
}

- (void)get_actor_cateData{
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken};
    [self.serverManager AnimatedGET:@"get_actor_cate.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 50000) {
          [self.head_view setDataSource:responseObject[@"data"]];
            [self.head_view reloadMenu];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get_actor_cateDataerror = %@",error);
        
    }];
}

- (void)get_actor_bannerData{
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken};
     self.img_arr = [NSMutableArray array];
       [self.serverManager AnimatedGET:@"get_actor_banner.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 50020) {
            self.imgSource_arr = responseObject[@"data"];
            for (NSDictionary *dic in self.imgSource_arr) {
                [self.img_arr addObject:dic[@"image"]];
            }
        //    NSLog(@"%@",self.img_arr);
            self.banner_view.dataSource = self.img_arr;
            [self.banner_view reloadMenu];
            [self.dramaStarTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"banner_arrerror = %@",error);
    }];

}

- (void)get_actor_listData:(NSString *)cid page:(NSString *)page{
    self.dataSource = [NSMutableArray array];
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"cid":cid,@"page":page,@"user_id":user_id};
    [self.serverManager AnimatedGET:@"get_actor_list.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 50010) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                DramaStar *drama = [DramaStar dramaWithDic:dic];
                [self.dataSource addObject:drama];
            }
            [self.dramaStarTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
        
    }];
}

- (void)invatation:(UIButton *)sender{
    DramaStarInvitionViewController *dramaCon = [[DramaStarInvitionViewController alloc]init];
      DramaStar *star = self.dataSource[sender.tag];
    dramaCon.ID = star.userID;
    dramaCon.cid = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self.navigationController pushViewController:dramaCon animated:NO];
}

#pragma mark - menuDelegate
- (void)swipeMenu:(MCSwipeMenu *)menu didSelectAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *source = menu.dataSource;
    NSString *cate = [source[indexPath.item]objectForKey:@"id"];
    [self get_actor_listData:cate page:@"0"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClick:(UIBarButtonItem *)sender{
    MessageViewController *mes = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:mes animated:YES];
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
