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
#define kLineNumber 3

@interface WikiViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *dramaTableView;
@property (nonatomic, strong) MCSwipeMenu* head_view;
@property (nonatomic, strong) UIView *bg_view;
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
    [self.view addSubview:self.head_view];
    NSLog(@"%@",_head_view);
    [self.view addSubview:self.dramaTableView];
}

- (UIView *)head_view{
    if (!_head_view) {
        _head_view = [[MCSwipeMenu alloc] init];
    }
    return _head_view;
}

- (UITableView *)dramaTableView{
    if (_dramaTableView == nil) {
        self.dramaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.head_view.frame), kScreen_Width, kScreen_Height - 193)];
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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"drama";
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
    
}
#pragma mark scrollView 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float num =  scrollView.contentOffset.x / kScreen_Width;
}

- (void)search:(UIBarButtonItem *)sender{
    NSLog(@"搜索");
}

- (void)refreshData:(UIButton *)sender{
    if (sender.tag == 104) {

    }
}

@end
