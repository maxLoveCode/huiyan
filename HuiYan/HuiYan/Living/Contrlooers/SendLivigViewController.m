//
//  SendLivigViewController.m
//  huiyan
//
//  Created by zc on 16/8/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "SendLivigViewController.h"
#import "MHDatePicker.h"
@interface SendLivigViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *selectTime;
@property (nonatomic, strong) UIImageView *imagePic;
@property (nonatomic, strong) UIButton *selectPic;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) MHDatePicker *selectDatePicker;
@end

@implementation SendLivigViewController
static NSString *const normalCell = @"normal";
static NSString *const timeCell = @"timeNormal";
static NSString *const picCell = @"picCell";

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.layer.masksToBounds = YES;
        self.sureBtn.layer.cornerRadius = 5;
        self.sureBtn.frame = CGRectMake(kMargin, CGRectGetMaxY(self.tableView.frame) + 50, kScreen_Width - 2 * kMargin, 50);
        [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sureBtn.backgroundColor = COLOR_THEME;
    }
    return _sureBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Width + 100) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCell];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:timeCell];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:picCell];
    }
    return _tableView;
}

- (UIView *)navView{
    if (!_navView) {
        self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
        self.navView.backgroundColor = COLOR_THEME;
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        returnBtn.frame = CGRectMake(15, 20, 30, 50);
        [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        returnBtn.titleLabel.font = kFONT14;
        [returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [returnBtn addTarget:self action:@selector(returnNav) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:returnBtn];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 30, 20, 60, 50)];
        lab.textColor = [UIColor whiteColor];
        lab.font = kFONT14;
        lab.text = @"发布直播";
        [self.navView addSubview:lab];
    }
    return _navView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sureBtn];
     [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnkeyBoard)]];
    // Do any additional setup after loading the view.
}

#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return kScreen_Width;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
        UITextField *textField = [cell viewWithTag:1000];
        if (!textField) {
            textField = [[UITextField alloc]initWithFrame:CGRectMake(kMargin, 0, kScreen_Width - 2* kMargin, 50)];
            textField.placeholder = @"给你的直播写个标题吧(20字以内)";
            [cell.contentView addSubview:textField];
            textField.tag = 1000;
            self.textField = textField;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:timeCell forIndexPath:indexPath];
        UIButton *selectTime = [cell viewWithTag:1006];
        if (!selectTime) {
            selectTime = [UIButton buttonWithType:UIButtonTypeCustom];
            selectTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            selectTime.frame = CGRectMake(kMargin, 0, 200, 50);
            [selectTime addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
            [selectTime setTitle:@"直播时间" forState:UIControlStateNormal];
            [selectTime setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22]  forState:UIControlStateNormal];
            [cell.contentView addSubview:selectTime];
            self.selectTime = selectTime;
            selectTime.tag = 1006;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:picCell forIndexPath:indexPath];
        UIImageView *bgView = [cell viewWithTag:1002];
        if (!bgView) {
            bgView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, kMargin, kScreen_Width - 2 * kMargin, kScreen_Width - 2* kMargin)];
            bgView.backgroundColor = COLOR_WithHex(0xe5e5e5);
            [cell.contentView addSubview:bgView];
            bgView.tag = 1002;
            self.imagePic = bgView;
        }
        UIButton *selectBtn = [cell viewWithTag:1004];
        if (!selectBtn) {
            selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(kMargin, kMargin, kScreen_Width - 2 * kMargin, kScreen_Width - 2* kMargin);
            [selectBtn setTitleColor:COLOR_WithHex(0x7d7d7d) forState:UIControlStateNormal];
            [selectBtn setTitle:@"观众们喜欢好看的封面哦" forState:UIControlStateNormal];
            [cell.contentView addSubview:selectBtn];
            selectBtn.tag = 1004;
            self.selectPic = selectBtn;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)returnkeyBoard{
    [self.view endEditing:YES];
}

- (void)returnNav{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 选择时间
- (void)changeTime:(UIButton *)sender{
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    __weak typeof(self) weakSelf = self;
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        //        NSString *string = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeInterval:3600*8 sinceDate:selectedDate]];
        //        weakSelf.myLabel2.text = string;
        [sender setTitle:[weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    }];
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
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
