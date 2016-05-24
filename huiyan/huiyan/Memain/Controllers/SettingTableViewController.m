//
//  SettingTableViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "SettingTableViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
#import "LoginViewController.h"
#import "ForgotPassTableViewController.h"

@interface SettingTableViewController ()
{
    NSArray* firstSection;
    NSArray* secondSection;
    NSArray* thirdSection;
}

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.exitBtn];
    self.tableView.scrollEnabled = NO;
    self.title = @"设置";                                                                                           
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    firstSection = @[@"修改密码"];
    secondSection = @[@"去评分"];
    thirdSection = @[@"退出登录"];
    
    self.navigationController.navigationBar.barTintColor = COLOR_THEME;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (UIButton *)exitBtn{
    if (!_exitBtn) {
        self.exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.exitBtn.backgroundColor = COLOR_THEME;
        [self.exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        self.exitBtn.frame = CGRectMake(20, 200, kScreen_Width - 40, 42);
        self.exitBtn.layer.masksToBounds = YES;
        self.exitBtn.layer.cornerRadius = 5;
        [self.exitBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController setHidden:YES];
    [super viewWillAppear:YES];
    [self.tableView setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.tabBarController setHidden:NO];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return [firstSection count];
    }
    else if (section == 1)
    {
        return [secondSection count];
    }else {
        return 1;
    }
}

-(CGFloat)tableView:( UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section !=2) {
        return 44;
    }
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = firstSection[indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = secondSection[indexPath.row];
    }
    if (indexPath.section == 2){
//        cell.contentView.backgroundColor = COLOR_THEME;
//        cell.textLabel.backgroundColor = COLOR_THEME;
//        cell.textLabel.textColor = [UIColor whiteColor];
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;              
//        cell.textLabel.text = thirdSection[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //change password
        ForgotPassTableViewController *cpt = [[ForgotPassTableViewController alloc] init];
        [cpt setType:1];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:cpt];
        [self.navigationController presentViewController:nav animated:NO completion:^{
            
        }];
    }
    if (indexPath.section == 1) {
        //comment app
    }
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

-(void)logOut
{
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *navCon = [[UINavigationController alloc]initWithRootViewController:login];
    [self.navigationController presentViewController:navCon animated:NO  completion:^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"user_id"];
        [defaults removeObjectForKey:@"login_type"];
        [defaults removeObjectForKey:@"rongcloud_token"];
    }];
}

@end
