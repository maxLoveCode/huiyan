//
//  InvitationDetailViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/31.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "InvitationDetailViewController.h"
#import "ServerManager.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"

#define kHeadHeight 180
#define kRowHeight 50
@interface InvitationDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *headLab;
@property (nonatomic, strong) NSArray *titlArr;
@property (nonatomic, strong) NSArray *contentArr;
@end

@implementation InvitationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationController.navigationBar.translucent = NO;
    self.titlArr = @[@"演出日期",@"联 系 人",@"联系电话",@"演出内容"];
    self.contentArr = @[self.invitation.date,self.invitation.name,self.invitation.phone,self.invitation.content];
    [self.view addSubview:self.headLab];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (UILabel *)headLab{
    if (!_headLab) {
        self.headLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreen_Width - 30, 50)];
        self.headLab.numberOfLines = 0;
        self.headLab.textColor  = COLOR_THEME;
        self.headLab.text = @"邀约发起后,客服人员将在3-5个工作日内与您联系.";
        self.headLab.font = kFONT14;
    }
    return _headLab;
}

- (UITableView *)tableView{
    if (!_tableView ) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 50, kScreen_Width - 30, kHeadHeight +kRowHeight * 4)];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"head"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tail"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark -- tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kHeadHeight;
    }else{
        return kRowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"head"];
        UIImageView *imagePic = [cell viewWithTag:1000];
        if (!imagePic) {
            imagePic = [[UIImageView alloc]initWithFrame:CGRectMake((kScreen_Width - 30)/ 2 - 40, 30, 80, 80)];
            imagePic.layer.masksToBounds = YES;
            imagePic.layer.cornerRadius = 40;
            [cell.contentView addSubview:imagePic];
            imagePic.tag = 1000;
        }
        [imagePic sd_setImageWithURL:[NSURL URLWithString:self.invitation.avatar]];
        UILabel *nameLab = [cell viewWithTag:1002];
        if (!nameLab) {
            nameLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreen_Width - 30) / 2 - 40, CGRectGetMaxY(imagePic.frame), 80, 40)];
            nameLab.font = kFONT16;
            nameLab.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:nameLab];
            nameLab.tag = 1002;
        }
        nameLab.text = self.invitation.nickname;
        UILabel *lineLab = [cell viewWithTag:1004];
        if (!lineLab) {
            lineLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(nameLab.frame) + 20, kScreen_Width - 60, 0.5)];
            lineLab.backgroundColor = COLOR_WithHex(0xdddddd);
            [cell.contentView addSubview:lineLab];
            lineLab.tag = 1004;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tail"];
        UILabel *titleLab = [cell viewWithTag:1008];
        if (!titleLab) {
            titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
            titleLab.textColor = COLOR_WithHex(0xa5a5a5);
            titleLab.font = kFONT15;
            titleLab.textAlignment = NSTextAlignmentLeft;
            [cell.contentView addSubview:titleLab];
            titleLab.tag = 1008;
        }
        titleLab.text = self.titlArr[indexPath.row];
        UILabel *contentLab = [cell viewWithTag:1010];
        if (!contentLab) {
            contentLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame) + 20, 0, kScreen_Width - 180, 50)];
            contentLab.numberOfLines = 0;
            contentLab.font = kFONT15;
            [cell.contentView addSubview:contentLab];
            contentLab.tag = 1010;
        }
        contentLab.text = self.contentArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
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
