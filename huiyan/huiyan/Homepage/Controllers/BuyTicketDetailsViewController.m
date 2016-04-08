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
@interface BuyTicketDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *ticketTableView;
@end

@implementation BuyTicketDetailsViewController

- (void)viewDidLoad{
    NSLog(@"%@",self.ticket);
    [super viewDidLoad];
    self.title = @"购票详情";
    
    [self.view addSubview:self.ticketTableView];
}

- (UITableView *)ticketTableView{
    if (!_ticketTableView) {
        self.ticketTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 48 - 10) style:UITableViewStyleGrouped];
        self.ticketTableView.delegate = self;
        self.ticketTableView.dataSource = self;
        [self.ticketTableView registerClass:[BuyTicketDetailsTableViewCell class] forCellReuseIdentifier:@"ticket"];
        [self.ticketTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalcell"];
    }
    return _ticketTableView;
}


#pragma mark - tabelViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
      return  [BuyTicketDetailsTableViewCell cellHeight];
    }else if(indexPath.section == 1){
        return 100;
    }else if(indexPath.section == 2){
        return 100;
    }else{
        return 80;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section == 0) {
    BuyTicketDetailsTableViewCell *bt_cell
        = [tableView dequeueReusableCellWithIdentifier:@"ticket" forIndexPath:indexPath];
        [bt_cell.contentView  setBackgroundColor:[UIColor yellowColor]];
    [bt_cell setContent:self.ticket];
        return bt_cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
        UILabel *content_lab = [cell viewWithTag:1000];
        if (!content_lab) {
            content_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width - 30, 12)];
            content_lab.font = kFONT12;
            content_lab.textColor = COLOR_WithHex(0x565656);
            [cell addSubview:content_lab];
            content_lab.tag = 1000;
            content_lab.text = self.ticket.content;
        }
        return cell;
    }else if (indexPath.section == 2){
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
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalcell" forIndexPath:indexPath];
        UILabel *name_lab = [cell viewWithTag:1002];
        if (!name_lab) {
            name_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreen_Width - 30, 12 * 1.5)];
            name_lab.font = kFONT12;
            name_lab.textColor = COLOR_WithHex(0xa5a5a5);
            [cell addSubview:name_lab];
            name_lab.tag = 1002;
        }
        UILabel *comment_lab = [cell viewWithTag:1003];
        if (!comment_lab) {
            comment_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(name_lab.frame), kScreen_Width - 30, 60)];
            comment_lab.font = kFONT12;
            comment_lab.textColor = COLOR_WithHex(0x565656);
            [cell addSubview:comment_lab];
            comment_lab.tag = 1003;
        }

        UILabel *time_lab = [cell viewWithTag:1004];
        if (!time_lab) {
            time_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(comment_lab.frame) + 5, kScreen_Width - 30, 12)];
            time_lab.font = kFONT11;
            time_lab.textColor = COLOR_WithHex(0xa5a5a5);
            [cell addSubview:time_lab];
            time_lab.tag = 1004;
        }
        return cell;
    }
}
@end
