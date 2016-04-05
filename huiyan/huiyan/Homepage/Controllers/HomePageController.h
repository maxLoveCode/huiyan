//
//  HomePageController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageController : UITableViewController<UICollectionViewDelegate, UICollectionViewDataSource>

//热门推荐 recommendTableView
@property (strong, nonatomic) UITableView* recommendTableView;

//menuControllerView
@property (strong, nonatomic) UICollectionView* menuView;

@end
