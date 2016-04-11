//
//  WikiWorksDetailsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WikiWorksDetailsViewController.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry/Masonry.h>
#import "ZFPlayer.h"
#import "UITabBarController+ShowHideBar.h"
#define kHeadHeight 187
@interface WikiWorksDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *wikiDetailsTableView;
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, strong) UIView *topView;
@end

@implementation WikiWorksDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    
    NSLog(@"%@",self.homePage.imgs);
    
    self.topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_topView];
    [_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(20);
    }];
    
    self.playerView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
        // 注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    
    if (self.homePage.imgs == nil) {
          self.playerView.videoURL = [NSURL URLWithString:@"http://7xsnr6.com1.z0.glb.clouddn.com/o_1ag1l6dhs150h5r9rkn1uqh9ca11.mp4"];
    }
  
    // （可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    // 打开断点下载功能（默认没有这个功能）
    //self.playerView.hasDownload = YES;
    
    // 如果想从xx秒开始播放视频
    //self.playerView.seekTime = 15;
    __weak typeof(self) weakSelf = self;
    self.playerView.goBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:self.wikiDetailsTableView];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)dealloc{
      [self.playerView cancelAutoFadeOutControlBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //[[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
  
    self.navigationController.navigationBarHidden = YES;
    [self.tabBarController setHidden:YES];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
        //if use Masonry,Please open this annotation
       
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(0);
         }];
        [self.view addSubview:self.wikiDetailsTableView];
        
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
        //if use Masonry,Please open this annotation
        
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(0);
         }];
        [self.wikiDetailsTableView removeFromSuperview];
        
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
        self.navigationController.navigationBarHidden = NO;
    [self.tabBarController setHidden:NO];
}


- (UITableView *)wikiDetailsTableView{
    if (!_wikiDetailsTableView) {
        self.wikiDetailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.playerView.frame), kScreen_Width, kScreen_Height - CGRectGetHeight(self.playerView.frame) - 48 ) style:UITableViewStylePlain];
        self.wikiDetailsTableView.delegate = self;
        self.wikiDetailsTableView.dataSource = self;
        self.wikiDetailsTableView.separatorStyle = NO;
        [self.wikiDetailsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"wikidetails"];
        self.wikiDetailsTableView.backgroundColor = COLOR_WithHex(0x2f2f2f2);
    }
    return _wikiDetailsTableView;
}

#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 42;
    }else{
        return 242;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wikidetails" forIndexPath:indexPath];
    if (cell == nil) {
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wikidetails"];
    }
    UIView *head_view = [cell viewWithTag:999];
    if (head_view == nil) {
        UIView *head_view = [[UIView alloc]init];
        head_view.backgroundColor = COLOR_WithHex(0xefefef);
        head_view.frame = CGRectMake(0, 0, kScreen_Width, 10);
        UILabel *up_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
        up_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [head_view addSubview:up_lab];
        UILabel *down_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, kScreen_Width, 0.5)];
        down_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [head_view addSubview:down_lab];
        head_view.tag = 999;
           [cell addSubview:head_view];
    }

    
    if (indexPath.row == 0) {
        
        UILabel *title_lab = [cell viewWithTag:1000];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 30, 32)];
            title_lab.textColor = COLOR_WithHex(0x545454);
            title_lab.font = kFONT14;
            title_lab.tag = 1000;
            title_lab.numberOfLines = 0;
            [cell addSubview:title_lab];
        }
        title_lab.text = self.homePage.title;
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else{

        UILabel *mes_lab = [cell viewWithTag:1001];
        if (!mes_lab) {
            UILabel *mes_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 30, 32)];
            mes_lab.textColor = COLOR_WithHex(0x545454);
            mes_lab.font = kFONT14;
            mes_lab.text = @"简介";
            mes_lab.tag = 1001;
            [cell addSubview:mes_lab];
        }
       
        UILabel *line_lab = [cell viewWithTag:1002];
        if (!line_lab) {
            UILabel *line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 42, kScreen_Width - 30, 0.5)];
            line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
            line_lab.font = kFONT14;
            [cell addSubview:line_lab];
            line_lab.tag = 1002;
        }
        
        UILabel *des_lab = [cell viewWithTag:1003];
        if (!des_lab) {
            UILabel *des_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 52, kScreen_Width - 30, 200)];
            des_lab.textColor = COLOR_WithHex(0xa5a5a5);
            des_lab.font = kFONT14;
            des_lab.text = self.homePage.profile;
            [cell addSubview:des_lab];
                des_lab.tag = 1003;
        }
 
       // NSLog(@"self.homePage.profile = %@",self.homePage.profile);
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
