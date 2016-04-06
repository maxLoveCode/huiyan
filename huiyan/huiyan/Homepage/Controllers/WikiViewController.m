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

#define kLineNumber 3

@interface WikiViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *dramaTableView;
@property (nonatomic, strong) MCSwipeMenu* head_view;
@property (nonatomic, strong) UIView *bg_view;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) ServerManager* serverManager;

@end

@implementation WikiViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title  = @"戏曲百科";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(search:)];
    [self.view setBackgroundColor:COLOR_WithHex(0xefefef)];
    [self.view addSubview:self.head_view];
    NSLog(@"%@",_head_view);
    [self.view addSubview:self.dramaTableView];
    
    _serverManager = [ServerManager sharedInstance];
    [self getDramaList:@"0"];
}

- (UIView *)head_view{
    if (!_head_view) {
        _head_view = [[MCSwipeMenu alloc] init];
    }
    return _head_view;
}

- (UITableView *)dramaTableView{
    if (_dramaTableView == nil) {
        self.dramaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.head_view.frame)+10, kScreen_Width, kScreen_Height - 163)];
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
#pragma mark scrollView 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //float num =  scrollView.contentOffset.x / kScreen_Width;
}

- (void)search:(UIBarButtonItem *)sender{
    NSLog(@"搜索");
}

- (void)refreshData:(UIButton *)sender{
    if (sender.tag == 104) {

    }
}

- (void)getDramaList:(NSString*)category
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,
                          @"cid":@"0"};
    
    [_serverManager AnimatedPOST:@"get_wiki_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"code"] integerValue] == 20010) {
            for(NSDictionary* drama in [responseObject objectForKey:@"data"])
            {
                [_dataSource addObject:[HomePage parseDramaJSON:drama]];
            }
            
            //[_dramaTableView setFrame:CGRectMake(0, 0, kScreen_Width, [HomePageCell cellHeight]*[_dataSource count]-10)];
            [_dramaTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
