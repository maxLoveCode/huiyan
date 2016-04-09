//
//  WikiWorksDetailsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WikiWorksDetailsViewController.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#define kHeadHeight 187
@interface WikiWorksDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *wikiDetailsTableView;
@property (nonatomic, strong) UIImageView *head_view;
@end

@implementation WikiWorksDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor blackColor];
    [self.view addSubview:self.wikiDetailsTableView];
    [self.view addSubview:self.head_view];
    NSLog(@"%@",self.homePage);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)head_view{
    if (!_head_view) {
        self.head_view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kHeadHeight)];
        [self.head_view sd_setImageWithURL:[NSURL URLWithString:self.homePage.cover] placeholderImage:[UIImage imageNamed:@"arrow"]];
    }
    return _head_view;
}

- (UITableView *)wikiDetailsTableView{
    if (!_wikiDetailsTableView) {
        self.wikiDetailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeadHeight, kScreen_Width, kScreen_Height - kHeadHeight - 48 - 64 ) style:UITableViewStylePlain];
        self.wikiDetailsTableView.delegate = self;
        self.wikiDetailsTableView.dataSource = self;
        self.wikiDetailsTableView.separatorStyle = NO;
        [self.wikiDetailsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"wikidetails"];
    }
    return _wikiDetailsTableView;
}

#pragma mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 42;
    }else{
        return 242;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"wikidetails" forIndexPath:indexPath];
    if (cell == nil) {
         cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wikidetails"];
    }
    UIView *head_view = [cell viewWithTag:999];
    if (head_view == nil) {
        UIView *head_view = [[UIView alloc]init];
        head_view.backgroundColor = COLOR_WithHex(0xefefef);
        head_view.frame = CGRectMake(0, 0, kScreen_Width, 10);
        UILabel *up_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
        up_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [head_view addSubview:up_lab];
        UILabel *down_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 9.5, kScreen_Width, 0.5)];
        down_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [head_view addSubview:down_lab];
        head_view.tag = 999;
           [cell addSubview:head_view];
    }

    
    if (indexPath.row == 0) {
        
        UILabel *title_lab = [cell viewWithTag:1000];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 30, 32)];
            title_lab.textColor = COLOR_WithHex(0x545454);
            title_lab.font = kFONT14;
            title_lab.tag = 1000;
            title_lab.numberOfLines = 0;
            [cell addSubview:title_lab];
        }
        title_lab.text = self.homePage.title;
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }else{

        UILabel *mes_lab = [cell viewWithTag:1001];
        if (!mes_lab) {
            UILabel *mes_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 30, 32)];
            mes_lab.textColor = COLOR_WithHex(0x545454);
            mes_lab.font = kFONT14;
            mes_lab.text = @"简介";
            mes_lab.tag = 1001;
            [cell addSubview:mes_lab];
        }
       
        UILabel *line_lab = [cell viewWithTag:1002];
        if (!line_lab) {
            UILabel *line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 42, kScreen_Width - 30, 0.5)];
            line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
            line_lab.font = kFONT14;
            [cell addSubview:line_lab];
            line_lab.tag = 1002;
        }
        
        UILabel *des_lab = [cell viewWithTag:1003];
        if (!des_lab) {
            UILabel *des_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 52, kScreen_Width - 30, 200)];
            des_lab.textColor = COLOR_WithHex(0xa5a5a5);
            des_lab.font = kFONT14;
            des_lab.text = self.homePage.profile;
            [cell addSubview:des_lab];
                des_lab.tag = 1003;
        }
 
        NSLog(@"self.homePage.profile = %@",self.homePage.profile);
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
