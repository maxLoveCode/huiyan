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
@end

@implementation DramaStarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.mainTable];
    // Do any additional setup after loading the view.
    // 关闭自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 隐藏导航栏,给导航栏设置空的图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    // 隐藏导航栏底部阴影
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
  
    
}

- (UIScrollView *)downScrollow{
    if (!_downScrollow) {
        self.downScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, TailHeight)];
        self.downScrollow.contentSize = CGSizeMake(kScreen_Width * 2, TailHeight);
        self.downScrollow.backgroundColor = [UIColor greenColor];
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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.playerView resetPlayer];
    
}

-(UITableView *)mainTable
{
    if (!_mainTable) {
        self.mainTable = [[UITableView alloc] init];
        self.mainTable.frame = CGRectMake(0, 0, kScreen_Width,kScreen_Height);
        
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
        _videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height ) style:UITableViewStylePlain];
        _videoTable.delegate = self;
        _videoTable.dataSource = self;
        [_videoTable registerClass:[StarVideoTableViewCell class] forCellReuseIdentifier:@"video"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTable) {
        if (indexPath.section == 0) {
            return HeadHight;
        }else{
            return  TailHeight;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrollow"];
            [cell.contentView addSubview:self.downScrollow];
            [cell.contentView setBackgroundColor: [UIColor redColor]];
            return cell;
        }
    }else if (tableView == self.videoTable){
        StarVideoTableViewCell * cell = [_mainTable dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
        StarVideo  *model = self.dataSource[indexPath.section];
        [cell setContent:model];
        NSURL *videoURL = [NSURL URLWithString:model.movie];
        __block NSIndexPath *weakIndexPath = indexPath;
        __block StarVideoTableViewCell *weakCell = cell;
        __weak typeof(self) weakSelf = self;
        cell.playBlock = ^(UIButton *btn){
            weakSelf.playerView = [ZFPlayerView sharedPlayerView];
            [weakSelf.playerView setVideoURL:videoURL withTableView:weakSelf.mainTable AtIndexPath:weakIndexPath withImageViewTag:101];
            [weakSelf.playerView addPlayerToCellImageView:weakCell.picView];
            weakSelf.playerView.playerLayerGravity =ZFPlayerLayerGravityResizeAspect;
            [weakSelf write_play_recordData:model.ID];
            
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
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


- (void)get_actor_movieData:(NSString *)page{
    self.dataSource = [NSMutableArray array];
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"user_id":self.drama.cid,@"page":@"0"};
    [self.serverManager AnimatedGET:@"get_actor_movie.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50030) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                StarVideo *model = [StarVideo starVideoWithDic:dic];
                [self.dataSource addObject:model];
            }
            [self.mainTable reloadData];
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
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:229/256.0 green:48 / 256.0 blue:63 / 256.0 alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
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
