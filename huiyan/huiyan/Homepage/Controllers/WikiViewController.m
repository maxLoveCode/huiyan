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
@property (nonatomic, strong) UIScrollView *image_scrollView;
@property (nonatomic, strong) UILabel *line_scrollView;

@end

@implementation WikiViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title  = @"戏曲百科";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(search:)];
}
- (UILabel *)line_scrollView{
    if (_line_scrollView == nil) {
        self.line_scrollView = [[UILabel alloc]initWithFrame:CGRectMake(0, 41, kScreen_Width / kLineNumber, 2)];
        [self.view addSubview:self.line_scrollView];
    }
    return _line_scrollView;
}
- (UIView *)head_view{
    if (_head_view == nil) {
        self.head_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 41)];
        [self.view addSubview:self.head_view];
        for (int i = 0; i < 5; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 100 + i;
            [btn addTarget: self action:@selector(refreshData:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:kTitleColor forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.frame = CGRectMake(kScreen_Width / 5 * i, 0, kScreen_Width / 5, 41);
            [self.head_view addSubview:btn];
        }
        
    }
    return _head_view;
}
- (UIScrollView *)image_scrollView{
    if (_image_scrollView == nil) {
        self.image_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 43, kScreen_Width, 150)];
        self.image_scrollView.delegate = self;
        [self.view addSubview:self.image_scrollView];
        
    }
    return _image_scrollView;
}
- (UITableView *)dramaTableView{
    if (_dramaTableView == nil) {
        self.dramaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,193, kScreen_Width, kScreen_Height - 193)];
        self.dramaTableView.delegate = self;
        self.dramaTableView.dataSource = self;
        [self.dramaTableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"drama"];
        self.dramaTableView.rowHeight = 265 / 2;
        [self.view addSubview:self.dramaTableView];
    }
    return _dramaTableView;
}
#pragma mark tableView代理方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *head_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    head_lab.backgroundColor = kViewBGColor;
    return head_lab;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"drama";
    HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.title_lab.text = @"1111";
   
    return cell;
    
}
#pragma mark scrollView 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float num =  scrollView.contentOffset.x / kScreen_Width;
    [UIView animateWithDuration:0.5 animations:^{
        [self.line_scrollView setFrame:CGRectMake(kScreen_Width / kLineNumber * num, 41, kScreen_Width / kLineNumber, 2)];
    }];
}

- (void)search:(UIBarButtonItem *)sender{
    NSLog(@"搜索");
}



@end
