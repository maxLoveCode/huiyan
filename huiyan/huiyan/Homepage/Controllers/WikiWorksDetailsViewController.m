//
//  WikiWorksDetailsViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WikiWorksDetailsViewController.h"
#import "Constant.h"

#define kHeadHeight 187
@interface WikiWorksDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *wikiDetailsTableView;
@end

@implementation WikiWorksDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor blackColor];
    NSLog(@"%@",self.dataSource);
    [self.view addSubview:self.wikiDetailsTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)wikiDetailsTableView{
    if (!_wikiDetailsTableView) {
        self.wikiDetailsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kHeadHeight, kScreen_Width, kScreen_Height - kHeadHeight) style:UITableViewStylePlain];
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
        return 200;
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
            title_lab.backgroundColor = [UIColor blueColor];
            title_lab.tag = 1000;
            [cell addSubview:title_lab];
        }
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
              mes_lab.backgroundColor = [UIColor redColor];
        }
       
        UILabel *line_lab = [cell viewWithTag:1002];
        if (line_lab == nil) {
            UILabel *line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 42, kScreen_Width - 30, 0.5)];
            line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
            line_lab.font = kFONT14;
            [cell addSubview:line_lab];
            line_lab.tag = 1002;
        }
        
        UILabel *des_lab = [cell viewWithTag:1003];
        if (des_lab == nil) {
            UILabel *des_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 52, kScreen_Width - 30, 400)];
            des_lab.backgroundColor = COLOR_WithHex(0xa5a5a5);
            des_lab.tag = 1003;
            des_lab.font = kFONT14;
            [cell addSubview:des_lab];
            des_lab.backgroundColor = [UIColor yellowColor];
        }

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
