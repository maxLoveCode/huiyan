//
//  WalletTableViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/23.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WalletTableViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "MQPayClient.h"
#import "ServerManager.h"
#define cellHeight 44
#define topupheight 180
#define buttonHeight 60

@interface WalletTableViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSInteger select;
    NSDictionary* basicInfo;
}
@property (nonatomic, strong) UICollectionView* topup;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end            

@implementation WalletTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverManager = [ServerManager sharedInstance];
    [self get_recharge_diamondData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"wallet"];
     self.navigationController.navigationBar.translucent = NO;
    self.title = @"我的钱包";
    [self getBasicInfo];
    select = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController setHidden:YES];
    [super viewWillAppear:YES];
   
    //[self.tableView setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.translucent = YES;

}

#pragma setter
-(UICollectionView *)topup
{
    if (!_topup) {
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        _topup = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, topupheight +20 ) collectionViewLayout:layout];
        _topup.delegate = self;
        _topup.dataSource = self;
        [_topup registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"topup"];
        _topup.backgroundColor = [UIColor whiteColor];
        
    }
    return _topup;
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return cellHeight;
    }
    else if (indexPath.section == 1)
    {
        return topupheight+20;
    }
    else return buttonHeight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    else
        return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
    }
    else if (section == 1)
    {
        UILabel* header = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 0, kScreen_Width-kMargin, 40)];
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        header.backgroundColor = [UIColor whiteColor];
        header.text = @"充值";
        header.textColor = [UIColor darkGrayColor];
        header.font = kFONT16;
        [view addSubview:header];
        [view setBackgroundColor:[UIColor whiteColor]];
        return view;
    }
    else
        return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                          reuseIdentifier:@"wallet"];
    if ([cell.contentView subviews]){
        for (UIView *subview in [cell.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"账户名称:";
            if (!basicInfo) {
                
                cell.detailTextLabel.text = @"loading";
            }
            else
                cell.detailTextLabel.text = basicInfo[@"nickname"];
        }
        else
        {
            cell.textLabel.text = @"账户余额:";
            if (!basicInfo) {
                
                cell.detailTextLabel.text = @"loading";
            }
            else
                cell.detailTextLabel.text = basicInfo[@"diamond"];
        }
    }
    else if (indexPath.section == 1)
    {
        [cell.contentView addSubview:self.topup];
    }
    else
    {
        UIButton* pay = [UIButton buttonWithType:UIButtonTypeCustom];

        [pay setFrame:CGRectMake(kMargin, 0,  kScreen_Width-2*kMargin, buttonHeight)];
        [pay setTitle:@"立即支付" forState: UIControlStateNormal];
        pay.backgroundColor = COLOR_THEME;
        pay.layer.cornerRadius = 4;
        pay.layer.masksToBounds = YES;
        CGFloat indent_large_enought_to_hidden= 10000;
        cell.separatorInset = UIEdgeInsetsMake(0, indent_large_enought_to_hidden, 0, 0); // indent large engough for separator(including cell' content) to hidden separator
        cell.indentationWidth = indent_large_enought_to_hidden * -1; // adjust the cell's content to show normally
        cell.indentationLevel = 1; // must add this, otherwise default is 0, now actual indentation = indentationWidth * indentationLevel = 10000 * 1 = -10000
        [pay addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
        [cell setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        [cell.contentView addSubview:pay];
    }
    return cell;
}

#pragma mark - collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreen_Width/3  , topupheight/2 ) ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* item = [collectionView dequeueReusableCellWithReuseIdentifier:@"topup" forIndexPath:indexPath];
    
    //remove all subviews in contentview
    if ([item.contentView subviews]){
        for (UIView *subview in [item.contentView subviews]) {
            [subview removeFromSuperview];
        }
    }
    
    NSString* price = [[_dataSource objectAtIndex:indexPath.item] objectForKey:@"price"];
    
    NSLog(@"%@",price);
    price = [NSString stringWithFormat:@"%d", (int)[price integerValue]];
    UILabel* pricelab= [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, kScreen_Width/3-2*kMargin, topupheight/2-2*kMargin)];
    pricelab.textAlignment = NSTextAlignmentCenter;
    UIColor* color = COLOR_THEME;
   
    pricelab.backgroundColor = [UIColor whiteColor];
    pricelab.text =[NSString stringWithFormat:@"%@元", price];
    pricelab.font = [UIFont boldSystemFontOfSize:18];
    UILabel* diamond = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(pricelab.frame)-18, CGRectGetWidth(pricelab.frame), 16)];
    
    diamond.text = [NSString stringWithFormat:@"%@钻石", [[_dataSource objectAtIndex:indexPath.item] objectForKey:@"diamond"]];
    diamond.textAlignment = NSTextAlignmentCenter;
    diamond.font = kFONT12;
    if (indexPath.item == select) {
        pricelab.backgroundColor = color;
        diamond.backgroundColor = color;
        pricelab.textColor = [UIColor whiteColor];
        diamond.textColor = [UIColor whiteColor];
    }
    
    pricelab.layer.borderColor = color.CGColor;
    pricelab.layer.borderWidth = 2.0f;
    pricelab.layer.cornerRadius = 10.0f;
    pricelab.layer.masksToBounds = YES;
    
    [pricelab addSubview:diamond];
    [item.contentView addSubview:pricelab];
    
    
    return item;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    select = indexPath.item;
    [collectionView reloadData];
}

-(void)pay:(UIButton *)sender
{
    NSString* price = [[_dataSource objectAtIndex:select] objectForKey:@"price"];
    // price = [NSString stringWithFormat:@"%d元", (int)[price integerValue]];
    [self aliPay:price];
}

- (void)aliPay:(NSString *)price{
    NSLog(@"支付包支付");
    //初始化订单信息
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
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
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    //    //商品标题
    order.productName = [NSString stringWithFormat:@"汇演订单:%@",order.tradeNO];
    //    //商品描述
    order.productDescription = [NSString stringWithFormat:@"%@:%@",  [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"],[[_dataSource objectAtIndex:select] objectForKey:@"diamond"] ];
    //    //商品价格
   // order.amount = price;
    order.amount = [NSString stringWithFormat:@"%.2f", [price floatValue]];
    //order.amount = @"0.01";
    //#pragma mark 疑问1.
    NSString *strUrl = [NSString stringWithFormat:@"%@/index.php/Home/Pay/cz_alipay",kServerUrl];
    order.notifyURL = strUrl; //回调URL
    
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
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"支付成功" message:[NSString stringWithFormat:@"您已充值%@元！",price] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                [alert addAction:defaultAction];
                [self getBasicInfo];
                [self presentViewController:alert animated:YES completion:nil];
    
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

#pragma mark- getDimondData
- (void)get_recharge_diamondData{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken};
    [self.serverManager AnimatedGET:@"get_recharge_diamond.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80090) {
            _dataSource = [[NSMutableArray alloc] init];
            _dataSource = responseObject[@"data"];
            [self.topup reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

#pragma mark- getBasicInfos
-(void)getBasicInfo{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken, @"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]};
    
    NSLog(@"get baisc info%@", parameters);
    [self.serverManager AnimatedGET:@"get_user_info.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 80000) {
            basicInfo = [[NSDictionary alloc] init];
            basicInfo = responseObject[@"data"];
            NSLog(@"%@", basicInfo);
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (NSString *)generateTradeNO
{
    static int kNumber = 12;
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((int)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    [resultStr appendString:[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"]];
    return resultStr;
}

@end
