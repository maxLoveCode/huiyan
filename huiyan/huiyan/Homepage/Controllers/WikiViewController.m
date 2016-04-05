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
    [self line_scrollView];
    [self dramaTableView];
    [self image_scrollView];
}
- (UIView *)bg_view{
    if (_bg_view == nil) {
        self.bg_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64)];
        self.bg_view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }
    return _bg_view;
}
- (UILabel *)line_scrollView{
    if (_line_scrollView == nil) {
        self.line_scrollView = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.head_view.frame), kScreen_Width / kLineNumber, 2)];
        self.line_scrollView.backgroundColor = COLOR_WithHex(0xe54863);
        [self.view addSubview:self.line_scrollView];
    }
    return _line_scrollView;
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
- (UIScrollView *)image_scrollView{
    if (_image_scrollView == nil) {
        self.image_scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.line_scrollView.frame), kScreen_Width, 150)];
        self.image_scrollView.delegate = self;
        self.image_scrollView.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:self.image_scrollView];
        
    }
    return _image_scrollView;
}
- (UITableView *)dramaTableView{
    if (_dramaTableView == nil) {
        self.dramaTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.image_scrollView.frame), kScreen_Width, kScreen_Height - 193)];
        self.dramaTableView.delegate = self;
        self.dramaTableView.dataSource = self;
        [self.dramaTableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"drama"];
        self.dramaTableView.rowHeight = 265 / 2;
        [self.view addSubview:self.dramaTableView];
    }
    return _dramaTableView;
}
#pragma mark tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *head_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    head_view.backgroundColor = COLOR_WithHex(0xefefef);
    UILabel *up_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
    up_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    [head_view addSubview:up_lab];
    UILabel *down_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, kScreen_Width, 0.5)];
     down_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    [head_view addSubview:down_lab];
    
    
    return  head_view;

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

- (void)refreshData:(UIButton *)sender{
    if (sender.tag == 104) {
//        [self.head_view removeFromSuperview];
//        for (int i = 0; i < 7; i++) {
//            UIButton btn
//        }
    }
}

@end
