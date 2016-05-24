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
#import "NewHomePageDetailCellTableViewCell.h"
#define kHeadHeight 187
@interface WikiWorksDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *wikiDetailsTableView;
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, assign) CGFloat height;
@end

@implementation WikiWorksDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = [UIColor whiteColor];
    
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
    [self.view addSubview:self.playerView];
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.right.equalTo(self.view);
        // 注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
        make.height.equalTo(self.playerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    

        if ([self.homePage.type intValue] == 2 && self.homePage.imgs != nil) {
            NSData *jsonData = [self.homePage.imgs dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
          NSArray *data_arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
            self.playerView.videoURL = [NSURL URLWithString:data_arr[0]];
        }else{
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

- (void)viewDidAppear:(BOOL)animated
{
    if (self.tabBarController.tabBar.hidden == YES) {
        NSLog(@"hidden");
    }
    else
    {
        NSLog(@"not hidden");
        [self.tabBarController setHidden:YES];
    }
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES]
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

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
    self.tabBarController.tabBar.hidden = NO;
    //[self.tabBarController setHidden:NO];
}


- (UITableView *)wikiDetailsTableView{
    if (!_wikiDetailsTableView) {
        self.wikiDetailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.playerView.frame), kScreen_Width, kScreen_Height - CGRectGetHeight(self.playerView.frame) ) style:UITableViewStylePlain];
        self.wikiDetailsTableView.delegate = self;
        self.wikiDetailsTableView.dataSource = self;
        self.wikiDetailsTableView.separatorStyle = NO;
        [self.wikiDetailsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"wikidetails"];
        [self.wikiDetailsTableView registerNib:[UINib nibWithNibName:@"NewHomePageDetailCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"homepage"];
        self.wikiDetailsTableView.backgroundColor = COLOR_WithHex(0x2f2f2f2);
    }
    return _wikiDetailsTableView;
}

#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else{
        return 52 + self.height + 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 10;
    }
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        
        NewHomePageDetailCellTableViewCell *homecell = [tableView dequeueReusableCellWithIdentifier:@"homepage"];
        [homecell setContent:self.homePage];
           homecell.selectionStyle = UITableViewCellSelectionStyleNone;
            return homecell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wikidetails" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wikidetails"];
        }
        UILabel *mes_lab = [cell viewWithTag:1001];
        if (!mes_lab) {
            mes_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 30, 32)];
            mes_lab.textColor = COLOR_WithHex(0x545454);
            mes_lab.font = kFONT14;
            mes_lab.text = @"简介";
            mes_lab.tag = 1001;
            [cell.contentView addSubview:mes_lab];
        }
       
        UILabel *line_lab = [cell viewWithTag:1002];
        if (!line_lab) {
           line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 42, kScreen_Width - 30, 0.5)];
            line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
            line_lab.font = kFONT14;
            [cell.contentView addSubview:line_lab];
            line_lab.tag = 1002;
        }
        
        UILabel *des_lab = [cell viewWithTag:1003];
        if (!des_lab) {
            des_lab = [[UILabel alloc]init];
            des_lab.textColor = COLOR_WithHex(0xa5a5a5);
            des_lab.font = kFONT14;
            des_lab.numberOfLines = 0;
            [cell.contentView addSubview:des_lab];
                des_lab.tag = 1003;
        }
        des_lab.text = self.homePage.profile;
        CGSize size =  [self.homePage.profile boundingRectWithSize:CGSizeMake(kScreen_Width - 30, MAXFLOAT)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{
                                                              NSFontAttributeName :des_lab.font
                                                              }
                                                    context:nil].size;
        [des_lab setFrame:CGRectMake(kMargin, 52, kScreen_Width - 30, size.height)];
        self.height = size.height;
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
