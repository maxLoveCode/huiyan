//
//  BuyTicketDetailsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "BuyTicketDetailsViewController.h"
#import "BuyTicketDetailsTableViewCell.h"
#import "Constant.h"
#import "ServerManager.h"
#import "CommentContent.h"
#import "UITabBarController+ShowHideBar.h"
#import "TicketCommentTableViewCell.h"
#import "MoreCommentTableViewController.h"
#import "MoreDetailsTableViewCell.h"
@interface BuyTicketDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *ticketTableView;
@property (nonatomic, strong) NSArray *head_title_arr;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UIButton *head_btn;
@property (nonatomic, strong) UIButton *tail_btn;
@end

@implementation BuyTicketDetailsViewController

- (void)viewDidLoad{
   // NSLog(@"%@",self.ticket);
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor yellowColor];

    self.view.userInteractionEnabled = YES;
    self.title = @"购票详情";
    self.head_title_arr = @[@"节目详情",@"购买需知",@"戏友点评"];
    [self.view addSubview:self.head_btn];
    [self.view addSubview:self.tail_btn];
    [self.view addSubview:self.ticketTableView];
       NSLog(@"1111%@ ---2222%@ ---3333 %@ --- 444%@",self.view,self.head_btn,self.tail_btn,self.ticketTableView);
    _serverManager = [ServerManager sharedInstance];
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self get_opera_commentData];
    [self.tabBarController setHidden:YES];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UITableView *)ticketTableView{
    if (!_ticketTableView) {
        self.ticketTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 48  - 64 ) style:UITableViewStyleGrouped];
        self.ticketTableView.delegate = self;
        self.ticketTableView.dataSource = self;
        [self.ticketTableView registerClass:[BuyTicketDetailsTableViewCell class] forCellReuseIdentifier:@"ticket"];
        self.ticketTableView.backgroundColor = [UIColor whiteColor];
        [self.ticketTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalcell"];
        [self.ticketTableView registerClass:[TicketCommentTableViewCell class] forCellReuseIdentifier:@"comment"];
        [self.ticketTableView registerClass:[MoreDetailsTableViewCell class] forCellReuseIdentifier:@"moreDetail"];
    }
    return _ticketTableView;
}


- (UIButton *)head_btn{
    if (!_head_btn) {
        self.head_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.head_btn.frame = CGRectMake(0, CGRectGetMaxY(self.ticketTableView.frame), 48, 48);
        self.head_btn.backgroundColor = [UIColor redColor];
        self.head_btn.userInteractionEnabled = YES;
        [self.head_btn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _head_btn;
}

- (UIButton *)tail_btn{
    if (!_tail_btn) {
        self.tail_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _tail_btn.backgroundColor = COLOR_THEME;
        [_tail_btn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_tail_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _tail_btn.frame = CGRectMake(48, CGRectGetMaxY(self.ticketTableView.frame), kScreen_Width - 48, 48);
        [_tail_btn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tail_btn;
}

#pragma mark - tabelViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 3){
        return self.dataSource.count + 1;
    }else{
        return 2;
    }
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
           return  0.01;
            break;
        case 1:
            return 32;
            break;
        case 2:
            return 32;
            break;
        case 3:
            return 32;
            break;
        default:
            return 0.01;
            break;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
      return  [BuyTicketDetailsTableViewCell cellHeight];
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return 100;
        }
        return 32;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            return 100;
        }
        return 32;
    }else{
        if (indexPath.section == 3 && indexPath.row < self.dataSource.count) {
            return 70;
        }
            return 32;

    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 32)];
        [headerView setBackgroundColor:[UIColor whiteColor]];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin * 2, 10, 60, 12)];
        label.text = self.head_title_arr[section - 1];
        label.font = kFONT12;
        [headerView addSubview:label];
        UILabel *color_label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 10, 5, 15)];
        color_label.layer.masksToBounds = YES;
        color_label.layer.cornerRadius = 3;
        color_label.backgroundColor = COLOR_THEME;
        
        [headerView addSubview:color_label];
        
        return headerView;

    }
    
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *head_view = [[UIView alloc]init];
    head_view.backgroundColor = COLOR_WithHex(0xefefef);
    UILabel *up_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
    up_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    [head_view addSubview:up_lab];
    UILabel *down_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, kScreen_Width, 0.5)];
    down_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    [head_view addSubview:down_lab];
    return head_view;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
    BuyTicketDetailsTableViewCell *bt_cell
        = [tableView dequeueReusableCellWithIdentifier:@"ticket" forIndexPath:indexPath];
           bt_cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [bt_cell.contentView  setBackgroundColor:[UIColor yellowColor]];
    [bt_cell setContent:self.ticket];
        return bt_cell;
    }else if(indexPath.section == 1){

        if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
            UILabel *content_lab = [cell viewWithTag:1000];
            if (!content_lab) {
                content_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width - 30, 50)];
                content_lab.font = kFONT12;
                content_lab.textColor = COLOR_WithHex(0x565656);
                [cell addSubview:content_lab];
                content_lab.tag = 1000;
                content_lab.numberOfLines = 0;
                content_lab.text = self.ticket.content;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }else{
            MoreDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreDetail" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
       
    }else if (indexPath.section == 2){
        if(indexPath.row == 0){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
            UILabel *buy_tip_lab = [cell viewWithTag:1001];
            if (!buy_tip_lab) {
                buy_tip_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width - 30, 12)];
                buy_tip_lab.font = kFONT12;
                buy_tip_lab.textColor = COLOR_WithHex(0x565656);
                buy_tip_lab.text = self.ticket.buy_tip;
                [cell addSubview:buy_tip_lab];
                buy_tip_lab.tag = 1001;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            MoreDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreDetail" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else{
        if (indexPath.row < self.dataSource.count) {
            CommentContent *model = self.dataSource[indexPath.row];
            TicketCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
            [cell setContent:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }else{
        MoreDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moreDetail" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 1) {
        
    }else if (indexPath.section == 2 && indexPath.row == 1){
        
    }else if (indexPath.section == 3 && indexPath.row == self.dataSource.count){
        MoreCommentTableViewController *moreCon = [[MoreCommentTableViewController alloc]init];
        moreCon.oid = self.ticket.ID;
            [self.navigationController pushViewController:moreCon animated:YES];
    }else{
        
    }
}

- (void)get_opera_commentData{
    self.dataSource = [[NSMutableArray alloc]init];
    NSDictionary *parameters = @{@"access_token":_serverManager.accessToken, @"oid":self.ticket.ID,@"page":@"0"};
    [_serverManager AnimatedPOST:@"get_opera_comment.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 30020) {
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                CommentContent *model = [CommentContent dataWithDic:dic];
                [self.dataSource addObject:model];
            }
         //   NSLog(@"%@",self.dataSource);
            [self.ticketTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - tailEvent
- (void)callPhone:(UIButton *)sender{
    NSLog(@"call");
}

- (void)buy{
    NSLog(@"buy");
}

@end
