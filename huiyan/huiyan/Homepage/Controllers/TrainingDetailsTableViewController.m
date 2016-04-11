//
//  TrainingDetailsTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainingDetailsTableViewController.h"
#import "Constant.h"
#define BinnerHeight 187.5
@interface TrainingDetailsTableViewController ()

@end

@implementation TrainingDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"train"];
    self.title = @"培训";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        return 32;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 32)];
        [headerView setBackgroundColor:[UIColor whiteColor]];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin * 2, 10, 60, 12)];
        label.text = @"培训介绍";
        label.font = kFONT12;
        [headerView addSubview:label];
        UILabel *color_label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 10, 5, 15)];
        color_label.layer.masksToBounds = YES;
        color_label.layer.cornerRadius = 3;
        color_label.backgroundColor = COLOR_THEME;
        
        [headerView addSubview:color_label];
         return headerView;
    }
    return nil;
    
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"train" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UIScrollView *binner_scr = [cell viewWithTag:1000];
        if (!binner_scr) {
            binner_scr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, BinnerHeight)];
            binner_scr.backgroundColor = [UIColor redColor];
            binner_scr.tag = 1000;
            [cell.contentView addSubview:binner_scr];
        }
        UILabel *title_lab = [cell viewWithTag:1001];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, BinnerHeight + 15, kScreen_Width - 2 * kMargin, 32)];
            title_lab.font = kFONT16;
            title_lab.textColor = COLOR_WithHex(0x2f2f2f);
            title_lab.numberOfLines = 2;
            [cell.contentView addSubview:title_lab];
            title_lab.tag = 1001;
            
        }
    }
    // Configure the cell...
    
    return cell;
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
