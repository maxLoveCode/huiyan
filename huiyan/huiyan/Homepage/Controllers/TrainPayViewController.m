//
//  TrainPayViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "TrainPayViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "MQPayClient.h"
#import "TrainOrdersTableViewController.h"
@interface TrainPayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *payType;
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic, strong) NSArray *image_arr;
@property (nonatomic, strong) UIButton *pay;


@end

@implementation TrainPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title_arr = @[@"支付宝",@"微信支付"];
     self.image_arr = @[@"alipay",@"weixinpay"];
    [self.view addSubview:self.tableView];
     [self.view addSubview:self.pay];
      NSLog(@"user_id = %@",kOBJECTDEFAULTS(@"user_id"));
}

- (UIButton *)pay{
    if (!_pay) {
        self.pay = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pay.frame = CGRectMake(20, 200, kScreen_Width - 40 , 42);
        self.pay.layer.masksToBounds = YES;
        self.pay.layer.cornerRadius = 5;
        [self.pay setTitle:@"确认支付" forState:UIControlStateNormal];
        [self.pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.pay.backgroundColor = [UIColor grayColor];
    }
    return _pay;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController setHidden:YES];
    [super viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.scrollEnabled = NO;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"first"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"second"];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"third"];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 50;
        }else{
            return 50;
        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first" forIndexPath:indexPath];
        UILabel *lab = [cell viewWithTag:1000];
        if (!lab) {
            lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.text = @"支付金额";
            [cell.contentView addSubview:lab];
            lab.tag = 1000;
        }
        UILabel *price_lab = [cell viewWithTag:1001];
        if (!price_lab) {
            price_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin- 100, 0, 100, 50)];
            price_lab.textColor = [UIColor orangeColor];
            price_lab.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:price_lab];
            price_lab.tag = 1001;
        }
        price_lab.text = [NSString stringWithFormat:@"%@",self.data_dic[@"total_price"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first" forIndexPath:indexPath];
            UILabel *lab = [cell viewWithTag:10000];
            if (!lab) {
                lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
                lab.textAlignment = NSTextAlignmentLeft;
                lab.text = @"还需支付";
                [cell.contentView addSubview:lab];
                lab.tag = 10000;
            }
            UILabel *price_lab = [cell viewWithTag:10001];
            if (!price_lab) {
                price_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin- 100, 0, 100, 50)];
                price_lab.textColor = [UIColor orangeColor];
                price_lab.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:price_lab];
                price_lab.tag = 10001;
            }
            price_lab.text = [NSString stringWithFormat:@"%@",self.data_dic[@"total_price"]];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
            UIImageView *pic = [cell viewWithTag:1002];
            if (!pic) {
                pic = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, 10, 30, 30)];
                [cell.contentView addSubview:pic];
                pic.tag = 1002;
            }
            pic.image = [UIImage imageNamed:self.image_arr[indexPath.row - 1]];
            UILabel *lab = [cell viewWithTag:1003];
            if (!lab) {
                lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin + 40, 0, 100, 50)];
                lab.textAlignment = NSTextAlignmentCenter;
                [cell.contentView addSubview:lab];
                lab.tag = 1003;
            }
            lab.text = self.title_arr[indexPath.row - 1];
            UIImageView *change = [cell viewWithTag:1004];
            if (!change) {
                change = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - kMargin- 30, 10, 30, 30)];
                [cell.contentView addSubview:change];
                change.tag = 1004;
            }
            if ([self.payType isEqualToString:@"aliPay"]) {
                if (indexPath.row == 1) {
                    change.image = [UIImage imageNamed:@"right_se"];
                }else{
                    change.image = [UIImage imageNamed:@"right_hui"];
                }
            }else if ([self.payType isEqualToString:@"weixin"]){
                if (indexPath.row == 2) {
                    change.image = [UIImage imageNamed:@"right_se"];
                    
                }else{
                    change.image = [UIImage imageNamed:@"right_hui"];
                }
            }else{
                change.image = [UIImage imageNamed:@"right_hui"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"third" forIndexPath:indexPath];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            self.payType = @"aliPay";
            [self refreshBtn];
            [self.tableView reloadData];
        }else if (indexPath.row == 2){
            self.payType = @"weixin";
            [self refreshBtn];
            [self.tableView reloadData];
        }
    }
}

- (void)refreshBtn{
    if ([self.payType isEqualToString:@"aliPay"]) {
        UIColor *color = COLOR_THEME;
        [_pay setBackgroundColor:color];
        [_pay setEnabled:YES];
        [_pay removeTarget:self action:@selector(weixinPay) forControlEvents:UIControlEventTouchUpInside];
        [_pay addTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
        
    }else if ([self.payType isEqualToString:@"weixin"]){
        UIColor *color = COLOR_THEME;
        [_pay setBackgroundColor:color];
        [_pay setEnabled:YES];
        [_pay removeTarget:self action:@selector(aliPay) forControlEvents:UIControlEventTouchUpInside];
        [_pay addTarget:self action:@selector(weixinPay) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_pay setBackgroundColor:[UIColor grayColor]];
        [_pay setEnabled:NO];
    }
    
}

- (void)weixinPay{
    NSLog(@"weixin");
    NSString *notify;
    NSString *amount;
    // amount = [NSString stringWithFormat:@"%.0lf", self.data_dic[@"total_price"] * 100];
    amount = [NSString stringWithFormat:@"%.2f", 0.01];
    //订单号
    NSString* orderstring = self.data_dic[@"order_no"];
    [MQPayClient shareInstance].notifyUrl = notify;
    [[MQPayClient shareInstance]weiXinPayWithTitle:@"购票" money:amount tradeNo:orderstring successBlock:^(NSDictionary *res) {
        NSString* resultcode = [res objectForKey:@"code"];
        NSLog(@"%@, %@",res, resultcode);
        if ([resultcode integerValue] == 0) {
            TrainOrdersTableViewController *trainCon = [[TrainOrdersTableViewController alloc]init];
            trainCon.oid = self.data_dic[@"oid"];
            [self.navigationController pushViewController:trainCon animated:YES];
        }
        else
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"购买失败,请联系客服" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failureBlock:^(NSDictionary *result) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"购买失败,请联系客服" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)aliPay{
    NSLog(@"支付包支付");
    //初始化订单信息
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088021412701123";
    NSString *seller = @"zhifubao@huayinwenhua.com";
    NSString *privateKey = @"MIICXAIBAAKBgQDEcf//TAUh+3g+LyU08tLclkfp2mqzkQ5XEif23xeXuJhYsDTpzU0Ob15EB16aoUa4E5nOhcxwdnASaB18evvVQtf1ERkC2HQqjf/5fR/inNLtLlJ/nsCIaFQ+fmSPYivvbHYZ1ufpl78smPsVhHKPj9Z3E3zgvo6kAq3/QbUBlQIDAQABAoGAd4rL9saDBRfrJyQ3Zw4xROzqnCM+9UDbUh8JVNCToc9CXg30VSaKsrMQ0SMO7dggmdnLqgJ/0xwvvPPApcSNRDsIzQ+62XoN7oaaSiApDjExeTMRyz/HfR357K4EgDey9gAsh4yxz8aQ5TrIhRnqZJtNmw/QmDm1NASrBBCPN+ECQQDwqN7bDKnMklXXYzzjW4CtcRpAnOc9AaDFrxpkmLuQ2Y3itQDOBo4P+sv+3kGVrQdSmNsUzs0Nfh07YdsTOuHNAkEA0Pehro30WcTTYZLAFvoTd2lOW53/IO1nyiQ6f1Nt6CP6smcsqAvArhdaFrPU2QvUrgXYJT+FQ0ancI/3nC126QJAIm/nw+yh95YRFosq0VXsqeT/XrOVG1O6T89otXBtlqKq/P/tp42kkoDO5B+lvudNnvIkl2uoR//96ttr3+qTGQJAJdhDKtbAoyVXVvt52G9v6RdkPolttCvquRw4j+ivJfSmKXswBjsiqSTHhwcIjEptORsL2ysW2mlIV8VrBZjiSQJBANSRLnRbCM8hn6MlmjkhwEbWCRUBMg8bF1Y2jh0oXR5vBOWdAbFIzHEhw7IXt56F/AYoOi1iKvNEeIKQ3nCslNc=";
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0){
        
        NSLog(@"缺少partner或者seller或者私钥。");
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = self.data_dic[@"order_no"]; //订单ID（由商家自行制定）
    //    //商品标题
    order.productName = [NSString stringWithFormat:@"汇演订单:%@",self.data_dic[@"order_no"]];
    //    //商品描述
    order.productDescription = @"描述";
    //    //商品价格
    order.amount = self.data_dic[@"total_price"];
    //order.amount = [NSString stringWithFormat:@"%.2f", 0.01];
    
    //#pragma mark 疑问1.
    NSString *strUrl = [NSString stringWithFormat:@"%@/index.php/Home/Pay/train_alipay",kServerUrl];
    order.notifyURL =  strUrl; //回调URL
    
    //以下配置信息是默认信息,不需要更改.
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于快捷支付成功后重新唤起商户应用
    NSString *appScheme = @"huiyan";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSLog(@"pay %@",resultDic);
            NSLog(@"memo %@", [resultDic objectForKey:@"memo"]);
            NSNumber *resultCode = [resultDic objectForKey:@"resultStatus"];
            
            if(resultCode.integerValue == 9000)
            {
                NSLog(@"支付成功");
                NSLog(@"%@",self.data_dic[@"oid"]);
                TrainOrdersTableViewController *trainCon = [[TrainOrdersTableViewController alloc]init];
                trainCon.oid = self.data_dic[@"oid"];
                [self.navigationController pushViewController:trainCon animated:YES];
            }
            else if (resultCode.integerValue  == 6001)
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"用户终止支付" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            else
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"购买失败,请联系客服" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }];
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
