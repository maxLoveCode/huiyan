//
//  DramaTicketDetailTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/27.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaTicketDetailTableViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"

@interface DramaTicketDetailTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation DramaTicketDetailTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"戏票详情";
    [self.view addSubview:self.tableView];
   
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"one"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"two"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"third"];
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}



#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 170;
    }else if (indexPath.section == 1){
        return 150;
    }else{
        return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one" forIndexPath:indexPath];
        UIImageView  *image_pic = [cell viewWithTag:1000];
        if (!image_pic) {
            image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 50, 25, 100, 100)];
            image_pic.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:image_pic];
            image_pic.tag = 1000;
        }
        UILabel *lab = [cell viewWithTag:1002];
        if (!lab) {
            lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(image_pic.frame), CGRectGetMaxY(image_pic.frame) + 5, 100, 16)];
            lab.text = @"购票成功";
            lab.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:lab];
            lab.tag = 1002;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 1){
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
        UILabel *title_lab = [cell viewWithTag:1004];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 2 *  kMargin, 32 * 1.5)];
          //  title_lab.backgroundColor = [UIColor redColor];
            title_lab.numberOfLines = 2;
            title_lab.font = kFONT16;
            title_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:title_lab];
            title_lab.tag = 1004;
        }
        title_lab.text = self.data_dic[@"title"];
        UILabel *time_lab= [cell viewWithTag:1006];
        if (!time_lab) {
            time_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(title_lab.frame), kScreen_Width - 2 * kMargin, 14 * 1.5)];
            time_lab.textColor = COLOR_THEME;
            time_lab.textAlignment = NSTextAlignmentLeft;
          //  time_lab.backgroundColor = [UIColor blueColor];
            [cell.contentView addSubview:time_lab];
             time_lab.font = kFONT14;
            time_lab.tag = 1006;
        }
        time_lab.text = self.data_dic[@"date"];
        UILabel *site_lab = [cell viewWithTag:1008];
        if (!site_lab) {
            site_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(time_lab.frame) + 5, kScreen_Width - 2 * kMargin, 14 * 1.5)];
           // site_lab.backgroundColor = [UIColor yellowColor];
             site_lab.font = kFONT14;
            site_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:site_lab];
            site_lab.tag = 1008;
        }
        site_lab.text = self.data_dic[@"theatre"];
        UILabel *seat_lab = [cell viewWithTag:1010];
        if (!seat_lab) {
            seat_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(site_lab.frame) + 5, kScreen_Width - 2 * kMargin, 14 * 1.5)];
          //  seat_lab.backgroundColor = [UIColor blackColor];
            seat_lab.textAlignment = NSTextAlignmentLeft;
            seat_lab.font = kFONT14;
            [cell.contentView addSubview:seat_lab];
            seat_lab.tag = 1010;
        }
        seat_lab.text = self.data_dic[@"tickets"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"third" forIndexPath:indexPath];
        UIButton *look_btn = [cell viewWithTag:1012];
        if (!look_btn) {
            look_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            look_btn.frame = CGRectMake(kMargin, 20, kScreen_Width - 2 * kMargin, 50);
            look_btn.layer.masksToBounds = YES;
            look_btn.layer.cornerRadius = 5;
            look_btn.backgroundColor = COLOR_THEME;
            [look_btn setTitle:@"查看戏票" forState:UIControlStateNormal];
            [look_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [look_btn addTarget:self action:@selector(lookDramaTicket:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:look_btn];
            look_btn.tag  = 1012;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
}

- (void)lookDramaTicket:(UIButton *)sender
{
    NSLog(@"111");
}

@end