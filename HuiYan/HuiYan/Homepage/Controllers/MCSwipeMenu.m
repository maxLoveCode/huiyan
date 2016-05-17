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
#define labelTag 1000
#define spacing 40
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
    
    _hasButton = NO;
    _index = 0;
    
    [self setFrame:CGRectMake(0, 0, defaultW, defaultH)];
    
    //[self debugData];
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _hasButton = NO;
    _index = 0;
    
    self.height = CGRectGetHeight(frame);
    self.width  = CGRectGetWidth(frame);
    
    //[self debugData];
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
        _bgView.showsHorizontalScrollIndicator = NO;
        //[_bgView setBackgroundColor:[UIColor whiteColor]];
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

-(UIView *)botEdge
{
    if (!_botEdge) {
        _botEdge = [[UIView alloc] initWithFrame:CGRectMake(0, defaultH-1, kScreen_Width, 1)];
        [_botEdge setBackgroundColor:COLOR_WithHex(0xdddddd)];
    }
    return _botEdge;
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
    

    return CGSizeMake([self widthOfString:text withFont:font]+spacing, defaultH);
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [[[cell contentView] subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSString* text  = [[_dataSource objectAtIndex:indexPath.item] objectForKey:@"name"];
    UIFont* font = [UIFont systemFontOfSize:14];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(spacing/2, 0, [self widthOfString:text withFont:font], CGRectGetHeight(collectionView.frame))];
    label.tag = labelTag;
    label.font = font;
    label.text = text;
    [cell.contentView addSubview:label];
    if (indexPath.item == _index) {
        [self appendUnderline:cell.frame];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _index = indexPath.item;
    [collectionView reloadData];
    [self.delegate swipeMenu:self didSelectAtIndexPath:indexPath];
}

-(void)layoutSubviews
{
    
    [self.menuView addSubview:self.botEdge];
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
    
    [_dataSource addObject:@{@"id":@"1", @"name":@"沪剧"}];
    [_dataSource addObject:@{@"id":@"12", @"name":@"京剧"}];
    [_dataSource addObject:@{@"id":@"10", @"name":@"黄梅"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"1", @"name":@"沪剧"}];
    [_dataSource addObject:@{@"id":@"12", @"name":@"京剧"}];
    [_dataSource addObject:@{@"id":@"10", @"name":@"黄梅"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [_dataSource addObject:@{@"id":@"11", @"name":@"杭州唱戏"}];
    [self.menuView setFrame:CGRectMake(0, 0, [self calulateLength], defaultH)];
    [self.bgView setContentSize:CGSizeMake([self calulateLength], -8)];
    [self.menuView reloadData];
}

// method of calcluating whole length
-(CGFloat)calulateLength
{
    CGFloat total = 20;
    for(int i =0; i<[_dataSource count]; i++)
    {
        NSString *string = [[_dataSource objectAtIndex:i] objectForKey:@"name"];
        UIFont* font = [UIFont systemFontOfSize:14];
        total+=[self widthOfString:string withFont:font]+spacing;
        
    }
    return total;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

- (void)appendUnderline:(CGRect)rect
{
    UIFont *font =[UIFont systemFontOfSize:14];
    NSString* content = [[_dataSource objectAtIndex:_index]objectForKey:@"name"];
    CGFloat length = [self widthOfString:content withFont:font];
    
    CGRect frame =CGRectMake(CGRectGetMinX(rect), CGRectGetHeight(_menuView.frame)-2, length+spacing, 2);
    
    if (!_underLine) {
        _underLine = [[UIView alloc] initWithFrame:frame];
        _underLine.backgroundColor = COLOR_THEME;
        
        [_menuView addSubview:_underLine];
    }
    else
    {
        if (CGRectGetWidth(self.menuView.frame) <= kScreen_Width) {
            [UIView animateWithDuration:0.2 animations:^{
                 [_underLine setFrame:frame];
            }];
        }
        else
        {
            [UIView animateWithDuration:0.2 animations:^{
                int right = 0;
                if (CGRectGetMinX(_underLine.frame) <CGRectGetMinX(frame)) {
                    right = 1;
                }
                else if (CGRectGetMinX(_underLine.frame) > CGRectGetMinX(frame))
                    right = 2;
                [_underLine setFrame:frame];
                
                if (right ==1) {
                if (_bgView.contentOffset.x +10 >0) {
                    if (_bgView.contentOffset.x +_bgView.frame.size.width +10
                        >_bgView.contentSize.width) {
                        return;
                        }
                        [_bgView setContentOffset:CGPointMake(_bgView.contentOffset.x+10, 0)];
                    }
                }
                else if (right ==2){
                    if (_bgView.contentOffset.x -10 >0) {
                        [_bgView setContentOffset:
                                  CGPointMake(_bgView.contentOffset.x-10, 0)];
                    }
                }
            }];
        }
    }
}

-(void)reloadMenu
{
    [self.menuView reloadData];
    CGFloat newWidth = [self calulateLength];
    if (newWidth < kScreen_Width) {
        newWidth = kScreen_Width;
    }
    [self.menuView setFrame:CGRectMake(0, 0, newWidth, defaultH)];
    [self.botEdge setFrame:CGRectMake(0, defaultH-1, newWidth, 1)];
    [self.bgView setContentSize:CGSizeMake([self calulateLength], -8)];
}

@end
