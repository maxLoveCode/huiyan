//
//  DramaStarViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStarViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "MCSwipeMenu.h"
#import "ZCBannerView.h"
#import "Constant.h"
#import "DramaStarTableViewCell.h"
#import "ServerManager.h"
#import "MCSwipeMenu.h"
#import "DramaStar.h"
#import "StarDetailViewController.h"
#define kSwipeMenu 41
#define kBannerHeight 150
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
    self.serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.head_view];
    [self get_actor_cateData];
    [self get_actor_bannerData];
    [self get_actor_listData:@"0" page:@"0"];
    [self.view addSubview:self.dramaStarTableView];
    self.automaticallyAdjustsScrollViewInsets  = NO;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
    
}

- (MCSwipeMenu *)head_view{
    if (!_head_view) {
        self.head_view = [[MCSwipeMenu alloc]init];
        self.head_view.delegate = self;
    }
    return _head_view;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UITableView *)dramaStarTableView{
    if (!_dramaStarTableView) {
        self.dramaStarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSwipeMenu  , kScreen_Width, kScreen_Height - kSwipeMenu - 64) style:UITableViewStyleGrouped];
        self.dramaStarTableView.delegate = self;
        self.dramaStarTableView.dataSource = self;
        self.dramaStarTableView.separatorStyle = UITableViewCellAccessoryNone;
        [self.dramaStarTableView registerClass:[DramaStarTableViewCell class] forCellReuseIdentifier:@"dramaStar"];
        [self.dramaStarTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normal"];
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
        return 180;
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
        
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StarDetailViewController *star = [[StarDetailViewController alloc]init];
    [self.navigationController pushViewController:star animated:YES];
}

- (void)get_actor_cateData{
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken};
    [self.serverManager AnimatedPOST:@"get_actor_cate.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
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
       [self.serverManager AnimatedPOST:@"get_actor_banner.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 50020) {
            self.imgSource_arr = responseObject[@"data"];
            for (NSDictionary *dic in self.imgSource_arr) {
                [self.img_arr addObject:dic[@"image"]];
            }
            NSLog(@"%@",self.img_arr);
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
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"cid":cid,@"page":page};
    [self.serverManager AnimatedPOST:@"get_actor_list.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
