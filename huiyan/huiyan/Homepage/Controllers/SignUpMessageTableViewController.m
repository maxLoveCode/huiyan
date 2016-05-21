//
//  SignUpMessageTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "SignUpMessageTableViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "SignUpCell.h"
#import "WriteSignUpCell.h"
#import "ImportantNotesCell.h"
#import "Constant.h"
#import "TrainOrdersTableViewController.h"
#import "TrainPayViewController.h"
#import "ServerManager.h"
#import "Tools.h"
@interface SignUpMessageTableViewController ()
@property (nonatomic, strong) UITextField *name_textFied;
@property (nonatomic, strong) UITextField *mobile_textField;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSDictionary *order_dic;
@end

@implementation SignUpMessageTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"报名信息";
    [self.view addSubview:self.tableView];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoverKeyBorad:)];
    tapGes.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGes];
    self.serverManager = [ServerManager sharedInstance];
      
   
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreen_Width, kScreen_Height)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"SignUp" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"one"];
        [self.tableView registerNib:[UINib nibWithNibName:@"WriteSignUpCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"two"];
        [self.tableView registerNib:[UINib nibWithNibName:@"ImportantNotesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"three"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.userInteractionEnabled = YES;
    }
    return _tableView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}
#pragma mark -- tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 154;
    }else if (indexPath.section == 1){
        return 245;
    }else{
        return 235;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section!= 2) {
         return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
        cell.title_lab.text = self.train.title;
        cell.time_lab.text = self.train.date;
        cell.address_lab.text = self.train.address;
        cell.price_lab.text = self.train.price;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        WriteSignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:@"two"];
        self.name_textFied = cell.name_textField;;
        self.mobile_textField = cell.mobile_textField;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ImportantNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"three"];
        [cell.sure_btn addTarget:self action:@selector(sureOrders:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}



- (void)sureOrders:(UIButton *)sender{
    
    if ([self.name_textFied.text isEqualToString:@""] || [self.name_textFied.text isEqualToString:@"请填写姓名"]) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"请您填写姓名" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([self.mobile_textField.text isEqualToString:@""] || [self.mobile_textField.text isEqualToString:@"请填写手机号码"])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"请您填写手机号码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self getTrain_submit_orderData];
    }
}

- (void)recoverKeyBorad:(UITapGestureRecognizer *)sender{
    [self.name_textFied resignFirstResponder];
    [self.mobile_textField resignFirstResponder];
}

- (void)getTrain_submit_orderData{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    NSDictionary *paramars = @{@"access_token":self.serverManager.accessToken,@"tid":self.train.ID,@"user_id":user_id,@"total_price":self.train.price,@"name":self.name_textFied.text,@"mobile":self.mobile_textField.text};
    [self.serverManager AnimatedPOST:@"train_submit_order.php" parameters:paramars success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 40010) {
            self.order_dic = responseObject[@"data"];
            TrainPayViewController *trainCon = [[TrainPayViewController alloc]init];
            trainCon.data_dic = self.order_dic;
            [self.navigationController pushViewController:trainCon animated:YES];
        }else{
            [self presentViewController:[Tools showAlert:responseObject[@"msg"]] animated:YES completion:nil];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

@end
