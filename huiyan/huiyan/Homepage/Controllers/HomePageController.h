//
//  HomePageController.h
//  huiyan
//
//  Created by 华印mac－002 on 16ser/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "ServerManager.h"
#import "ZCBannerView.h"
@interface HomePageController : UITableViewController<UICollectionViewDelegate, UICollectionViewDataSource>

//热门推荐 recommendTableView
@property (strong, nonatomic) UITableView* recommendTableView;

//menuControllerView
@property (strong, nonatomic) UICollectionView* menuView;

@property (strong, nonatomic) NSMutableArray* dataSource;

@property (strong, nonatomic) ServerManager* serverManager;

@property (nonatomic, strong)ZCBannerView  *banner_view;

@property (nonatomic, strong) NSArray *image_arr;
@property (nonatomic, strong) NSArray *title_arr;
@end
