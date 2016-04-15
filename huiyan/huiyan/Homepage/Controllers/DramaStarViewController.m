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
#define kSwipeMenu 41
#define kBannerHeight 150
@interface DramaStarViewController ()<UITableViewDelegate,UITableViewDataSource,MCSwipeMenuDelegate>
@property (nonatomic, strong) UITableView *dramaStarTableView;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *img_arr;
@property (nonatomic, strong) NSArray *imgSource_arr;
@property (nonatomic, strong) MCSwipeMenu *head_view;

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
        self.dramaStarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSwipeMenu, kScreen_Width, kScreen_Height - kSwipeMenu - 64) style:UITableViewStyleGrouped];
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
        ZCBannerView *banner = [cell viewWithTag:1000];
        if (!banner) {
            ZCBannerView *banner = [[ZCBannerView alloc]init];
            banner.backgroundColor = [UIColor redColor];
            banner.dataSource = self.img_arr;
            [banner reloadMenu];
            [cell.contentView addSubview:banner];
            banner.tag = 1000;
        }
         return cell;
        
    }else{
    DramaStarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dramaStar" forIndexPath:indexPath];
         return cell;
    }
   
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
    self.img_arr = [@[@"http://7xsnr6.com1.z0.glb.clouddn.com/o_1ag4ontasu5i75e5sm96l1q729.jpg",
                    @"http://7xsnr6.com1.z0.glb.clouddn.com/o_1ag4o9jr411c21v0f15p4176m18to9.jpg",
                      @"http://7xsnr6.com1.z0.glb.clouddn.com/o_1ag4p266k1ah51r6g8aueas15cu9.jpg"]mutableCopy];
       [self.serverManager AnimatedPOST:@"get_actor_banner.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 50020) {
            self.imgSource_arr = responseObject[@"data"];
            for (NSDictionary *dic in self.imgSource_arr) {
               NSString *responseData = [dic[@"image"] stringByReplacingOccurrencesOfString:@" " withString:@""];
                responseData = [responseData stringByReplacingOccurrencesOfString:@"\\" withString:@""];
              //  [self.img_arr addObject:responseData];
            }
            NSLog(@"%@",self.img_arr);
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
