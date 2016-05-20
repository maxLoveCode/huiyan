//
//  TrainOrdersTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainOrdersTableViewController.h"
#import "Constant.h"
#import "UITabBarController+ShowHideBar.h"
#import "TrainOrdersCell.h"
#import "TrainOrdersMessageCell.h"
#import "ServerManager.h"
#import "TrainOrderDetail.h"
@interface TrainOrdersTableViewController ()
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic, strong) NSArray *tail_arr;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) TrainOrderDetail *trainData;
@end

@implementation TrainOrdersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"培训订单";
       self.title_arr = @[@"报名时间",@"联系人",@"联系电话",@"状态",@"订单编号"];
    [self.view addSubview:self.tableView];
    self.serverManager = [ServerManager sharedInstance];
        [self getTrain_order_detailData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height )];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"TrainOrdersCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"one"];
        [self.tableView registerNib:[UINib nibWithNibName:@"TrainOrdersMessageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"two"];
    }
    return _tableView;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 155;
    }else{
        if (indexPath.row == 3) {
            if ([self.type isEqualToString:@"0"]) {
                return 80;
            }
            else{
                return 50;
            }
        }
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 50;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
    if (section == 1) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 17, 5, 16)];
        lab.backgroundColor = COLOR_THEME;
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = 3;
        [headView addSubview:lab];
        UILabel *name_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin + 15, 17, 100, 16)];
        name_lab.font = kFONT16;
        name_lab.text = @"报名信息";
        [headView addSubview:name_lab];
        UILabel *line_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 49, kScreen_Width - 15, 1)];
        line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [headView addSubview:line_lab];
        return headView;
    }else{
        return headView;
    }
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
            TrainOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
        [cell setContent:self.trainData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        TrainOrdersMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"two"];
        NSString *order_str = self.tail_arr[indexPath.row];
        if (indexPath.row == 3) {
            UIImageView *image_pic = [cell viewWithTag:1002];
            if (!image_pic) {
                image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - 60 - 15 - 15, 18, 15, 15)];
                [cell.contentView addSubview:image_pic];
                image_pic.tag = 1002;
            }
            
            if([self.type isEqualToString:@"0"]){
            UILabel *lab = [cell viewWithTag:1000];
            if (!lab) {
                lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 15 - 300, 30, 300, 50)];
                lab.text = @"相关款项将在3-5个工作日内返还到您的账户";
                lab.font = kFONT14;
                lab.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:lab];
                lab.tag = 1000;
            }
            cell.tail_lab.text = @"组团失败";
                image_pic.image = [UIImage imageNamed:@"failure"];
            }else{
                  cell.tail_lab.text = @"报名成功";
                image_pic.image = [UIImage imageNamed:@"successful"];
            }
        }else{
            cell.tail_lab.text = order_str;
        }
        cell.head_lab.text = self.title_arr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    
    // Configure the cell...
}

- (void)getTrain_order_detailData{
    NSDictionary *paramars = @{@"access_token":self.serverManager.accessToken,@"oid":self.oid};
    [self.serverManager AnimatedGET:@"train_order_detail.php" parameters:paramars success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 40020) {
            self.trainData = [TrainOrderDetail trainOrderDetailWithDic:responseObject[@"data"]];
            self.tail_arr = @[self.trainData.createtime,self.trainData.name,self.trainData.mobile,self.trainData.is_effect,self.trainData.order_no];
            self.type = self.trainData.is_effect;
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
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
