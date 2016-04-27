//
//  PayViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/26.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PayViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, strong) NSArray *title_arr;
@end

@implementation PayViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"%@",self.data_str);
    self.title_arr = @[@"支付宝",@"微信支付"];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"first"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"second"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"third"];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 50;
        }else{
            return 50;
        }
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first" forIndexPath:indexPath];
        UILabel *lab = [cell viewWithTag:1000];
        if (!lab) {
            lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.text = @"支付金额";
            [cell.contentView addSubview:lab];
            lab.tag = 1000;
        }
        UILabel *price_lab = [cell viewWithTag:1001];
        if (!price_lab) {
            price_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin- 100, 0, 100, 50)];
            price_lab.textColor = [UIColor orangeColor];
            price_lab.textAlignment = NSTextAlignmentRight;
            price_lab.text = @"hhhhh";
            [cell.contentView addSubview:price_lab];
            price_lab.tag = 1001;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first" forIndexPath:indexPath];
            UILabel *lab = [cell viewWithTag:10000];
            if (!lab) {
                lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
                lab.textAlignment = NSTextAlignmentLeft;
                lab.text = @"还需支付";
                [cell.contentView addSubview:lab];
                lab.tag = 10000;
            }
            UILabel *price_lab = [cell viewWithTag:10001];
            if (!price_lab) {
                price_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin- 100, 0, 100, 50)];
                price_lab.textColor = [UIColor orangeColor];
                 price_lab.textAlignment = NSTextAlignmentRight;
                price_lab.text = @"hhhhh";
                [cell.contentView addSubview:price_lab];
                price_lab.tag = 10001;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
            UIImageView *pic = [cell viewWithTag:1002];
            if (!pic) {
                pic = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 15, 30, 30)];
                [cell.contentView addSubview:pic];
                pic.backgroundColor = [UIColor redColor];
                pic.tag = 1002;
            }
            UILabel *lab = [cell viewWithTag:1003];
            if (!lab) {
                lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin + 40, 0, 100, 50)];
                lab.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:lab];
                lab.tag = 1003;
            }
            lab.text = self.title_arr[indexPath.row - 1];
            UIImageView *change = [cell viewWithTag:1004];
            if (!change) {
                change = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin- 30, 10, 30, 30)];
                [cell.contentView addSubview:change];
                change.tag = 1004;
            }
            if ([self.payType isEqualToString:@"aliPay"]) {
                if (indexPath.row == 1) {
                    [change setBackgroundColor:[UIColor redColor]];
                }else{
                    [change setBackgroundColor:[UIColor greenColor]];
                }
            }else if ([self.payType isEqualToString:@"weixin"]){
                if (indexPath.row == 2) {
                    [change setBackgroundColor:[UIColor redColor]];
                }else{
                    [change setBackgroundColor:[UIColor greenColor]];
                }
            }else{
                [change setBackgroundColor:[UIColor greenColor]];
            }

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"third" forIndexPath:indexPath];
        UIButton *pay = [cell viewWithTag:1005];
        if (!pay) {
            pay = [UIButton buttonWithType:UIButtonTypeCustom];
            pay.frame = CGRectMake(0, 0, kScreen_Width, 50);
            [pay setTitle:@"确认支付" forState:UIControlStateNormal];
            [pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            pay.backgroundColor = [UIColor grayColor];
            [cell.contentView addSubview:pay];
            pay.tag = 1005;
        }
        if ([self.payType isEqualToString:@"aliPay"]) {
            [pay setBackgroundColor:[UIColor greenColor]];
            [pay setEnabled:YES];
            [pay removeTarget:self action:@selector(weixinPay) forControlEvents:UIControlEventTouchUpInside];
            [pay addTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
            
        }else if ([self.payType isEqualToString:@"weixin"]){
            [pay setBackgroundColor:[UIColor greenColor]];
            [pay setEnabled:YES];
            [pay removeTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
            [pay addTarget:self action:@selector(weixinPay) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [pay setBackgroundColor:[UIColor grayColor]];
            [pay setEnabled:NO];
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            self.payType = @"aliPay";
            [self.tableView reloadData];
        }else if (indexPath.row == 2){
            self.payType = @"weixin";
            [self.tableView reloadData];
        }
    }
}

- (void)weixinPay{
    NSLog(@"weixin");
}

- (void)aliPay{
    NSLog(@"alipay");
}


@end
