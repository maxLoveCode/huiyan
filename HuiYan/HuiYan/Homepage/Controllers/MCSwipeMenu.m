//
//  MCSwipeMenu.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MCSwipeMenu.h"
#import "Constant.h"

#define defaultH 41
#define defaultW kScreen_Width

static NSString * const reuseIdentifier = @"swipableMenu";

@implementation MCSwipeMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    self = [super init];
    
    _hasButton = YES;
    
    [self setFrame:CGRectMake(0, 0, defaultW, defaultH)];
    
    [self debugData];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _hasButton = YES;
    
    self.height = CGRectGetHeight(frame);
    self.width  = CGRectGetWidth(frame);
    
    [self debugData];
    return self;
}

-(UIScrollView *)bgView
{
    if (!_bgView) {
        CGRect rect = CGRectMake(0, 0, defaultW, defaultH);
        if (_hasButton) {
            rect = CGRectMake(0, 0, defaultW-defaultH, defaultH);
        }
        _bgView = [[UIScrollView alloc] initWithFrame:rect];
        _bgView.bounces = NO;
        NSLog(@"bgview %@",self.bgView);
        [_bgView setBackgroundColor:[UIColor blueColor]];
    }
    return _bgView;
}

-(UICollectionView *)menuView
{
    if (!_menuView) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        CGRect rect = CGRectMake(0, 0, defaultW, defaultH);
        if (_hasButton) {
            rect = CGRectMake(0, 0, defaultW-defaultH, defaultH);
        }
        
        _menuView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
        [_menuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        
        _menuView.scrollEnabled = NO;
        [_menuView setBackgroundColor:[UIColor whiteColor]];
        _menuView.delegate = self;
        _menuView.dataSource = self;
    }
    return _menuView;
}

-(UIButton *)showAll
{
    if (!_showAll) {
        _showAll = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bgView.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    }
    return _showAll;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_dataSource count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* text  = [[_dataSource objectAtIndex:indexPath.item] objectForKey:@"name"];
    UIFont* font = [UIFont systemFontOfSize:14];
    

    return CGSizeMake([self widthOfString:text withFont:font], defaultH);
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSString* text  = [[_dataSource objectAtIndex:indexPath.item] objectForKey:@"name"];
    UIFont* font = [UIFont systemFontOfSize:14];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self widthOfString:text withFont:font], CGRectGetHeight(collectionView.frame))];
    
    label.font = font;
    label.text = text;
    [cell.contentView addSubview:label];
    
    UIView* underLine = [[UIView alloc] initWithFrame:CGRectMake(-5, CGRectGetHeight(collectionView.frame)-2, [self widthOfString:text withFont:font]+10, 2)];
    underLine.backgroundColor = COLOR_THEME;
    [cell.contentView addSubview:underLine];
    
    return cell;
}

-(void)layoutSubviews
{
    [self.bgView addSubview:self.menuView];
    [self addSubview:self.bgView];
    if (_hasButton) {
        [self addSubview:self.showAll];
    }
}

#pragma mark debug data
-(void)debugData
{
    _dataSource = [[NSMutableArray alloc] init];
    [_dataSource addObject:@{@"id":@"1", @"name":@"沪剧"}];
    [_dataSource addObject:@{@"id":@"12", @"name":@"京剧"}];
    [_dataSource addObject:@{@"id":@"10", @"name":@"黄梅"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    
    NSLog(@"%lf",[self calulateLength]);
    [self.menuView setFrame:CGRectMake(0, 0, [self calulateLength], defaultH)];
    [self.bgView setContentSize:CGSizeMake([self calulateLength], -8)];
    [self.menuView reloadData];
}

-(CGFloat)calulateLength
{
    CGFloat total = 0;
    for(int i =0; i<[_dataSource count]; i++)
    {
        NSString *string = [[_dataSource objectAtIndex:i] objectForKey:@"name"];
        UIFont* font = [UIFont systemFontOfSize:14];
        total+=[self widthOfString:string withFont:font]+10;
    }
    return total-10;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

@end
