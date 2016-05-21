//
//  DramaStarInvitionViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/18.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "DramaStarInvitionViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
#import "ServerManager.h"
#import "DramaStarInvatationCell.h"
#import "MHDatePicker.h"
#import "Tools.h"
@interface DramaStarInvitionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic, strong) NSArray *placeholder_arr;
@property (nonatomic, strong) UIButton *pay_btn;
@property (nonatomic, strong) UILabel *hint_lab;
@property (strong, nonatomic) UITextField *personTextField;
@property (strong, nonatomic) UITextField *mobileTextField;
@property (strong, nonatomic) UITextField *contentTextField;
@property (strong, nonatomic) MHDatePicker *selectDatePicker;
@property (nonatomic, strong) UILabel *timeLab;
@end


@implementation DramaStarInvitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀约";
    self.title_arr = @[@"演出时间",@"联系人",@"联系电话",@"演出内容"];
    self.placeholder_arr = @[@"请填写演出时间",@"请填写联系人",@"请填写联系人电话",@"请填写演出内容与要求"];
    self.serverManager = [ServerManager sharedInstance];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoverKeyBorad:)];
    tapGes.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGes];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.pay_btn];
    [self.view addSubview:self.hint_lab];
    // Do any additional setup after loading the view from its nib.
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(115, 0, 150, 50)];
        self.timeLab.font = kFONT14;
        self.timeLab.text = @"请填写演出时间";
        self.timeLab.textColor = COLOR_WithHex(0xa5a5a5);
    }
    return _timeLab;
}

- (UIButton *)pay_btn{
    if (!_pay_btn) {
        self.pay_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pay_btn.frame = CGRectMake(15, kScreen_Height - 150, kScreen_Width - 30, 40);
        self.pay_btn.layer.masksToBounds = YES;
        self.pay_btn.layer.cornerRadius = 15;
        self.pay_btn.backgroundColor = COLOR_THEME;
        [self.pay_btn setTitle:@"立即邀请" forState:UIControlStateNormal];
        [self.pay_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.pay_btn addTarget:self action:@selector(invitation:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pay_btn;
}

- (UILabel *)hint_lab{
    if (!_hint_lab) {
        self.hint_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, kScreen_Height - 100, kScreen_Width - 30, 50)];
        self.hint_lab.textColor = COLOR_WithHex(0xa65863);
        self.hint_lab.text = @"*客服人员将在3-5个工作日内与您联系,请保持手机通讯正常并耐心等待。";
        self.hint_lab.font = kFONT12;
        self.hint_lab.numberOfLines = 2;
    }
    return _hint_lab;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 300)];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
          [self.tableView registerNib:[UINib nibWithNibName:@"DramaStarInvatationCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        self.tableView.rowHeight = 50;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
  //  [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

#pragma mark -- tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DramaStarInvatationCell *cell = [tableView dequeueReusableCellWithIdentifier:@
                                     "cell"];
    if (indexPath.row == 2) {
        cell.name_textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    switch (indexPath.row) {
        case 0:
            cell.name_textField.hidden = YES;
            [cell.contentView addSubview:self.timeLab];
            break;
        case 1:
            self.personTextField = cell.name_textField;
            break;
        case 2:
            self.mobileTextField = cell.name_textField;
            break;
        default:
            self.contentTextField = cell.name_textField;
            break;
    }
    cell.name_lab.text = self.title_arr[indexPath.row];
    cell.name_textField.placeholder = self.placeholder_arr[indexPath.row];
    cell.name_textField.tag = indexPath.row + 100;
    cell.name_textField.returnKeyType = UIReturnKeyDone;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        _selectDatePicker = [[MHDatePicker alloc] init];
        _selectDatePicker.isBeforeTime = YES;
        _selectDatePicker.datePickerMode = UIDatePickerModeDate;
        __weak typeof(self) weakSelf = self;
        [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
            //        NSString *string = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeInterval:3600*8 sinceDate:selectedDate]];
            //        weakSelf.myLabel2.text = string;
            weakSelf.timeLab.text = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
        }];

    }
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

- (void)invitation:(UIButton *)sender{
    if (self.timeLab.text  == nil && [self.timeLab.text isEqualToString:@"请填写演出时间"]) {
        [self presentViewController:[Tools showAlert:@"请填写时间" ] animated:YES completion:nil];
    }else if(self.personTextField.text == nil && [self.personTextField.text isEqualToString:@"请填写联系人"]){
        [self presentViewController:[Tools showAlert:@"请填写联系人" ] animated:YES completion:nil];
    }else if (self.mobileTextField.text == nil || [self.mobileTextField.text isEqualToString:@"请填写联系人电话"]){
         [self presentViewController:[Tools showAlert:@"请填写联系人电话" ] animated:YES completion:nil];
    }else if (self.mobileTextField.text == nil || [self.mobileTextField.text isEqualToString:@"请填写演出内容与要求"]){
         [self presentViewController:[Tools showAlert:@"请填写演出内容与要求" ] animated:YES completion:nil];
    }else{
        [self getinvite_actorData];
    }
}

- (void)getinvite_actorData{
    NSLog(@"%@---%@",self.ID,kOBJECTDEFAULTS(@"user_id"));
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"actor_id":self.ID,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"date":self.timeLab.text,@"name":self.personTextField.text,@"phone":self.mobileTextField.text,@"content":self.contentTextField.text};
    [self.serverManager AnimatedPOST:@"invite_actor.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50090) {
             [self presentViewController:[Tools showAlert:@"邀请成功" ] animated:YES completion:nil];
        }else{
            [self presentViewController:[Tools showAlert:responseObject[@"msg"] ] animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}



- (void)recoverKeyBorad:(UITapGestureRecognizer *)sende{
    [self.personTextField resignFirstResponder];
    [self.mobileTextField resignFirstResponder];
    [self.contentTextField resignFirstResponder];
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
