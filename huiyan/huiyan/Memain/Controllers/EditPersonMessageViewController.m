//
//  EditPersonMessageViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "EditPersonMessageViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import "PersonMessage.h"
#import "UIImageView+WebCache.h"
#import "SexTableViewController.h"
@interface EditPersonMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) PersonMessage *perData;
@end

@implementation EditPersonMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"头像",@"昵称",@"性别"];
    self.view.backgroundColor = COLOR_WithHex(0xdddddd);
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
    self.serverManager = [ServerManager sharedInstance];
    [self get_user_infoData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   // [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 50;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"edit"];
    }
    return _tableView;
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"edit" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row == 0) {
        UIImageView *imagePic = [cell viewWithTag:1000];
        if (!imagePic) {
            imagePic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - 72, 4, 42, 42)];
            imagePic.layer.masksToBounds = YES;
            imagePic.layer.cornerRadius = 21;

            [cell.contentView addSubview:imagePic];
            imagePic.tag = 1000;
        }
        [imagePic sd_setImageWithURL:[NSURL URLWithString:self.perData.avatar]];
    }else if (indexPath.row == 1){
        UILabel *nameLab = [cell viewWithTag:1002];
        if (!nameLab) {
            nameLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 230, 4, 200, 42)];
            nameLab.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:nameLab];
            nameLab.tag = 1002;
        }
        nameLab.text = self.perData.nickname;
    }else {
        UILabel *sexLab = [cell viewWithTag:1004];
        if (!sexLab) {
            sexLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 230, 4, 200, 42)];
            sexLab.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:sexLab];
            sexLab.tag = 1004;
        }
        if ([self.perData.sex isEqualToString:@"1"]) {
            sexLab.text = @"男";
        }else{
            sexLab.text = @"女";
        }
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        SexTableViewController *sexCon = [[SexTableViewController alloc]init];
        [self.navigationController pushViewController:sexCon animated:YES];
    }
}

- (void)get_user_infoData{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    if (user_id) {
        NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id};
        [self.serverManager AnimatedGET:@"get_user_info.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"]integerValue] == 80000) {
                self.perData = [PersonMessage personWithDic:responseObject[@"data"]];
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
