//
//  HomePageController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePageController.h"
#import "HomePageCell.h"

#define bannerHeight 187
#define menuHeight 72.5

@implementation HomePageController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"homePage"];

#ifdef DEBUG
    NSLog(@"Homepage loaded");
#endif
}

-(UITableView *)recommendTableView
{
    if (!_recommendTableView) {
        _recommendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-50) style:UITableViewStylePlain];
        _recommendTableView.delegate = self;
        _recommendTableView.dataSource = self;
        
        [_recommendTableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"recommends"];
        
#ifdef DEBUG
        [_recommendTableView setBackgroundColor:[UIColor redColor]];
#endif
        
    }
    return _recommendTableView;
}

-(UICollectionView* )menuView
{
    if(!_menuView){
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        _menuView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, menuHeight) collectionViewLayout:layout];
        [_menuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"menu"];
        
        _menuView.delegate = self;
        _menuView.dataSource = self;
    }
    return _menuView;
}

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _recommendTableView) {
        return 1;
    }
    else
        return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _recommendTableView) {
        return 5;
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        switch (section) {
            case 0:
                return 0.01;
            case 1:
                return 0.01;
            case 2:
                return 32;
            default:
                return 0.01;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return 10;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section == 2) {
            UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 32)];
            [headerView setBackgroundColor:[UIColor whiteColor]];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 10, 60, 12)];
            label.text = @"热门推荐";
            label.font = kFONT12;
            [headerView addSubview:label];
            
            return headerView;
        }
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        if (indexPath.section == 0)
        {
            return bannerHeight;
        }
        else if(indexPath.section == 1)
        {
            return menuHeight;
        }
    }
    return [HomePageCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _recommendTableView) {
        HomePageCell* cell = [_recommendTableView dequeueReusableCellWithIdentifier:@"recommends" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homePage" forIndexPath:indexPath];
        
        if (indexPath.section == 1) {
            [cell.contentView addSubview:self.menuView];
        }
        else if(indexPath.section == 2)
        {
            [cell.contentView addSubview:self.recommendTableView];
        }
        return cell;
    }
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreen_Width/4, kScreen_Width/4) ;
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menu" forIndexPath:indexPath];
    if (indexPath.item ==0) {
        [cell.contentView setBackgroundColor:[UIColor redColor]];
    }
    else if(indexPath.item ==1){
        [cell.contentView setBackgroundColor:[UIColor orangeColor]];
    }
    else if(indexPath.item ==2){
        [cell.contentView setBackgroundColor:[UIColor yellowColor]];
    }
    else
    {
        [cell.contentView setBackgroundColor:[UIColor greenColor]];
    }
    return cell;
}

@end
