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

#define cellHeight 44
#define topupheight 180
#define buttonHeight 60

@interface WalletTableViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    NSArray* topUpLevel;
    NSInteger select;
}
@property (nonatomic, strong) UICollectionView* topup;

@end

@implementation WalletTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"wallet"];
    
    self.title = @"我的钱包";
    topUpLevel = @[@"6", @"15", @"30", @"50", @"100", @"300"];
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
    [self.tableView setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController setHidden:NO];
    [super viewWillDisappear:YES];
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
            cell.detailTextLabel.text = @"loading";
        }
        else
        {
            cell.textLabel.text = @"账户余额:";
            cell.detailTextLabel.text = @"loading";
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
    
    NSString* price = topUpLevel[indexPath.item];
    UILabel* pricelab= [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, kScreen_Width/3-2*kMargin, topupheight/2-2*kMargin)];
    pricelab.textAlignment = NSTextAlignmentCenter;
    UIColor* color = COLOR_THEME;
   
    pricelab.backgroundColor = [UIColor whiteColor];
    pricelab.text =[NSString stringWithFormat:@"%@元", price];
    if (indexPath.item == select) {
        pricelab.backgroundColor = color;
        pricelab.textColor = [UIColor whiteColor];
    }
    pricelab.layer.borderColor = color.CGColor;
    pricelab.layer.borderWidth = 2.0f;
    pricelab.layer.cornerRadius = 10.0f;
    pricelab.layer.masksToBounds = YES;
    [item.contentView addSubview:pricelab];
    return item;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    select = indexPath.item;
    [collectionView reloadData];
}

-(void)pay
{
    if (!select) {
        return;
    }
    NSString* price = topUpLevel[select];
#warning price是价格,下面要支付跳转.
    
}

@end
