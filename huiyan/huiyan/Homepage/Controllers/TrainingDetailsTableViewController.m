//
//  TrainingDetailsTableViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainingDetailsTableViewController.h"
#import "Constant.h"
#import "ZCBannerView.h"
#import "UITabBarController+ShowHideBar.h"
#define BinnerHeight kScreen_Width / 2
@interface TrainingDetailsTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *image_arr;
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) UILabel *tail_lab;
@property (nonatomic, strong) UITableView *trainDetailsTableView;
@end

@implementation TrainingDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"培训";
    self.image_arr = @[@"arrow",@"arrow",@"arrow"];
    self.title_arr = @[self.train.date,self.train.address,self.train.price];
        [self.view addSubview:self.tail_lab];
    [self.view addSubview:self.trainDetailsTableView];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UITableView *)trainDetailsTableView{
    if (!_trainDetailsTableView) {
        self.trainDetailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 48 - 64) style:UITableViewStyleGrouped];
        self.trainDetailsTableView.delegate = self;
        self.trainDetailsTableView.dataSource = self;
        self.trainDetailsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.trainDetailsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"train"];
    }
    return _trainDetailsTableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UILabel *)tail_lab{
    if (!_tail_lab) {
        self.tail_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreen_Height - 48 - 64, kScreen_Width, 48)];
        self.tail_lab.backgroundColor = COLOR_THEME;
        self.tail_lab.textColor = [UIColor whiteColor];
        self.tail_lab.font = kFONT18;
        self.tail_lab.text = @"立即报名";
        self.tail_lab.textAlignment = NSTextAlignmentCenter;
    }
    return _tail_lab;
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
    if (indexPath.section == 0) {
        return BinnerHeight + 30 + 32;
    }else if (indexPath.section == 1){
        return 32;
    }else if (indexPath.section == 2){
        return 32;
    }else{
        return self.cellHeight;
    }
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
    if (section == 3) {
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
        ZCBannerView *binner_scr = [cell viewWithTag:1000];
        if (!binner_scr) {
            binner_scr = [[ZCBannerView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, BinnerHeight)];
            binner_scr.dataSource = self.train.imgs;
            [binner_scr reloadMenu];
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
            title_lab.text = self.train.title;
        }
    }else if(indexPath.section == 1){
        UIImageView *image_pic = [cell viewWithTag:1002];
        if (!image_pic) {
            image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 0, 32, 32)];
            image_pic.image = [UIImage imageNamed:self.image_arr[indexPath.row]];
            [cell.contentView addSubview:image_pic];
            cell.tag = 1002;
        }
        UILabel *title_lab = [cell viewWithTag: 1003];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin + 32, 0, kScreen_Width - 100, 32)];
            title_lab.font = kFONT14;
            title_lab.textColor = COLOR_WithHex(0xa5a5a5);
            title_lab.text = self.title_arr[indexPath.row];
            [cell.contentView addSubview:title_lab];
            title_lab.tag = 1003;
        };

        }else if (indexPath.section == 2){
            UIImageView *image_pic = [cell viewWithTag:1004];
            if (!image_pic) {
                image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 0, 32, 32)];
                image_pic.image = [UIImage imageNamed:@"arrow"];
                [cell.contentView addSubview:image_pic];
                cell.tag = 1004;
            }
            UILabel *title_lab = [cell viewWithTag: 1005];
            if (!title_lab) {
                title_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin + 32, 0, kScreen_Width - 100, 32)];
                title_lab.font = kFONT14;
                title_lab.textColor = COLOR_WithHex(0xa5a5a5);
                title_lab.text = [NSString stringWithFormat:@"已有%ld人报名",(long)[self.train.count integerValue]];
                [cell.contentView addSubview:title_lab];
                title_lab.tag = 1005;
            };
            UILabel *line_lab = [cell viewWithTag:1006];
            if (!line_lab) {
                line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 30 - 32 - 1, 2, 0.5, 28)];
                line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
                [cell.contentView addSubview:line_lab];
                line_lab.tag = 1006;
            }
            UIImageView *share_pic = [cell viewWithTag:1007];
            if (!share_pic) {
                share_pic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - 32 - kMargin, 32, 32, 32)];
                share_pic.image = [UIImage imageNamed:@"arrow"];
                [cell.contentView addSubview:share_pic];
                share_pic.tag = 1007;
            }
   
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 30, kScreen_Height - 48 - 10)];
        label.numberOfLines = 0;
        NSError *error;
        //NSLog(@"self.train.cover  = %@",self.train.content );
        //图文混排
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.train.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                                                                          NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}documentAttributes:nil error:&error];
        
        
        NSString* formatString = [attributedString string];
        NSAttributedString *secondDecoding =[[NSAttributedString alloc] initWithData:[formatString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                                                                        NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}documentAttributes:nil error:&error];
        self.textView.attributedText = secondDecoding;
        label.attributedText = secondDecoding;
        [label sizeToFit];
        [cell.contentView addSubview:label];
        self.cellHeight = CGRectGetHeight(label.frame);
    }
    // Configure the cell...
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
