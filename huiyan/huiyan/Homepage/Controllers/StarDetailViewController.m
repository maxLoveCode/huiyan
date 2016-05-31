//
//  StarDetailViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "StarDetailViewController.h"
#import "StarVideoTableViewCell.h"
#import "Constant.h"
#import "UITabBarController+ShowHideBar.h"
#import "StarVideoTableViewCell.h"
#import "StarDetailTableViewCell.h"
#import "ServerManager.h"
#import "StarVideo.h"
#import <Masonry.h>
#define headCell 180
#define menuCell 32
static CGFloat const kWindowHeight = 244.0f;
@interface StarDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, strong) UIButton *focus_btn;
@end

@implementation StarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mainTable];
    self.serverManager = [ServerManager sharedInstance];
     self.view.backgroundColor  = [UIColor whiteColor];
    NSLog(@"%@--%@",self.drama.cid,self.drama.is_fans);
  //  [self.navigationController setNavigationBarHidden:YES];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self get_actor_movieData:@"0"];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarHidden = YES;
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
    [self.playerView resetPlayer];
    
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return ((toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) | UIDeviceOrientationLandscapeRight);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)mainTable
{
    if (!_mainTable) {
        self.mainTable = [[UITableView alloc] init];
        self.mainTable.frame = CGRectMake(0, 0, kScreen_Width,kScreen_Height);
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        [_mainTable registerClass:[StarVideoTableViewCell class] forCellReuseIdentifier:@"main"];
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

#pragma mark TableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kWindowHeight;
    }
        return 261;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
            return 0.01;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.dataSource.count) {
        return 10;
    }
    return 0.01;
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (tableView == _mainTable) {
//        if (indexPath.section == 0) {
//            CoolNavi *cell = [tableView dequeueReusableCellWithIdentifier:@"head" forIndexPath:indexPath];
//            [cell setContent:self.drama];
//             self.focus_btn = cell.focus_btn;
//                if ([self.drama.is_fans integerValue] == 1) {
//                    [cell.focus_btn setTitle:@"取消关注" forState:UIControlStateNormal];
//                    [cell.focus_btn setBackgroundColor:[UIColor grayColor]];
//                }else{
//                    [cell.focus_btn setTitle:@"+  关注" forState:UIControlStateNormal];
//                    UIColor *color = COLOR_THEME;
//                    [cell.focus_btn setBackgroundColor:color];
//                }
//                __weak StarDetailViewController *weakref = self;
//                cell.focus = ^(UIButton *btn){
//                    if ([btn.titleLabel.text isEqualToString:@"取消关注"] ) {
//                        [weakref focus:@"cancel"];
//                    }else{
//                        [weakref focus:@"follow"];
//                    }
//                };
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//       StarVideoTableViewCell * cell = [_mainTable dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
//            StarVideo  *model = self.dataSource[indexPath.section];
//            [cell setContent:model];
//            NSURL *videoURL = [NSURL URLWithString:model.movie];
//            __block NSIndexPath *weakIndexPath = indexPath;
//            __block StarVideoTableViewCell *weakCell = cell;
//            __weak typeof(self) weakSelf = self;
//            cell.playBlock = ^(UIButton *btn){
//                weakSelf.playerView = [ZFPlayerView sharedPlayerView];
//                [weakSelf.playerView setVideoURL:videoURL withTableView:weakSelf.mainTable AtIndexPath:weakIndexPath withImageViewTag:101];
//                [weakSelf.playerView addPlayerToCellImageView:weakCell.picView];
//                weakSelf.playerView.playerLayerGravity =ZFPlayerLayerGravityResizeAspect;
//                [weakSelf write_play_recordData:model.ID];
//                
//            };
//
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//        
//    }
//    else
//    {
//        StarVideoTableViewCell* cell = [_videoTable dequeueReusableCellWithIdentifier:@"video" forIndexPath:indexPath];
//        return cell;
//    }
//}


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

@end
