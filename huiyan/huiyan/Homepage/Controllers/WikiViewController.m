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
#define kLineNumber 3
@interface WikiViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *dramaTableView;
@property (nonatomic, strong) UIView* head_view;
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
    [self head_view];
    [self dramaTableView];
}

- (UIView *)head_view{
    if (_head_view == nil) {
        self.head_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 41)];

        for (int i = 0; i < 5; i++) {
            NSArray *title = @[@"全部",@"京剧",@"昆剧",@"豫剧",@"黄梅⬇️"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 100 + i;
            btn.titleLabel.font = kFONT12;
            [btn addTarget: self action:@selector(refreshData:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:title[i] forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_WithHex(0x666666) forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.frame = CGRectMake(kScreen_Width / 5 * i, 0, kScreen_Width / 5, 41);
            [self.head_view addSubview:btn];
        }
         [self.view addSubview:self.head_view];
        
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
        [self.view addSubview:self.dramaTableView];
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
