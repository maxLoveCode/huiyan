//
//  HomePageController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePageController.h"

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
        _recommendTableView = [[UITableView alloc] init];
        _recommendTableView.delegate = self;
        _recommendTableView.dataSource = self;
        
        [_recommendTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"recommends"];
        
#ifdef DEBUG
        [_recommendTableView setBackgroundColor:[UIColor redColor]];
#endif
        
    }
    return _recommendTableView;
}

-(UICollectionView* )menuView
{
    if(!_menuView){
        _menuView = [[UICollectionView alloc] init];
        [_menuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"menu"];
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
        return 1;
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
                return 10;
            case 2:
                return 10;
            default:
                return 10;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
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
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _recommendTableView) {
        UITableViewCell* cell;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homePage" forIndexPath:indexPath];
        
        if (indexPath.row == 1) {
            [cell.contentView addSubview:self.menuView];
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
    return cell;
}

@end
