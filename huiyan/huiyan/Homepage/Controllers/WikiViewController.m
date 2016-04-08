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

#import "ArticalViewController.h"

#define kLineNumber 3

@interface WikiViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MCSwipeMenuDelegate>
@property (nonatomic, strong) UITableView *dramaTableView;
@property (nonatomic, strong) MCSwipeMenu* head_view;
@property (nonatomic, strong) UIView *bg_view;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) ServerManager* serverManager;
@property (nonatomic, strong) UISegmentedControl *segement;
@property (nonatomic, strong) WikiArtcleTableViewController *wikiArtcleTableView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WikiViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

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
    [self getDramaList:@"0"];
}

- (UIView *)head_view{
    if (!_head_view) {
        _head_view = [[MCSwipeMenu alloc] init];
    }
    return _head_view;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,41 , kScreen_Width, kScreen_Height - 41 - 48)];
        _scrollView.contentSize = CGSizeMake(kScreen_Width * 2, kScreen_Height - 41 - 48);
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = NO;
        _scrollView.backgroundColor = COLOR_WithHex(0xefefef);
    }
    return _scrollView;
}

- (UISegmentedControl *)segement{
    if (!_segement) {
        self.segement = [[UISegmentedControl alloc]initWithItems:@[@"文章",@"作品"]];
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
        self.dramaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,10, kScreen_Width, kScreen_Height - 41- 48 - 74)];
        self.dramaTableView.delegate = self;
        self.dramaTableView.dataSource = self;
        [self.dramaTableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"drama"];
        self.dramaTableView.rowHeight = [HomePageCell cellHeight];
        self.dramaTableView.separatorStyle = NO;
    }
    return _dramaTableView;
}
#pragma mark tableView代理方法


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"drama";
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    [cell setContent:[_dataSource objectAtIndex:indexPath.row]];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _dramaTableView) {
        ArticalViewController * freeLookArtical = [[ArticalViewController alloc] init];
        HomePage* data = [_dataSource objectAtIndex:indexPath.row];
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
   
}

- (void)getDramaList:(NSString*)category
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,
                          @"cid":@"0"};
    
    [_serverManager AnimatedPOST:@"get_wiki_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 20010) {
            for(NSDictionary* drama in [responseObject objectForKey:@"data"])
            {
                [_dataSource addObject:[HomePage parseDramaJSON:drama]];
            }
            
            //[_dramaTableView setFrame:CGRectMake(0, 0, kScreen_Width, [HomePageCell cellHeight]*[_dataSource count]-10)];
            self.wikiArtcleTableView.dataSource =_dataSource;
            [_dramaTableView reloadData];
            [_wikiArtcleTableView.tableView reloadData];
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

@end
