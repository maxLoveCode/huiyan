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
    
    self.title = @"设置";                                                                                           
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    firstSection = @[@"修改密码"];
    secondSection = @[@"去评分"];
    thirdSection = @[@"tui chu deng lu"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController setHidden:YES];
    [super viewWillAppear:YES];
    [self.tableView setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController setHidden:NO];
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = firstSection[indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = secondSection[indexPath.row];
    }
    if (indexPath.section == 2){
        cell.textLabel.text = thirdSection[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //change password
    }
    if (indexPath.section == 1) {
        //comment app
    }
    if (indexPath.section == 2) {
        [self logOut];
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
    
}

@end
