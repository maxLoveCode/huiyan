//
//  SexTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "SexTableViewController.h"
#import "ServerManager.h"
#import "Constant.h"
#import "Tools.h"
#import "UITabBarController+ShowHideBar.h"
@interface SexTableViewController ()
{
    BOOL flag;
}

@property(nonatomic,strong)NSMutableArray * sex_array;
@property(nonatomic,strong)NSMutableDictionary * sex_dic;
@property (nonatomic, strong) ServerManager *serverManager;
@end

@implementation SexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"性别";
    self.tableView.bounces = NO;
    self.tableView.rowHeight = 50;
    self.serverManager = [ServerManager sharedInstance];
    self.sex_array=[[NSMutableArray alloc]initWithObjects:@"男",@"女", nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确认"  style:UIBarButtonItemStylePlain target:self action:@selector(finishClick)];
    self.navigationController.navigationBar.translucent = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadSex:(BOOL)sex
{
    flag = sex;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
    // [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

-(void)finishClick
{
    NSString *sexStr = @"";
    if(flag)
    {
       sexStr = @"1";
    }
    else
    {
        sexStr = @"2";
    }
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"sex":sexStr};
    [self.serverManager AnimatedPOST:@"edit_user_info.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80010) {
             [self.navigationController popViewControllerAnimated:NO];
            [self presentViewController:[Tools showAlert:@"修改成功"] animated:YES completion:nil];
        }else{
            [self presentViewController:[Tools showAlert:@"修改失败"] animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if(indexPath.row ==0)
    {
        if(flag)
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType= UITableViewCellAccessoryNone;
    }
    else
    {
        if(flag)
            cell.accessoryType= UITableViewCellAccessoryNone;
        else
            cell.accessoryType= UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text=_sex_array[indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    flag = !flag;
    [self.tableView reloadData];

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
