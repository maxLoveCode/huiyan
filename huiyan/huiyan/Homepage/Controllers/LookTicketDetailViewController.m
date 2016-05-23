//
//  LookTicketDetailViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "LookTicketDetailViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import "LookTicketCell.h"
@interface LookTicketDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UITableView *mainTableView;
@end
@implementation LookTicketDetailViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainTableView];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 56, 44)];
    [backItem setImage:[UIImage imageNamed:@"back_arrow"] forState:UIControlStateNormal];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitle:@"返回" forState:UIControlStateNormal];
    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backItem];
    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = leftItemBar;

    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
    //[self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.mainTableView registerClass:[LookTicketCell class] forCellReuseIdentifier:@"one"];
        [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"two"];
        [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"three"];
        [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"four"];
        
    }
    return _mainTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 340;
    }else if (indexPath.section == 1){
        return 70;
    }else if (indexPath.section == 2){
        return 130;
    }else{
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 10;
    }
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LookTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one" forIndexPath:indexPath];
        [cell setContent:self.payData];
        [cell setBackgroundColor:COLOR_WithHex(0xf5f5f5)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"two" forIndexPath:indexPath];
        UILabel *name_lab = [cell viewWithTag:1000];
        if (!name_lab) {
            name_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, 100, 16)];
            name_lab.font = kFONT16;
            name_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:name_lab];
            name_lab.tag = 1000;
        }
        name_lab.text = self.payData.theater_name;
        UILabel *add_lab = [cell viewWithTag:1002];
        if (!add_lab) {
            add_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 45, 200, 14)];
            add_lab.textColor = COLOR_THEME;
            add_lab.font = kFONT14;
            add_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:add_lab];
            add_lab.tag = 1002;
        }
        add_lab.text = self.payData.theater_addr;
        UILabel *line_lab = [cell viewWithTag:1004];
        if (!line_lab) {
            line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin - 50 - 1, 5, 1, 35)];
            line_lab.textColor = COLOR_WithHex(0xdddddd);
            [cell.contentView addSubview:line_lab];
            line_lab.tag = 1004;
        }
        UIButton *call_btn = [cell viewWithTag:1006];
        if (!call_btn) {
            call_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            call_btn.frame = CGRectMake(kScreen_Width - kMargin - 49, 10, 50, 50);
              [call_btn setImage:[UIImage imageNamed:@"finish_detail_phone"] forState:UIControlStateNormal];
            [cell.contentView addSubview:call_btn];
            call_btn.tag = 1006;
        }
        [call_btn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three" forIndexPath:indexPath];
        UILabel *name_lab = [cell viewWithTag:1008];
        if (!name_lab) {
            name_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, 150, 20)];
            name_lab.font = kFONT16;
            name_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:name_lab];
            name_lab.tag = 1008;
        }
        name_lab.text = @"实付金额";
        
        UILabel *price_lab = [cell viewWithTag:1010];
        if (!price_lab) {
            price_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin - 150, 10, 150, 20)];
            price_lab.font = kFONT16;
            price_lab.textAlignment = NSTextAlignmentRight;
            price_lab.textColor = COLOR_THEME;
            [cell.contentView addSubview:price_lab];
            price_lab.tag = 1010;
        }
        price_lab.text = [NSString stringWithFormat:@"%@元(%@张)",self.payData.pay_price,self.payData.pay_num];
        
        UILabel *codeNum_lab = [cell viewWithTag:1012];
        if (!codeNum_lab) {
            codeNum_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 40, 300, 20)];
            codeNum_lab.font = kFONT14;
            codeNum_lab.textColor = COLOR_WithHex(0xa5a5a5);
            codeNum_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:codeNum_lab];
            codeNum_lab.tag = 1012;
        }
        codeNum_lab.text = [NSString stringWithFormat:@"订单编号  %@",self.payData.code_num];
        
        UILabel *time_lab = [cell viewWithTag:1014];
        if (!time_lab) {
            time_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 70, 200, 20)];
            time_lab.font = kFONT14;
             time_lab.textColor = COLOR_WithHex(0xa5a5a5);
            time_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:time_lab];
            time_lab.tag = 1014;
        }
        time_lab.text = [NSString stringWithFormat:@"购买时间  %@",self.payData.opera_date];
        
        UILabel *offer_lab = [cell viewWithTag:1016];
        if (!offer_lab) {
            offer_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 100, 150, 20)];
            offer_lab.font = kFONT14;
             offer_lab.textColor = COLOR_WithHex(0xa5a5a5);
            offer_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:offer_lab];
            offer_lab.tag = 1016;
        }
        offer_lab.text = [NSString stringWithFormat:@"戏票由%@提供",self.payData.theater_name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"four" forIndexPath:indexPath];
        UILabel *title_lab = [cell viewWithTag:1018];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
            title_lab.font = kFONT16;
            title_lab.textColor = [UIColor blackColor];
            title_lab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:title_lab];
            title_lab.tag = 1018;
        }
        title_lab.text = @"汇演客服电话";
        
        UILabel *phone_lab = [cell viewWithTag:1020];
        if (!phone_lab) {
            phone_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin - 200, 0, 200, 50)];
            phone_lab.font = kFONT14;
            phone_lab.textColor = COLOR_THEME;
            phone_lab.textAlignment = NSTextAlignmentRight;
            cell.contentView.userInteractionEnabled = YES;
            phone_lab.userInteractionEnabled = YES;
            [cell.contentView addSubview:phone_lab];
            phone_lab.tag = 1020;
        }
       
        phone_lab.text = self.payData.kefu_tel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        //客服电话
        NSLog(@"22");
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.payData.kefu_tel];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
}

//剧院电话
- (void)callPhone:(UIButton *)sender{
    NSLog(@"11");
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.payData.theater_tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}

- (void)clickedCloseItem:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:NO];
}


@end
