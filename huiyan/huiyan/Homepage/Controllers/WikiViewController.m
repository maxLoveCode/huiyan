//
//  WikiViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WikiViewController.h"
#import "Constant.h"
#import "HomePageCell.h"
#import "MCSwipeMenu.h"
#import "ServerManager.h"
#import "WikiArtcleTableViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "ArticalViewController.h"

#define kLineNumber 3

@interface WikiViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MCSwipeMenuDelegate, UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) UITableView *dramaTableView;
@property (nonatomic, strong) MCSwipeMenu* head_view;
@property (nonatomic, strong) UIView *bg_view;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) ServerManager* serverManager;
@property (nonatomic, strong) UISegmentedControl *segement;
@property (nonatomic, strong) WikiArtcleTableViewController *wikiArtcleTableView;
@property (nonatomic, strong) UIScrollView *scrollView;

//register for the preview context
@property (nonatomic, strong) id previewingContext;

@end

@implementation WikiViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(search:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.titleView = self.segement;
    [self.view setBackgroundColor:COLOR_WithHex(0xefefef)];
    [self.view addSubview:self.head_view];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.dramaTableView];
    [self addChildViewController:self.wikiArtcleTableView];
    [self.scrollView addSubview:self.wikiArtcleTableView.tableView];
    
    _serverManager = [ServerManager sharedInstance];
    
    [self getDramaCates];
    [self getDramaList:@"0" page:0];
    
    if ([self isForceTouchAvailable]) {
        self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.dramaTableView];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UIView *)head_view{
    if (!_head_view) {
        _head_view = [[MCSwipeMenu alloc] init];
        _head_view.delegate = self;
    }
    return _head_view;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,41 , kScreen_Width, kScreen_Height - 41 - 64)];
        _scrollView.contentSize = CGSizeMake(kScreen_Width * 2, kScreen_Height - 41 - 48);
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = NO;
        _scrollView.backgroundColor = COLOR_WithHex(0xefefef);
    }
    return _scrollView;
}

- (UISegmentedControl *)segement{
    if (!_segement) {
        self.segement = [[UISegmentedControl alloc]initWithItems:@[@"百科",@"慕课"]];
        self.segement.frame = CGRectMake(0, 0, 110, 24);
        self.segement.selectedSegmentIndex = 0;
        self.segement.tintColor = [UIColor whiteColor];
        NSDictionary *noselectedDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]};
         UIColor *color  = COLOR_THEME;
        NSDictionary *selectedDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:color};
        [_segement setTitleTextAttributes:noselectedDic forState:UIControlStateNormal];
        [_segement setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
        [_segement addTarget:self action:@selector(handelSegemnetControl:) forControlEvents:UIControlEventValueChanged];
    }
    return _segement;
}

- (UITableViewController *)wikiArtcleTableView{
    if (!_wikiArtcleTableView) {
     self.wikiArtcleTableView = [[WikiArtcleTableViewController alloc]init];
       
      
    }
    return _wikiArtcleTableView;
}

- (UITableView *)dramaTableView{
    if (_dramaTableView == nil) {
        self.dramaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,10, kScreen_Width, kScreen_Height - 41- 64)];
        self.dramaTableView.delegate = self;
        self.dramaTableView.dataSource = self;
        [self.dramaTableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"drama"];
        self.dramaTableView.separatorStyle = NO;
        self.dramaTableView.rowHeight = [HomePageCell cellHeight];
    }
    return _dramaTableView;
}
#pragma mark tableView代理方法


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 10.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"drama";
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setContent:[_dataSource objectAtIndex:indexPath.section]];
  //  NSLog(@"cell = %@",cell);
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _dramaTableView) {
        ArticalViewController * freeLookArtical = [[ArticalViewController alloc] init];
        HomePage* data = [_dataSource objectAtIndex:indexPath.section];
        [freeLookArtical setOriginData:data.content];
        [freeLookArtical setTitle:data.title];
        [self.navigationController pushViewController:freeLookArtical  animated:YES];
    }
}

#pragma mark scrollView 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //float num =  scrollView.contentOffset.x / kScreen_Width;
}

- (void)search:(UIBarButtonItem *)sender{
    NSLog(@"搜索");
}


- (void)swipeMenu:(MCSwipeMenu *)menu didSelectAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray* source = menu.dataSource;
    NSString* cate = [[source objectAtIndex:indexPath.item] objectForKey:@"id"];
    
    [self getDramaList:cate page:0];
}


- (void)getDramaList:(NSString*)category page:(NSInteger)page
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    [_dataSource removeAllObjects];
    
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,
                          @"cid":category,
                          @"page":[NSString stringWithFormat:@"%ld", (long)page]};
    
    [_serverManager AnimatedGET:@"get_wiki_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 20010) {
            for(NSDictionary* drama in [responseObject objectForKey:@"data"])
            {
                [_dataSource addObject:[HomePage parseDramaJSON:drama]];
            }
         //   NSLog(@"res%@", responseObject);
            //[_dramaTableView setFrame:CGRectMake(0, 0, kScreen_Width, [HomePageCell cellHeight]*[_dataSource count]-10)];
            self.wikiArtcleTableView.dataSource =_dataSource;
            [_dramaTableView reloadData];
            [_wikiArtcleTableView.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)getDramaCates
{
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken};
    
    [_serverManager AnimatedGET:@"get_wiki_cate.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 20000) {
            [self.head_view setDataSource:responseObject[@"data"]];
            [self.head_view reloadMenu];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - segenment{
- (void)handelSegemnetControl:(UISegmentedControl *)sender{

    if (sender.selectedSegmentIndex == 0) {
        [self.scrollView setContentOffset:CGPointMake(0,0)];
    }else{
           [self.scrollView setContentOffset:CGPointMake(kScreen_Width,0)];
    }
}

#pragma mark 3D touch implementation
- (BOOL)isForceTouchAvailable {
    BOOL isForceTouchAvailable = NO;
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
        isForceTouchAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    }
    return isForceTouchAvailable;
}

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    CGPoint cellPostion = [self.dramaTableView convertPoint:location fromView:self.view];
    NSIndexPath *path = [self.dramaTableView indexPathForRowAtPoint:cellPostion];
    
    ArticalViewController * freeLookArtical = [[ArticalViewController alloc] init];
    HomePage* data = [_dataSource objectAtIndex:path.section];
    [freeLookArtical setOriginData:data.content];
    [freeLookArtical setTitle:data.title];

    return freeLookArtical;
}

-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    
}

@end
