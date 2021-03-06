//
//  WikiArtcleTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WikiArtcleTableViewController.h"
#import "HomePage.h"
#import "ArticleTableViewCell.h"
#import "Constant.h"
#import "WikiWorksDetailsViewController.h"
#import "ServerManager.h"
#import "HomePage.h"
@interface WikiArtcleTableViewController ()
@property (nonatomic, strong) ServerManager *serverManager;
@end

@implementation WikiArtcleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"WikiArticalTableViewController");
    self.serverManager = [ServerManager sharedInstance];
    [self.tableView registerClass:[ArticleTableViewCell class] forCellReuseIdentifier:@"article"];
    self.tableView.rowHeight = [ArticleTableViewCell cellHeight];
    self.tableView.frame = CGRectMake(kScreen_Width, 10, kScreen_Width, kScreen_Height - 41 - 48 - 44 + 20);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"article" forIndexPath:indexPath];
    if (self.dataSource.count > 0) {
         [cell setContent:self.dataSource[indexPath.row]];
    }
    // Configure the cell...
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WikiWorksDetailsViewController *wikiCon = [[WikiWorksDetailsViewController alloc]init];
    if (self.dataSource.count > 0) {
         wikiCon.homePage = self.dataSource[indexPath.row];
    }
   
    HomePage *homepage = self.dataSource[indexPath.row];
    [self getwiki_plsData:homepage];
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:wikiCon animated:YES];
}

- (void)getwiki_plsData:(HomePage *)homePage{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"type":@"play_count",@"wid":[NSString stringWithFormat:@"%ld",(long)homePage.ID]};
    [self.serverManager AnimatedPOST:@"inc_wiki_pls.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 20020) {
            
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
