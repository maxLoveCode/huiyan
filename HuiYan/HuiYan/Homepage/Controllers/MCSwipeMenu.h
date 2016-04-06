//
//  MCSwipeMenu.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSwipeMenu : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) BOOL hasButton;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIScrollView* bgView;
@property (nonatomic, strong) UICollectionView* menuView;
@property (nonatomic, strong) UIButton* showAll;

@property (nonatomic, strong) NSMutableArray* dataSource;

@end
