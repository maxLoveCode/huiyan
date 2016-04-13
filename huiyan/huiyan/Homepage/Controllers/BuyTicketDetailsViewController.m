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
@interface BuyTicketDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *ticketTableView;
@property (nonatomic, strong) NSArray *head_title_arr;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UIView *tail_view;
@end

@implementation BuyTicketDetailsViewController

- (void)viewDidLoad{
    NSLog(@"%@",self.ticket);
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购票详情";
    self.head_title_arr = @[@"节目详情",@"购买需知",@"戏友点评"];
    [self.view addSubview:self.tail_view];
    [self.view addSubview:self.ticketTableView];
    _serverManager = [ServerManager sharedInstance];
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self get_opera_commentData];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (UITableView *)ticketTableView{
    if (!_ticketTableView) {
        self.ticketTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 48 - 10 - 64 ) style:UITableViewStyleGrouped];
        self.ticketTableView.delegate = self;
        self.ticketTableView.dataSource = self;
        [self.ticketTableView registerClass:[BuyTicketDetailsTableViewCell class] forCellReuseIdentifier:@"ticket"];
        [self.ticketTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalcell"];
    }
    return _ticketTableView;
}

- (UIView *)tail_view{
    if (!_tail_view) {
        self.tail_view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height - 48 - 64, kScreen_Width, 48)];
        //self.tail_view.backgroundColor = [UIColor whiteColor];
        UIButton *head_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        head_btn.frame = CGRectMake(0, 0, 48, 48);
        [head_btn addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
        [self.tail_view addSubview:head_btn];
        
        UIButton *tail_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        tail_btn.backgroundColor = COLOR_THEME;
        [tail_btn setTitle:@"立即购买" forState:UIControlStateNormal];
        [tail_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tail_btn.frame = CGRectMake(48, 0, kScreen_Width - 48, 48);
        [tail_btn addTarget:self action:@selector(buyEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.tail_view addSubview:tail_btn];
        
    }
    return _tail_view;
}

#pragma mark - tabelViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 3){
        return self.dataSource.count;
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
        if (indexPath.row == 0) {
            return 110           ;
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
    BuyTicketDetailsTableViewCell *bt_cell
        = [tableView dequeueReusableCellWithIdentifier:@"ticket" forIndexPath:indexPath];
           bt_cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [bt_cell.contentView  setBackgroundColor:[UIColor yellowColor]];
    [bt_cell setContent:self.ticket];
        return bt_cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            UILabel *content_lab = [cell viewWithTag:1000];
            if (!content_lab) {
                content_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width - 30, 12)];
                content_lab.font = kFONT12;
                content_lab.textColor = COLOR_WithHex(0x565656);
                [cell addSubview:content_lab];
                content_lab.tag = 1000;
                content_lab.text = self.ticket.content;
            }
            
        }else{
       cell.textLabel.text = @"查看更多详情";
            cell.textLabel.font = kFONT12;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
       
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
        if(indexPath.row == 0){
            UILabel *buy_tip_lab = [cell viewWithTag:1001];
            if (!buy_tip_lab) {
                buy_tip_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width - 30, 12)];
                buy_tip_lab.font = kFONT12;
                buy_tip_lab.textColor = COLOR_WithHex(0x565656);
                buy_tip_lab.text = self.ticket.buy_tip;
                [cell addSubview:buy_tip_lab];
                buy_tip_lab.tag = 1001;
            }
        }else{
            cell.textLabel.text = @"查看更多详情";
            cell.textLabel.font = kFONT12;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
        NSLog(@"%ld",(long)indexPath.row); 
        CommentContent *model = self.dataSource[indexPath.row];
        if (indexPath.row == 0) {
            UILabel *name_lab = [cell viewWithTag:1002];
            if (!name_lab) {
                name_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width - 30, 12 * 1.5)];
                name_lab.font = kFONT12;
                name_lab.textColor = COLOR_WithHex(0xa5a5a5);
                [cell addSubview:name_lab];
                name_lab.tag = 1002;
                name_lab.text = model.user_name;
            }
            UILabel *comment_lab = [cell viewWithTag:1003];
            if (!comment_lab) {
                comment_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(name_lab.frame), kScreen_Width - 30, 60)];
                comment_lab.font = kFONT12;
                comment_lab.textColor = COLOR_WithHex(0x565656);
                [cell addSubview:comment_lab];
                comment_lab.tag = 1003;
                comment_lab.text = model.content;
            }
            
            UILabel *time_lab = [cell viewWithTag:1004];
            if (!time_lab) {
                time_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(comment_lab.frame) + 5, kScreen_Width - 30, 12)];
                time_lab.font = kFONT11;
                time_lab.textColor = COLOR_WithHex(0xa5a5a5);
                [cell addSubview:time_lab];
                time_lab.tag = 1004;
                time_lab.text = model.createtime;
            }

        }else{
            cell.textLabel.text = @"查看更多详情";
            cell.textLabel.font = kFONT12;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
    }
}

- (void)get_opera_commentData{
    self.dataSource = [[NSMutableArray alloc]init];
    NSDictionary *parameters = @{@"access_token":_serverManager.accessToken, @"oid":self.ticket.ID};
    [_serverManager AnimatedPOST:@"get_opera_comment.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 30020) {
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                CommentContent *model = [CommentContent dataWithDic:dic];
                [self.dataSource addObject:model];
            }
            NSLog(@"%@",self.dataSource);
            [self.ticketTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - tailEvent
- (void)callPhone:(UIButton *)sender{
    
}

- (void)buyEvent:(UIButton *)sender{
    
}

@end
