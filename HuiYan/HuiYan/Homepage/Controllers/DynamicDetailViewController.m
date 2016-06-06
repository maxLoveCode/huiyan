//
//  DynamicDetailViewController.m
//  huiyan
//
//  Created by zc on 16/5/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "ServerManager.h"
#import "Constant.h"
#import "DynamicCommentCell.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry/Masonry.h>
#import "ZFPlayer.h"
#import "WriteCommentViewController.h"
#import <MJRefresh.h>
#import "GifRefresher.h"
@interface DynamicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)ServerManager *serverManager;
@property (nonatomic, assign)CGFloat headPic;
@property (nonatomic, assign)CGFloat comment;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *likeBtn;
@property (strong, nonatomic) ZFPlayerView *playerView;

@end
static int number_page = 0;
@implementation DynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态详情";
    self.view.backgroundColor  = [UIColor whiteColor];
      [self.view addSubview:self.tableView];
    self.serverManager = [ServerManager sharedInstance];
    self.dataSource = [NSMutableArray array];
    self.tableView.mj_header = [GifRefresher headerWithRefreshingBlock:^{
        number_page = 0;
        [self.dataSource removeAllObjects];
        [self get_dongtai_commentData:[NSString stringWithFormat:@"%d",number_page]];
    }];
    [self.tableView.mj_header beginRefreshing];
//
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.starVideo.type isEqualToString:@"movie"]) {
        [self setVideoView];
    }

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [self.playerView resetPlayer];
}

- (void)setVideoView{
    //NSLog(@"%@",self.homePage.type);
    [[UIDevice currentDevice] setValue:
     [NSNumber numberWithInteger: UIInterfaceOrientationPortrait]
                                forKey:@"orientation"];
    self.topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_topView];
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(20);
    }];
    
    self.playerView = [[ZFPlayerView alloc] init];
  //  self.playerView.backgroundColor = [UIColor redColor];
    [self.view addSubview: self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
        // 注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    
    if ([self.starVideo.type isEqualToString:@"movie"] && self.starVideo.content[0] != nil) {
        self.playerView.videoURL = [NSURL URLWithString:self.starVideo.content[0]];
    }
    // （可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    // 打开断点下载功能（默认没有这个功能）
    //self.playerView.hasDownload = YES;
    
    // 如果想从xx秒开始播放视频
    //self.playerView.seekTime = 15;
    //    __weak typeof(self) weakSelf = self;
    self.playerView.controlView.backBtn.hidden = YES;
    //    self.playerView.goBackBlock = ^{
    //        [weakSelf.navigationController popViewControllerAnimated:YES];
    //    };
}

- (void)dealloc{
    [self.playerView cancelAutoFadeOutControlBar];
}

//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}

- (BOOL)shouldAutorotate{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
        //if use Masonry,Please open this annotation
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        self.navigationController.navigationBarHidden = NO;
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
        }];
        [self.view addSubview:self.tableView];
        
        
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
        //if use Masonry,Please open this annotation
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        self.navigationController.navigationBarHidden = YES;
        [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
        }];
        [self.tableView removeFromSuperview];

        
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] init];
        if ([self.starVideo.type isEqualToString:@"movie"]) {
            self.tableView.frame = CGRectMake(0, kScreen_Width / 16 *9, kScreen_Width,kScreen_Height - kScreen_Width / 16 *9 - 10);
        }else{
        self.tableView.frame = CGRectMake(0, 0, kScreen_Width,kScreen_Height - 10);
        }
       // self.tableView.bounces = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"head"];
        [self.tableView registerClass:[DynamicCommentCell class] forCellReuseIdentifier:@"comment"];
    }
    return _tableView;
}

#pragma mark -- tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataSource.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 35;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.headPic + 112;
    }else{
        return self.comment + 65;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 35)];
        headView.backgroundColor = [UIColor whiteColor];
        UILabel *h_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 8, 5, 19)];
        h_lab.backgroundColor = COLOR_THEME;
        h_lab.layer.masksToBounds = YES;
        h_lab.layer.cornerRadius = 2;
        [headView addSubview:h_lab];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 150, 35)];
        titleLab.text = @"戏友留言";
        titleLab.font = kFONT16;
        [headView addSubview:titleLab];
        UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 100, 5, 0.5, 25)];
        lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
        [headView addSubview:lineLab];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreen_Width - 115, 0, 100, 35);
        [btn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"dramavideo"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(writeComment:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        [btn setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count] forState:UIControlStateNormal];
        UILabel *v_Lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 34, kScreen_Width - 30, 0.5)];
        v_Lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [headView addSubview:v_Lab];
        [headView addSubview:btn];
        return headView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"head"];
        if ([self.starVideo.type isEqualToString:@"movie"]) {
            UIImageView *headView = [cell viewWithTag:1000];
            if (!headView) {
                headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
              //  headView.backgroundColor = [UIColor redColor];
                [cell.contentView addSubview:headView];
                headView.tag = 1000;
            }
            self.headPic = 0;
            UILabel *titleLab = [cell viewWithTag:1008];
            if (!titleLab) {
                titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(headView.frame) +23, kScreen_Width - 30, 32)];
                titleLab.numberOfLines = 2;
                titleLab.textColor = COLOR_WithHex(0x565656);
                titleLab.font = kFONT16;
                [cell.contentView addSubview:titleLab];
                titleLab.tag = 1008;
            }
            titleLab.text = self.starVideo.title;
            UILabel *lineLab = [cell viewWithTag:1010];
            if (!lineLab) {
                lineLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLab.frame) + 23, kScreen_Width - 30, 1)];lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
                [cell.contentView addSubview:lineLab];
                lineLab.tag = 1010;
            }
            UIButton *likeBtn = [cell viewWithTag:1012];
            if (!likeBtn) {
                likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                likeBtn.frame = CGRectMake(15, CGRectGetMaxY(lineLab.frame), 100, 35);
                [cell.contentView addSubview:likeBtn];
                [likeBtn setTitleColor:COLOR_WithHex(0x565656) forState:UIControlStateNormal];
                likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                [likeBtn addTarget:self action:@selector(dropZan:) forControlEvents:UIControlEventTouchUpInside];
                likeBtn.tag = 1012;
            }
              self.likeBtn = likeBtn;
            if ([self.starVideo.is_like isEqualToString:@"1"]) {
                [self.likeBtn setImage:[UIImage imageNamed:@"liketrue"] forState:UIControlStateNormal];
            }else{
                [self.likeBtn setImage:[UIImage imageNamed:@"likewrong"] forState:UIControlStateNormal];
            }
          
            [likeBtn setTitle:self.starVideo.like_count forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if ([self.starVideo.type isEqualToString:@"text"]){
            UILabel *headView = [cell viewWithTag:1002];
            if (!headView) {
                headView = [[UILabel alloc]init];
                headView.font = kFONT14;
                headView.numberOfLines = 0;
                [cell.contentView addSubview:headView];
                headView.tag = 1002;
            }
            headView.text = self.starVideo.content[0];
            CGSize size =  [headView.text boundingRectWithSize:CGSizeMake(kScreen_Width - 30, MAXFLOAT)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{
                                                                   NSFontAttributeName :headView.font
                                                                   }
                                                         context:nil].size;
            headView.frame = CGRectMake(15, 15, kScreen_Width - 30, size.height);
            self.headPic = size.height + 15;
            UILabel *titleLab = [cell viewWithTag:1008];
            if (!titleLab) {
                titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(headView.frame) +23, kScreen_Width - 30, 32)];
                titleLab.numberOfLines = 2;
                titleLab.textColor = COLOR_WithHex(0x565656);
                titleLab.font = kFONT16;
                [cell.contentView addSubview:titleLab];
                titleLab.tag = 1008;
            }
            titleLab.text = self.starVideo.title;
            UILabel *lineLab = [cell viewWithTag:1010];
            if (!lineLab) {
                lineLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLab.frame) + 23, kScreen_Width - 30, 1)];lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
                [cell.contentView addSubview:lineLab];
                lineLab.tag = 1010;
            }
            UIButton *likeBtn = [cell viewWithTag:1012];
            if (!likeBtn) {
                likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                 [likeBtn setTitleColor:COLOR_WithHex(0x565656) forState:UIControlStateNormal];
                likeBtn.frame = CGRectMake(15, CGRectGetMaxY(lineLab.frame), 100, 35);
                likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                 [likeBtn addTarget:self action:@selector(dropZan:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:likeBtn];
                likeBtn.tag = 1012;
            }
            self.likeBtn = likeBtn;
            if ([self.starVideo.is_like isEqualToString:@"1"]) {
                [self.likeBtn setImage:[UIImage imageNamed:@"liketrue"] forState:UIControlStateNormal];
            }else{
                [self.likeBtn setImage:[UIImage imageNamed:@"likewrong"] forState:UIControlStateNormal];
            }

            [likeBtn setTitle:self.starVideo.like_count forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

            
        }else{
            
            UIScrollView *headView = [cell viewWithTag:1004];
            if (!headView) {
                headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width / 16 *9)];
                headView.pagingEnabled = YES;
                headView .contentSize = CGSizeMake(kScreen_Width * self.starVideo.content.count, kScreen_Width / 16 * 9);
                for (int i = 0; i < self.starVideo.content.count; i++) {
                    UIImageView *imagePic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width * i, 0, kScreen_Width, kScreen_Width / 16 * 9)];
                    imagePic.backgroundColor = [UIColor groupTableViewBackgroundColor];
                    imagePic.contentMode = UIViewContentModeScaleAspectFit;
                     [imagePic sd_setImageWithURL:[NSURL URLWithString:self.starVideo.content[i]]];
                    [headView addSubview:imagePic];
                }
                [cell.contentView addSubview:headView];
                headView.tag = 1004;
            }
            self.headPic = kScreen_Width / 16 *9;
           
            UILabel *titleLab = [cell viewWithTag:1008];
            if (!titleLab) {
                titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(headView.frame) +23, kScreen_Width - 30, 32)];
                titleLab.numberOfLines = 2;
                titleLab.textColor = COLOR_WithHex(0x565656);
                titleLab.font = kFONT16;
                [cell.contentView addSubview:titleLab];
                titleLab.tag = 1008;
            }
            titleLab.text = self.starVideo.title;
            UILabel *lineLab = [cell viewWithTag:1010];
            if (!lineLab) {
                lineLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLab.frame) + 23, kScreen_Width - 30, 1)];lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
                [cell.contentView addSubview:lineLab];
                lineLab.tag = 1010;
            }
            UIButton *likeBtn = [cell viewWithTag:1012];
            if (!likeBtn) {
                likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                likeBtn.frame = CGRectMake(15, CGRectGetMaxY(lineLab.frame), 100, 35);
                likeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [likeBtn setTitleColor:COLOR_WithHex(0x565656) forState:UIControlStateNormal];
                likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                 [likeBtn addTarget:self action:@selector(dropZan:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:likeBtn];
                likeBtn.tag = 1012;
            }
            self.likeBtn = likeBtn;
            if ([self.starVideo.is_like isEqualToString:@"1"]) {
                [self.likeBtn setImage:[UIImage imageNamed:@"liketrue"] forState:UIControlStateNormal];
            }else{
                [self.likeBtn setImage:[UIImage imageNamed:@"likewrong"] forState:UIControlStateNormal];
            }

            [likeBtn setTitle:self.starVideo.like_count forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
        
    }else{
        DynamicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
        if (self.dataSource.count > 0) {
            CGSize size =  [[self.dataSource[indexPath.row] objectForKey:@"comment"] boundingRectWithSize:CGSizeMake(kScreen_Width - 30, MAXFLOAT)
                                                                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                                                                               attributes:@{
                                                                                                            NSFontAttributeName :kFONT14
                                                                                                            }
                                                                                                  context:nil].size;
            self.comment = size.height;
            [cell setContent:self.dataSource[indexPath.row]];
        }
       
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)dropZan:(UIButton *)sender{
   // NSLog(@"+++++%@",self.starVideo.is_like);
    NSString *like = @"";
    if ([self.starVideo.is_like isEqualToString:@"1"]) {
        like = @"2";
    }else{
        like = @"1";
    }
    NSDictionary *dic = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"did":self.starVideo.ID,@"like":like};
    [self.serverManager AnimatedPOST:@"write_dongtai_like.php" parameters:dic success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 50060) {
            if ([self.starVideo.is_like isEqualToString:@"1"]) {
                [self.likeBtn setImage:[UIImage imageNamed:@"likewrong"] forState:UIControlStateNormal];
                self.starVideo.is_like = @"0";
                [self.likeBtn setTitle:[responseObject[@"data"]objectForKey:@"like_count"] forState:UIControlStateNormal];
            }else{
                [self.likeBtn setImage:[UIImage imageNamed:@"liketrue"] forState:UIControlStateNormal];
                self.starVideo.is_like = @"1";
                [self.likeBtn setTitle:[responseObject[@"data"]objectForKey:@"like_count"] forState:UIControlStateNormal];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

//写点评
- (void)writeComment:(UIButton *)sender{
    WriteCommentViewController *commentCon = [[WriteCommentViewController alloc]init];
    commentCon.starVideo = self.starVideo;
    commentCon.writeType = @"dramaStar";
    [self.navigationController pushViewController:commentCon animated:YES];
}

- (void)get_dongtai_commentData:(NSString *)page{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"did":self.starVideo.ID,@"page":page};
    [self.serverManager AnimatedGET:@"get_dongtai_comment.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50080) {
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                [self.dataSource addObject:dic];
            }
        }
        
        if (self.dataSource.count % 10 != 0 || self.dataSource.count == 0) {
            self.tableView.mj_footer = nil;
        }else {
            if (!self.tableView.mj_footer) {
                self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                    number_page ++;
                    [self get_dongtai_commentData:[NSString stringWithFormat:@"%d",number_page]];
                }];
            }
        }

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
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
