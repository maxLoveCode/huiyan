//
//  ExploreViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ExploreViewController.h"
#import "FindTableViewCell.h"
#import "Constant.h"

@interface ExploreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}


- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 48) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 60;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[FindTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

#pragma mark - tableViewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
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
