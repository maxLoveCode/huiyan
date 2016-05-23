//
//  TrainingTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainingTableViewController.h"
#import "Training.h"
#import "TrainingTableViewCell.h"
#import "ServerManager.h"
#import "TrainingDetailsTableViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
#import "SignUpMessageTableViewController.h"
@interface TrainingTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) UITableView *trainTableView;
@end

@implementation TrainingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.trainTableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UITableView *)trainTableView{
    if (!_trainTableView) {
        self.trainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        self.trainTableView.delegate = self;
        self.trainTableView.dataSource = self;
        self.trainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.trainTableView registerClass:[TrainingTableViewCell class
                                       ] forCellReuseIdentifier:@"train"];
        self.trainTableView.rowHeight = 152;

    }
    return _trainTableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getTrainData];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrainingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"train" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setContent:self.dataSource[indexPath.section]];
    cell.enroll_btn.tag = indexPath.section;
    [cell.enroll_btn addTarget:self action:@selector(enroll:) forControlEvents:UIControlEventTouchUpInside];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TrainingDetailsTableViewController *traDetailCon = [[TrainingDetailsTableViewController alloc]init];
    [self.tabBarController setHidden:YES];
    if (self.dataSource.count > 0) {
    traDetailCon.train  = self.dataSource[indexPath.section];
    }
    [self.navigationController pushViewController:traDetailCon animated:YES];
}

- (void)getTrainData{
    self.dataSource = [NSMutableArray array];
    NSDictionary *params = @{@"access_token":_serverManager.accessToken};
    [self.serverManager AnimatedGET:@"get_train_list.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 40000) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                Training *train =  [Training dataWithDic:dic];
                [self.dataSource addObject:train];
            }
            [self.trainTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)enroll:(UIButton *)sender{
    Training *train = self.dataSource[sender.tag];
    SignUpMessageTableViewController *signCon = [[SignUpMessageTableViewController alloc]init];
    signCon.train = train;
    [self.navigationController pushViewController:signCon animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
