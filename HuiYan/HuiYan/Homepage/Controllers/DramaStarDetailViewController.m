//
//  DramaStarDetailViewController.m
//  huiyan
//
//  Created by zc on 16/5/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStarDetailViewController.h"
#import "Constant.h"
#import "UITabBarController+ShowHideBar.h"
#import "ServerManager.h"
#import "DramaDetailHeadCell.h"
#import <Masonry.h>
#import "UIImage+Extension.h"
#import "StarVideoTableViewCell.h"
#import "DynamicTextTableViewCell.h"
#import "DynamicImageTableViewCell.h"
#import "DramaStarInvitionViewController.h"
#import "DynamicDetailViewController.h"
#import "Tools.h"
#define HeadHight 274
#define TailHeight kScreen_Height  - 44 - 64
#define kVideoCellHeight 244.0
// 头部视图的高度
#define kHeadHeight 230
// 最低高度（导航栏的高度）
#define kHeadMinHeight 64
// stackView的高度
#define kStatckViewHeight 30
@interface DramaStarDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton *focus_btn;
@property (nonnull, strong) ServerManager *serverManager;
@property (nonatomic, strong) UIScrollView *downScrollow;
@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, assign) CGFloat totalOffsetY;
@property (nonatomic, strong) UIView *tailView;
@property (nonatomic, strong) UIButton *videoBtn;
@property (nonatomic, strong) UIButton *desBtn;
@end

@implementation DramaStarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态";
    self.serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.mainTable];
    [self.view addSubview:self.tailView];
    // Do any additional setup after loading the view.
    
    [self get_actor_dongtaiData:@"0"];
  
    
}

- (UIView *)tailView{
    if (!_tailView ) {
        self.tailView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height - 48, kScreen_Width, 48)];
        UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        inviteBtn.frame = CGRectMake(0, 0, kScreen_Width / 3 - 2, 48);
        [inviteBtn setTitle:@"邀约" forState:UIControlStateNormal];
        [inviteBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        [inviteBtn addTarget:self action:@selector(inviteEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.tailView addSubview:inviteBtn];
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sendBtn.frame = CGRectMake(kScreen_Width / 3, 0, kScreen_Width / 3 - 2, 48);
        [sendBtn setTitle:@"送花" forState:UIControlStateNormal];
        [sendBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(sendFlower:) forControlEvents:UIControlEventTouchUpInside];
        [self.tailView addSubview:sendBtn];
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreen_Width / 3 * 2, 0, kScreen_Width / 3 - 2, 48);
        [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        [self.tailView addSubview:shareBtn];
        UILabel *oneline = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 3, 4, 1, 40)];
        oneline.backgroundColor = COLOR_WithHex(0xdddddd);
        [self.tailView addSubview:oneline];
        UILabel *twoline = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 3 *2, 4, 1, 40)];
        twoline.backgroundColor = COLOR_WithHex(0xdddddd);
        [self.tailView addSubview:twoline];
        UILabel *w_line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 1)];
        w_line.backgroundColor =COLOR_WithHex(0xdddddd);
        [self.tailView addSubview:w_line];
    }
    return _tailView;
}

- (UIScrollView *)downScrollow{
    if (!_downScrollow) {
        self.downScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, TailHeight)];
        self.downScrollow.contentSize = CGSizeMake(kScreen_Width * 2, TailHeight);
        self.downScrollow.backgroundColor = [UIColor greenColor];
        [self.downScrollow addSubview:self.videoTable];
    }
    return _downScrollow;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return ((toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) | UIDeviceOrientationLandscapeRight);
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIModalTransitionStyle)modalTransitionStyle{
    return UIModalTransitionStyleCoverVertical;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
        
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.view.backgroundColor = [UIColor blackColor];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self.tabBarController setHidden:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 关闭自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 隐藏导航栏,给导航栏设置空的图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = YES;
    
    
    // 隐藏导航栏底部阴影
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:229/255.0 green:72/255.0 blue:99/ 255.0 alpha:1]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navigationController.navigationBar.translucent = NO;


     [self.playerView resetPlayer];
    
}

-(UITableView *)mainTable
{
    if (!_mainTable) {
        self.mainTable = [[UITableView alloc] init];
        self.mainTable.frame = CGRectMake(0, 0, kScreen_Width,kScreen_Height - 48);
        self.mainTable.bounces = NO;
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        [_mainTable registerNib:[UINib nibWithNibName:@"DramaDetailHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"head"];
        [_mainTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"scrollow"];
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTable;
}

-(UITableView *)videoTable
{
    if (!_videoTable) {
        self.videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, TailHeight ) style:UITableViewStyleGrouped];
         self.videoTable.delegate = self;
         self.videoTable.dataSource = self;
        [ self.videoTable registerClass:[StarVideoTableViewCell class] forCellReuseIdentifier:@"video"];
        [ self.videoTable registerNib:[UINib nibWithNibName:@"DynamicTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"text"];
        [ self.videoTable registerClass:[DynamicImageTableViewCell class] forCellReuseIdentifier:@"image"];
          _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _videoTable;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.mainTable) {
        return 2;
    }else if(tableView == self.videoTable){
        return self.dataSource.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.mainTable) {
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.videoTable) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTable) {
        if (indexPath.section == 0) {
            return HeadHight;
        }else{
            return  TailHeight;
        }
    }else if (tableView == _videoTable){
        StarVideo *model = self.dataSource[indexPath.section];
        if ([model.type isEqualToString:@"movie"]) {
            return 185 + (kScreen_Width - 30) / 2;
        }else if(
                 [model.type isEqualToString:@"text"]){
            return 160;
        }else{
            return 180 + (kScreen_Width - 60) / 3;
        }
        
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTable) {
        if (indexPath.section == 0) {
            DramaDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"head"];
//            [cell.returnBtn addTarget:self action:@selector(returnNav) forControlEvents:UIControlEventTouchUpInside];
            [cell setContent:self.drama];
            self.focus_btn = cell.focusBtn;
            if ([self.drama.is_fans integerValue] == 1) {
                [cell.focusBtn setTitle:@"取消关注" forState:UIControlStateNormal];
                [cell.focusBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [cell.focusBtn setTitle:@"+  关注" forState:UIControlStateNormal];
                UIColor *color = COLOR_THEME;
                [cell.focusBtn setBackgroundColor:color];
            }
            __weak DramaStarDetailViewController *weakref = self;
            cell.focus = ^(UIButton *btn){
                if ([btn.titleLabel.text isEqualToString:@"取消关注"] ) {
                    [weakref focus:@"cancel"];
                }else{
                    [weakref focus:@"follow"];
                }
            };
            self.videoBtn = cell.videoBtn;
            self.desBtn = cell.descriptionBtn;
            cell.videoBtn.tag = 110;
            cell.descriptionBtn.tag = 112;
            [cell.videoBtn addTarget:self action:@selector(moveScrollow:) forControlEvents:UIControlEventTouchUpInside];
            [cell.descriptionBtn addTarget:self action:@selector(moveScrollow:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrollow"];
            [cell.contentView addSubview:self.downScrollow];
            [cell.contentView setBackgroundColor: [UIColor redColor]];
            return cell;
        }
    }else if (tableView == self.videoTable){
         StarVideo  *model = self.dataSource[indexPath.section];
        if ([model.type isEqualToString:@"movie"]) {
            StarVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"video" forIndexPath:indexPath];
            
            [cell setContent:model];
            cell.playBtn.hidden = NO;
//            NSURL *videoURL = [NSURL URLWithString:model.content[0]];
//            __block NSIndexPath *weakIndexPath = indexPath;
//            __block StarVideoTableViewCell *weakCell = cell;
//            __weak typeof(self) weakSelf = self;
            cell.playBlock = ^(UIButton *btn){
//                weakSelf.playerView = [ZFPlayerView sharedPlayerView];
//                [weakSelf.playerView setVideoURL:videoURL withTableView:weakSelf.mainTable AtIndexPath:weakIndexPath withImageViewTag:101];
//                [weakSelf.playerView addPlayerToCellImageView:weakCell.picView];
//                weakSelf.playerView.playerLayerGravity =ZFPlayerLayerGravityResizeAspect;
//                [weakSelf write_play_recordData:model.ID];
                DynamicDetailViewController * dynamicCon = [[DynamicDetailViewController alloc]init];
                dynamicCon.starVideo = self.dataSource[indexPath.section];
                [self.navigationController pushViewController:dynamicCon animated:YES];
            };
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }else if([model.type isEqualToString:@"text"]){
                DynamicTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text"];
            [cell setContent:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            DynamicImageTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"image" forIndexPath:indexPath];
            [cell setContent:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
}
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.videoTable) {
    DynamicDetailViewController * dynamicCon = [[DynamicDetailViewController alloc]init];
        dynamicCon.starVideo = self.dataSource[indexPath.section];
        [self.navigationController pushViewController:dynamicCon animated:YES];
    }
}



#pragma mark -- 关注

- (void)focus:(NSString *)isfocus{
    NSString *type = isfocus;
    NSDictionary *params = [NSDictionary dictionary];
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    params = @{@"access_token":self.serverManager.accessToken,@"type":type,@"user_id":user_id,@"follow_id":self.drama.userID};
    NSLog(@"params = %@",params);
    [self.serverManager AnimatedPOST:@"do_fans.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80020) {
            if ([isfocus isEqualToString:@"cancel"]) {
                [self.focus_btn setTitle:@"+  关注" forState:UIControlStateNormal];
                UIColor *color = COLOR_THEME;
                [self.focus_btn setBackgroundColor:color];
            }else{
                [self.focus_btn setTitle:@"取消关注" forState:UIControlStateNormal];
                [self.focus_btn setBackgroundColor:[UIColor grayColor]];
            }
            NSLog(@"mag = %@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
}
#pragma mark -- 记录播放次数
- (void)write_play_recordData:(NSString *)movid_id{
    NSLog(@"cid = %@   accessken = %@",movid_id,self.serverManager.accessToken);
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"user_id":self.drama.userID,@"movie_id":movid_id};
    NSLog(@"%@",params);
    [self.serverManager AnimatedPOST:@"write_play_record.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50050) {
            NSLog(@"%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


- (void)get_actor_dongtaiData:(NSString *)page{
    self.dataSource = [NSMutableArray array];
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"actor_id":self.drama.userID,@"page":@"0"};
    [self.serverManager AnimatedGET:@"get_actor_dongtai.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50030) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                StarVideo *model = [StarVideo starVideoWithDic:dic];
                [self.dataSource addObject:model];
            }
            [self.mainTable reloadData];
            [self.videoTable reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.mainTable) {
    CGFloat offsetY = self.mainTable.contentOffset.y;
    
    // 计算tabView滚动的偏移量
    CGFloat delta = offsetY - self.totalOffsetY;
    
    CGFloat height = kHeadHeight - delta;
    
    height = height < 0 ? 0 : height;
    
    // 透明度
    CGFloat alpha = 0;
    if (height <= kHeadMinHeight) {
        alpha = 0.99;
    } else {
        alpha = 0;
     
    }
         UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:229/255.0 green:72/255.0 blue:99/ 255.0 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}


//邀约
- (void)inviteEvent:(UIButton *)sender{
    DramaStarInvitionViewController *dramaCon = [[DramaStarInvitionViewController alloc]init];
    dramaCon.ID = self.drama.userID;
    dramaCon.cid = self.drama.cid;
    [self.navigationController pushViewController:dramaCon animated:NO];

}

//送花
- (void)sendFlower:(UIButton *)sender{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":self.drama.userID,@"follow_id":kOBJECTDEFAULTS(@"user_id")};
    [self.serverManager AnimatedPOST:@"send_actor_flower.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50040) {
            [self presentViewController:[Tools showAlert:@"送花成功"] animated:YES completion:nil];
            NSLog(@"成功");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

//分享
- (void)share:(UIButton *)sender{
    
}

- (void)moveScrollow:(UIButton *)sender{
    UIColor *color = COLOR_THEME;
    if (sender.tag == 110) {
        [self.downScrollow setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.videoBtn setTitleColor:color forState:UIControlStateNormal];
        [self.desBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [self.downScrollow setContentOffset:CGPointMake(kScreen_Width, 0) animated:YES];
        [self.videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.desBtn setTitleColor:color forState:UIControlStateNormal];
    }
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
