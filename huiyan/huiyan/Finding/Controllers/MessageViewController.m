//
//  MessageViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MessageViewController.h"
#import "Constant.h"
#import "MessageCell.h"
#import "ExploreViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "MessageListTableViewController.h"
#import "FriendsViewController.h"

#define cellHeight 44

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _height;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic, strong) NSArray *image_arr;

@property (nonatomic, strong) FriendsViewController* list;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    _height =4*cellHeight;
    
    [self.view addSubview:self.tableView];
     self.navigationController.navigationBar.barTintColor = COLOR_THEME;
    self.title_arr = @[@"互动消息",@"系统消息",@"推送消息",@"附近的戏友"];
    self.image_arr = @[@"interaction",@"system",@"pushMes",@"around"];
    
    
    [self addChildViewController:self.list];
    [self.list.view setFrame:CGRectMake(0, _height, kScreen_Width, kScreen_Height-_height)];
    [self.view addSubview:self.list.view];
}

- (void)viewDidAppear:(BOOL)animated
{
      [super viewDidAppear:YES];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.tabBarController setHidden:NO];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, _height)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 60;
        [self.tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"message"];
    }
    return _tableView;
}

-(FriendsViewController *)list
{
    if (!_list) {
        _list = [[FriendsViewController alloc] init];
    }
    return _list;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message"];
    cell.textLabel.text = self.title_arr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.image_arr[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tabBarController.tabBar.hidden = YES;
    if (indexPath.row == 0) {
        MessageListTableViewController *list = [[MessageListTableViewController alloc] init];
        [list setStyle: MessageTypeSystem];
        [self.navigationController pushViewController:list animated:YES];
    }
    else if (indexPath.row == 1) {
        MessageListTableViewController *list = [[MessageListTableViewController alloc] init];
        [list setStyle: MessageTypeNotification];
        [self.navigationController pushViewController:list animated:YES];
    }
    else if (indexPath.row == 2) {
        ExploreViewController *explore = [[ExploreViewController alloc]init];
        [self.navigationController pushViewController:explore animated:YES];
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
