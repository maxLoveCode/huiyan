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
#import "WalletTableViewController.h"
#import <MJRefresh.h>
#import "GifRefresher.h"
#import "WXApi.h"
#define HeadHight 230
#define TailHeight kScreen_Height  - 40 - 64 - 210
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
//@property (nonatomic, strong) ZFPlayerView *playerView;
@property (nonatomic, assign) CGFloat totalOffsetY;
@property (nonatomic, strong) UIView *tailView;
@property (nonatomic, strong) UIButton *videoBtn;
@property (nonatomic, strong) UIButton *desBtn;
@property (nonatomic, strong) UIView *desView;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSDate* target;
@property (nonatomic, assign) BOOL color_Theme;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) UIView *bg_view;
@property (nonatomic, strong) UIView *jump_view;
@property (nonatomic, strong) UIImage *wx_image;
@end
static int number_page = 0;
@implementation DramaStarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态";
    self.dataSource = [NSMutableArray array];
    self.serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.mainTable];
    [self.view addSubview:self.tailView];
    // Do any additional setup after loading the view.
    self.mainTable.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self get_actor_dongtaiData:[NSString stringWithFormat:@"%d",number_page]];
    }];
     [self.mainTable.mj_header beginRefreshing];
  
    _count =0;
}

- (UIView *)tailView{
    if (!_tailView ) {
        self.tailView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height - 48, kScreen_Width, 48)];
        self.tailView.backgroundColor = [UIColor whiteColor];
        UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        inviteBtn.frame = CGRectMake(0, 0, kScreen_Width / 3 - 2, 48);
        [inviteBtn setTitle:@"邀约" forState:UIControlStateNormal];
        [inviteBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        [inviteBtn addTarget:self action:@selector(inviteEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.tailView addSubview:inviteBtn];
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sendBtn.frame = CGRectMake(kScreen_Width / 3 , 0, kScreen_Width / 3 - 2, 48);
        [sendBtn setTitle:@"送花" forState:UIControlStateNormal];
        [sendBtn setImage:[UIImage imageNamed:@"flower"] forState:UIControlStateNormal];
        [sendBtn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        [sendBtn addTarget:self action:@selector(sendFlower:) forControlEvents:UIControlEventTouchUpInside];
        [self.tailView addSubview:sendBtn];
        UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        shareBtn.frame = CGRectMake(kScreen_Width / 3 * 2, 0, kScreen_Width / 3 - 2, 48);
        [shareBtn addTarget:self action:@selector(sharedWeixin:) forControlEvents:UIControlEventTouchUpInside];
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
        self.downScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 48 - 64 - 40)];
        self.downScrollow.contentSize = CGSizeMake(kScreen_Width * 2, kScreen_Height);
        self.downScrollow.scrollEnabled = NO;
        [self.downScrollow addSubview:self.videoTable];
        [self.downScrollow addSubview:self.desView];
    }
    return _downScrollow;
}

- (UIView *)desView{
    if (!_desView) {
        self.desView = [[UIView alloc]initWithFrame:CGRectMake(kScreen_Width, 0, kScreen_Width, TailHeight)];
        UILabel *grayLab  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
        grayLab.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.desView addSubview:grayLab];
        CGSize size =  [self.drama.profile boundingRectWithSize:CGSizeMake(kScreen_Width - 30, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{
                                                             NSFontAttributeName :kFONT13
                                                             }
                                                   context:nil].size;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, kScreen_Width- 30, size.height)];
        lab.text = self.drama.profile;
        lab.numberOfLines = 0;
        lab.font = kFONT13;
        [self.desView addSubview:lab];
    }
    return _desView;
}

- (void)setbg_view{
        self.bg_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        self.bg_view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeView)];
        [self.bg_view addGestureRecognizer:tapGesture];
        [self setJump_view];
        [self.bg_view addSubview:self.jump_view];

}

- (void)setJump_view{

        self.jump_view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height + 120, kScreen_Width, 120)];
        _jump_view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 30, 0, 60, 30)];
        label.text = @"分享到";
        [self.jump_view addSubview:label];
        UIButton *friendCircle_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        friendCircle_btn.tag = 222;
        [friendCircle_btn addTarget:self action:@selector(sharedFriend:) forControlEvents:UIControlEventTouchUpInside];
        friendCircle_btn.frame = CGRectMake(10, CGRectGetMaxY(label.frame), 80, 80);
        [friendCircle_btn setImageEdgeInsets:UIEdgeInsetsMake(-20, 10, 0, 0)];
        [friendCircle_btn setImage:[UIImage imageNamed:@"icon_timeline"] forState:UIControlStateNormal];
        friendCircle_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [friendCircle_btn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
        [friendCircle_btn setTitleEdgeInsets:UIEdgeInsetsMake(65, -55, 0, 0)];
        [friendCircle_btn setTitle:@"微信朋友圈" forState:UIControlStateNormal];
        [self.jump_view addSubview:friendCircle_btn];
        UIButton *friend_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        friend_btn.tag = 223;
        [friend_btn addTarget:self action:@selector(sharedFriend:) forControlEvents:UIControlEventTouchUpInside];
        friend_btn.frame = CGRectMake(CGRectGetMaxX(friendCircle_btn.frame) + 5, CGRectGetMinY(friendCircle_btn.frame) , 80, 80);
        [friend_btn setTitleEdgeInsets:UIEdgeInsetsMake(65, -55, 0, 0)];
        [friend_btn setImageEdgeInsets:UIEdgeInsetsMake(-20, 10, 0, 0)];
        [friend_btn setImage:[UIImage imageNamed:@"icon_session"] forState:UIControlStateNormal];
        friend_btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [friend_btn setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
        [friend_btn setTitle:@"微信好友" forState:UIControlStateNormal];
        [self.jump_view addSubview:friend_btn];
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
    self.navigationController.navigationBar.translucent = YES;
    // 隐藏导航栏,给导航栏设置空的图片
    // NSLog(@"self.color_Theme%d",self.color_Theme);
    if (self.mainTable.contentOffset.y > 165) {
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:229/255.0 green:72/255.0 blue:99/ 255.0 alpha:1]];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    }else{
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    }
    
    
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
    
}

-(UITableView *)mainTable
{
    if (!_mainTable) {
        self.mainTable = [[UITableView alloc] init];
        self.mainTable.frame = CGRectMake(0, 0, kScreen_Width,kScreen_Height );
        self.mainTable.contentSize = CGSizeMake(kScreen_Width, kScreen_Height + 200);
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
        self.videoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,kScreen_Height - 48 - 64 - 40) style:UITableViewStyleGrouped];
         self.videoTable.delegate = self;
         self.videoTable.dataSource = self;
        [ self.videoTable registerClass:[StarVideoTableViewCell class] forCellReuseIdentifier:@"video"];
        [ self.videoTable registerNib:[UINib nibWithNibName:@"DynamicTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"text"];
        [ self.videoTable registerClass:[DynamicImageTableViewCell class] forCellReuseIdentifier:@"image"];
          self.videoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    if (tableView == self.mainTable) {
        if (section == 1) {
            return 40;
        }
        return 0.01;
    }
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
            return  kScreen_Height - 64 - 48 - 40;
        }
    }else if (tableView == _videoTable){
        StarVideo *model = self.dataSource[indexPath.section];
        if ([model.type isEqualToString:@"movie"]) {
            return 175 + (kScreen_Width - 30) / 2;
        }else if(
                 [model.type isEqualToString:@"text"]){
            return 150;
        }else{
            return 170 + (kScreen_Width - 60) / 3;
        }
        
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.mainTable) {
        if (section == 1) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        headView .backgroundColor = [UIColor whiteColor];
        UIButton *videoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        videoBtn.frame = CGRectMake(0, 0, kScreen_Width / 2, 40);
        [videoBtn setTitle:@"动态" forState:UIControlStateNormal];
        [headView addSubview:videoBtn];
       UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 0.5, 4, 1, 32)];
        lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
            [headView addSubview:lineLab];
        UIButton *desBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        desBtn.frame = CGRectMake(kScreen_Width / 2, 0, kScreen_Width / 2, 40);
        [desBtn setTitle:@"简介" forState:UIControlStateNormal];
        [headView addSubview:desBtn];
        UIColor *color = COLOR_THEME;
        [videoBtn setTitleColor:color forState:UIControlStateNormal];
        [desBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.videoBtn = videoBtn;
        self.desBtn = desBtn;
        videoBtn.tag = 110;
        desBtn.tag = 112;
        [videoBtn addTarget:self action:@selector(moveScrollow:) forControlEvents:UIControlEventTouchUpInside];
        [desBtn addTarget:self action:@selector(moveScrollow:) forControlEvents:UIControlEventTouchUpInside];
        return headView;
        }
    }
    return nil;
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
//            [cell.contentView setBackgroundColor: [UIColor redColor]];
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
            cell.typePic.image = [UIImage imageNamed:@"videotype"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }else if([model.type isEqualToString:@"text"]){
                DynamicTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"text"];
            [cell setContent:model];
            cell.typePic.image = [UIImage imageNamed:@"texttype"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            DynamicImageTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"image" forIndexPath:indexPath];
            [cell setContent:model];
             cell.typePic.image = [UIImage imageNamed:@"imgetype"];
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
  //  NSLog(@"params = %@",params);
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
         //   NSLog(@"mag = %@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
    
}
#pragma mark -- 记录播放次数
- (void)write_play_recordData:(NSString *)movid_id{
   // NSLog(@"cid = %@   accessken = %@",movid_id,self.serverManager.accessToken);
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"user_id":self.drama.userID,@"movie_id":movid_id};
   // NSLog(@"%@",params);
    [self.serverManager AnimatedPOST:@"write_play_record.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50050) {
          //  NSLog(@"%@",responseObject[@"msg"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


- (void)get_actor_dongtaiData:(NSString *)page{
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"actor_id":self.drama.userID,@"page":page};
    [self.serverManager GETWithoutAnimation:@"get_actor_dongtai.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50030) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                StarVideo *model = [StarVideo starVideoWithDic:dic];
                [self.dataSource addObject:model];
            }
            if (self.dataSource.count % 10 != 0 || self.dataSource.count == 0) {
                self.videoTable.mj_footer = nil;
            }else {
                if (!self.videoTable.mj_footer) {
                    self.videoTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                        number_page ++;
                      //  NSLog(@"numberPage = %d",number_page);
                        [self get_actor_dongtaiData:[NSString stringWithFormat:@"%d",number_page]];
                    }];
                }
            }
            [self.videoTable reloadData];
            [self.mainTable.mj_header endRefreshing];
            [self.videoTable.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.videoTable) {
         CGFloat offsetY = self.videoTable.contentOffset.y;
      //  CGFloat mainoffsetY = self.mainTable.contentOffset.y;
     //   NSLog(@"delta = %f,main = %f",offsetY,mainoffsetY);
        CGFloat alpha = 0.99;
//        if (height <= kHeadMinHeight ) {
//            alpha = 0.99;
//        } else {
//            alpha = 0;
//            //        [self.videoTable setScrollEnabled:YES];
//            //        [self.mainTable setScrollEnabled:YES];
//            
//        }
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:229/255.0 green:72/255.0 blue:99/ 255.0 alpha:alpha]];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        if (offsetY < 165) {
            self.mainTable.contentOffset = CGPointMake(0, offsetY +5);
                }else if (offsetY >=165)
             self.mainTable.contentOffset = CGPointMake(0, 165);
       

    }
    if (scrollView == self.mainTable) {
    CGFloat offsetY = self.mainTable.contentOffset.y;
    
    // 计算tabView滚动的偏移量
    CGFloat delta = offsetY - self.totalOffsetY;

    CGFloat height = kHeadHeight - delta;

    
    height = height < 0 ? 0 : height;
    
    // 透明度
    CGFloat alpha = 0;
    if (height <= kHeadMinHeight ) {
        alpha = 0.99;


       
    } else {
        alpha = 0;
//        [self.videoTable setScrollEnabled:YES];
//        [self.mainTable setScrollEnabled:YES];
        
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
    [self.serverManager POSTWithoutAnimation:@"send_actor_flower.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50040) {
            //[self presentViewController:[Tools showAlert:@"送花成功"] animated:YES completion:nil];
            [self combo:0];
            [self flowerAnimates];
        }
        else
        {
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的余额不足" preferredStyle:UIAlertControllerStyleAlert];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"去充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                WalletTableViewController *wallCon = [[WalletTableViewController alloc]init];
                [self.navigationController pushViewController:wallCon animated:YES];
            }]];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    
}

//微信朋友圈分享
- (void)sharedWeixin:(UIButton *)sender{
    [self setbg_view];
     [[UIApplication sharedApplication].keyWindow addSubview:self.bg_view];
    [UIView animateWithDuration:0.5 animations:^{
        _jump_view.frame = CGRectMake(0, kScreen_Height - 120, kScreen_Width, 120);
    }];
    
}
- (void)sharedFriend:(UIButton *)sender{
        if (![WXApi isWXAppInstalled]) {
            [self presentViewController:[Tools showAlert:@"您还没有安装微信!"] animated:YES completion:nil];
        }
        if (sender.tag == 222) {
            [self performActivity:@"Circle"];
        }else{
            [self performActivity:@"Friend"];
        }
}
- (void)performActivity:(NSString *)type
{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    // req.scene = WXSceneTimeline;
    // req.bText = NO;
    if ([type isEqualToString:@"Circle"]) {
        req.scene = WXSceneTimeline;
    }else{
        req.scene = WXSceneSession;
    }
    req.message = WXMediaMessage.message;
    req.message.title = self.drama.nickName;
    req.message.description = self.drama.profile;
    [self setThumbImage:req];
    NSString *url = kServerUrl;
    NSString *url_str = [NSString stringWithFormat:@"%@/index.php/Home/Share/actor/aid/%@",url,self.drama.userID];
    NSURL *url_weixin = [NSURL URLWithString:url_str];
    if (url_weixin) {
        WXWebpageObject *webObject = WXWebpageObject.object;
        webObject.webpageUrl = [url_weixin absoluteString];
        req.message.mediaObject = webObject;
    } else if (self.wx_image) {
        WXImageObject *imageObject = WXImageObject.object;
        imageObject.imageData = UIImageJPEGRepresentation(self.wx_image, 1);
        req.message.mediaObject = imageObject;
    }
    [WXApi sendReq:req];
}
- (void)setThumbImage:(SendMessageToWXReq *)req
{
    self.wx_image = [UIImage imageNamed:@"logo29"];
    if (self.wx_image) {
        CGFloat width = 100.0f;
        CGFloat height = self.wx_image.size.height * 100.0f / self.wx_image.size.width;
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [self.wx_image drawInRect:CGRectMake(0, 0, width, height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [req.message setThumbImage:scaledImage];
    }
}
- (void)removeView{
    [self.bg_view removeFromSuperview];
}



- (void)moveScrollow:(UIButton *)sender{
    UIColor *color = COLOR_THEME;
    if (sender.tag == 110) {
        [self.downScrollow setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.videoBtn setTitleColor:color forState:UIControlStateNormal];
        [self.desBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.mainTable.scrollEnabled = YES;
    }else{
        [self.downScrollow setContentOffset:CGPointMake(kScreen_Width, 0) animated:YES];
        [self.mainTable setContentOffset:CGPointMake(0, 0)];
        self.mainTable.scrollEnabled = NO;
        [self.videoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.desBtn setTitleColor:color forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)flowerAnimates{
    UIImageView *imageViewForAnimation = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flower"]];
    imageViewForAnimation.tag = 8201;
    [self.view addSubview:imageViewForAnimation];
    [imageViewForAnimation setFrame:CGRectMake(kScreen_Width/2-44, kScreen_Height-44, 44, 44)];
    imageViewForAnimation.alpha = 1.0f;
    CGRect imageFrame = imageViewForAnimation.frame;
    //Your image frame.origin from where the animation need to get start
    CGPoint viewOrigin = imageViewForAnimation.frame.origin;
    viewOrigin.y = viewOrigin.y + imageFrame.size.height / 2.0f;
    viewOrigin.x = viewOrigin.x + imageFrame.size.width / 2.0f;
    
    imageViewForAnimation.frame = imageFrame;
    imageViewForAnimation.layer.position = viewOrigin;
    [self.view addSubview:imageViewForAnimation];
    
    // Set up fade out effect
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [fadeOutAnimation setToValue:[NSNumber numberWithFloat:0.1]];
    fadeOutAnimation.fillMode = kCAFillModeForwards;
    fadeOutAnimation.removedOnCompletion = NO;
    
    // Set up scaling
    CABasicAnimation *resizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    [resizeAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(40.0f, imageFrame.size.height * (40.0f / imageFrame.size.width))]];
    resizeAnimation.fillMode = kCAFillModeForwards;
    resizeAnimation.removedOnCompletion = NO;
    
    // Set up path movement
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    //Setting Endpoint of the animation
    CGPoint endPoint = CGPointMake(kScreen_Width/2, kScreen_Height/2);
    //to end animation in last tab use
    //CGPoint endPoint = CGPointMake( 320-40.0f, 480.0f);
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, viewOrigin.x, viewOrigin.y);
    int value = (arc4random() % 60) + 1;
    int dir = (value%2 == 0)?1:-1;
    CGPoint pt = CGPointMake(kScreen_Width/2+value*dir, kScreen_Height/2-value*dir);
    
    int value2 = (arc4random() % 20) + 1;
    int dir2 = (value%2 == 0)?1:-1;
    CGPathAddCurveToPoint(curvedPath, NULL, viewOrigin.x, viewOrigin.y, pt.x, pt.y, endPoint.x+value2*dir2, endPoint.y+value2*dir2);
    //CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, viewOrigin.y, endPoint.x, viewOrigin.y, endPoint.x, endPoint.y);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setAnimations:[NSArray arrayWithObjects:fadeOutAnimation, pathAnimation, resizeAnimation, nil]];
    group.duration = 0.7f;
    group.delegate = self;
    [group setValue:imageViewForAnimation forKey:@"imageViewBeingAnimated"];
    
    [imageViewForAnimation.layer addAnimation:group forKey:@"savingAnimation"];
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    UIView* view = [self.view viewWithTag:8201];
    [view removeFromSuperview];
}

-(void)combo:(NSInteger*) counts
{
    if (!_target) {
        self.target = [NSDate date];
    }
    else
    {
        NSTimeInterval sec = [[NSDate date] timeIntervalSinceDate:self.target];
        if (sec <2) {
            self.target = [NSDate date];
            _count++;
            [self animateCombos];
            if(!_timer)
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:NO];
            else if ([_timer isValid])
            {
                [_timer invalidate];
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:NO];
            }
        }
        else
        {
            self.target = nil;
            _count = 0;
        }
    }
}

-(void)animateCombos
{
    UILabel* view = [self.view viewWithTag:3131];
    UIColor* theme = COLOR_THEME
    if (!view) {
        view.alpha = 1;
        UILabel* view = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width/3*2, kScreen_Height/2+100, kScreen_Width/3, 60)];
        view.tag = 3131;
        
        view.attributedText=[[NSAttributedString alloc]
                                   initWithString:[NSString stringWithFormat:@"x %d", (int)_count+1]
                                   attributes:@{
                                                NSStrokeWidthAttributeName: @-5.0,
                                                NSStrokeColorAttributeName:theme,
                                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                                NSFontAttributeName: kFONT(50)
                                                }
                                   ];
        
        [self.view addSubview:view];
    }
    else
    {
        view.alpha = 1;

    view.attributedText=[[NSAttributedString alloc]
                         initWithString:[NSString stringWithFormat:@"x %d", (int)_count+1]
                         attributes:@{
                                      NSStrokeWidthAttributeName: @-5.0,
                                      NSStrokeColorAttributeName:theme,
                                      NSForegroundColorAttributeName:[UIColor whiteColor],
                                      NSFontAttributeName: kFONT(50)
                                      }
                         ];
    }
}

-(void)countDown
{
  //  NSLog(@"countDown");
    UILabel* view = [self.view viewWithTag:3131];
    [UIView animateWithDuration:1.0 animations:^{
                view.alpha = 0;
            }completion:^(BOOL finished) {
                [view removeFromSuperview];
                _timer = nil;
            }];
}

@end
