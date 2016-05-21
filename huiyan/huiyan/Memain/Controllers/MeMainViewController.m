//
//  MeMainViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MeMainViewController.h"
#import "ServerManager.h"
#import "PersonMessage.h"
#import "Constant.h"
#import "PersonHeadCell.h"
#import "PersonNormalCell.h"
#import "MeDramaTicketViewController.h"
#import "BindMobileViewController.h"
#import "UnBindMobileViewController.h"
#import "MeTrainingViewController.h"
#import "SettingTableViewController.h"
#import "PersonInvitationViewController.h"
#import "EditPersonMessageViewController.h"
#import "InterestsTableViewController.h"
@interface MeMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) PersonMessage *perData;
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic, strong) NSArray *image_arr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title_arr = @[@"我的戏票",@"我的培训",@"我的邀约",@"我的钱包",@"我的兴趣",@"绑定手机号",@"设置"];
    self.image_arr = @[@"ticket",@"training",@"training",@"wallet",@"interest",@"phone",@"set"];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    UIColor *color = COLOR_THEME;
    [self.navigationController.navigationBar setBarTintColor:color];
    self.serverManager = [ServerManager sharedInstance];
    [self get_user_infoData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height - 28)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"PersonHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"head"];
        [self.tableView registerNib:[UINib nibWithNibName:@"PersonNormalCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"normal"];
    }
    return _tableView;
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        NSString *type = kOBJECTDEFAULTS(@"login_type");
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 1;
        case 3:
            return 1;
        default:
            if ([type isEqualToString:@"mobile"]) {
                return 1;
            }else{
            return 2;
            }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 199;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 0.01;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PersonHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"head"];
       [cell setContent:self.perData];
        if ([self.perData.sex isEqualToString:@"1"]) {
            cell.sex_pic.image = [UIImage imageNamed:@"male"];
        }else{
            cell.sex_pic.image = [UIImage imageNamed:@"female"];
        }
        [cell.edit_btn addTarget:self action:@selector(editPerson:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
         NSString *type = kOBJECTDEFAULTS(@"login_type");
        PersonNormalCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"normal" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            cell.textLabel.text = self.title_arr[indexPath.row];
            cell.imageView.image = [UIImage imageNamed:self.image_arr[indexPath.row]];
        }else if (indexPath.section == 2){
            cell.textLabel.text = self.title_arr[3];
             cell.imageView.image = [UIImage imageNamed:self.image_arr[3]];
        }else if (indexPath.section == 3){
            cell.textLabel.text = self.title_arr[4];
             cell.imageView.image = [UIImage imageNamed:self.image_arr[4]];
        }else{
            if ([type isEqualToString:@"mobile"]) {
                cell.textLabel.text = self.title_arr[5];
                cell.imageView.image = [UIImage imageNamed:self.image_arr[5]];
                cell.detailTextLabel.text = self.perData.mobile;
            }else{
            cell.textLabel.text = self.title_arr[indexPath.row + 5];
             cell.imageView.image = [UIImage imageNamed:self.image_arr[indexPath.row + 5]];
                if (indexPath.row == 0) {
                    if ([self.perData.mobile isEqualToString:@""] || self.perData.mobile  == nil) {
                         cell.detailTextLabel.text = @"未绑定";
                    }else{
                        UILabel *mobile_lab = [cell viewWithTag:500];
                        if (!mobile_lab) {
                            mobile_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 200, 0, 160, 60)];
                            mobile_lab.font = kFONT14;
                            mobile_lab.textAlignment = NSTextAlignmentRight;
                            [cell.contentView addSubview:mobile_lab];
                            mobile_lab.tag = 500;
                        }
                         mobile_lab.text = self.perData.mobile;
                    }
                   
                }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *type = kOBJECTDEFAULTS(@"login_type");
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MeDramaTicketViewController *meCon = [[MeDramaTicketViewController alloc]init];
            [self.navigationController pushViewController:meCon animated:YES];
        }else if(indexPath.row == 1) {
            MeTrainingViewController *trainCON = [[MeTrainingViewController alloc]init];
            [self.navigationController pushViewController:trainCON animated:NO];
        }else{
            PersonInvitationViewController *invaCon = [[PersonInvitationViewController alloc]init];
            [self.navigationController pushViewController:invaCon animated:YES];
        }
        
    }else if (indexPath.section == 2){
        //wallet
    }else if (indexPath.section == 3){
        InterestsTableViewController* interests = [[InterestsTableViewController alloc] init];
        [self.navigationController pushViewController:interests animated:YES];
    }else if (indexPath.section == 4){
        if ([type isEqualToString:@"mobile"]) {
            
        }else{
            if (indexPath.row == 0) {
                if (self.perData.mobile != nil && ![self.perData.mobile isEqualToString:@""]) {
                    UnBindMobileViewController *bind = [[UnBindMobileViewController alloc]init];
                    bind.mobile = self.perData.mobile;
                    [self.navigationController pushViewController:bind animated:NO];
                }else{
                BindMobileViewController *bind = [[BindMobileViewController alloc]init];
                [self.navigationController pushViewController:bind animated:NO];
                }
            }else{
                SettingTableViewController * settingTable = [[SettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
                [self.navigationController pushViewController:settingTable animated:YES];
            }
        }
        
        
    }else{
        
    }
}

- (void)editPerson:(UIButton *)sender{
    EditPersonMessageViewController *editCon = [[EditPersonMessageViewController alloc]init];
    [self.navigationController pushViewController:editCon animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 请求数据
- (void)get_user_infoData{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    if (user_id) {
        NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id};
        [self.serverManager AnimatedGET:@"get_user_info.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"]integerValue] == 80000) {
                self.perData = [PersonMessage personWithDic:responseObject[@"data"]];
              //  NSLog(@"mobile = %@",self.perData.mobile);
                if (self.perData.mobile == nil || [self.perData.mobile isEqualToString:@""]) {
                    kSETDEFAULTS(@"no", @"mobile");
                }else{
                    kSETDEFAULTS(@"yes", @"mobile");
                }
                [self.tableView reloadData];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
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
