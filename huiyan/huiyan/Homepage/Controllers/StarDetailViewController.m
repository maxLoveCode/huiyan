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
    [self get_actor_movieData:@"0"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
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
        
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
        }];

        
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
        self.view.backgroundColor = [UIColor blackColor];
        
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)mainTable
{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64 )style:UITableViewStyleGrouped];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        [_mainTable registerClass:[StarVideoTableViewCell class] forCellReuseIdentifier:@"main"];
        [_mainTable registerClass:[StarDetailTableViewCell class] forCellReuseIdentifier:@"starMain"];
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
    if (tableView == _mainTable) {
        return 1;
    }
    else
        return [_dataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.mainTable) {
        if (indexPath.section == 0) {
            return 200;
        }
    }
    return 261;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 + self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == _mainTable) {
        return 0.01;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == self.dataSource.count) {
        return 10;
    }
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _mainTable) {
        if (indexPath.section == 0) {
            StarDetailTableViewCell *starDetail = [_mainTable dequeueReusableCellWithIdentifier:@"starMain" forIndexPath:indexPath];
            [starDetail setContent:self.drama];
            self.focus_btn = starDetail.focus_btn;
            NSLog(@"%@",self.drama.is_fans);
            if ([self.drama.is_fans integerValue] == 1) {
                [starDetail.focus_btn setTitle:@"取消关注" forState:UIControlStateNormal];
                [starDetail.focus_btn setBackgroundColor:[UIColor grayColor]];
            }else{
                [starDetail.focus_btn setTitle:@"+  关注" forState:UIControlStateNormal];
                UIColor *color = COLOR_THEME;
                 [starDetail.focus_btn setBackgroundColor:color];
            }
            starDetail.focus = ^(UIButton *btn){
                if ([btn.titleLabel.text isEqualToString:@"取消关注"] ) {
                    [self focus:@"cancel"];
                }else{
                    [self focus:@"follow"];
                }
            };
            starDetail.selectionStyle = UITableViewCellSelectionStyleNone;
            return starDetail;
        }else{
       StarVideoTableViewCell * cell = [_mainTable dequeueReusableCellWithIdentifier:@"main" forIndexPath:indexPath];
            StarVideo  *model = self.dataSource[indexPath.section - 1];
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
    }
    else
    {
        StarVideoTableViewCell* cell = [_videoTable dequeueReusableCellWithIdentifier:@"video" forIndexPath:indexPath];
        return cell;
    }
}

- (void)get_actor_movieData:(NSString *)page{
    self.dataSource = [NSMutableArray array];
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"user_id":self.drama.userID,@"page":@"0"};
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