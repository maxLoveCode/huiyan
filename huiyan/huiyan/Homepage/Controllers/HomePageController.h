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
//menuControllerView
@property (strong, nonatomic) UICollectionView* menuView;
@property (strong, nonatomic) UICollectionView* ticketCollectionView;
@property (strong, nonatomic) UICollectionView* wikiCollectionView;
@property (strong, nonatomic) UITableView* activityTableView;
@property (strong, nonatomic) NSMutableArray* dataSource;

@property (strong, nonatomic) ServerManager* serverManager;

@property (nonatomic, strong) NSArray *image_arr;
@property (nonatomic, strong) NSArray *title_arr;
@property (nonatomic,strong) NSArray *head_title;
@property(nonatomic,strong) NSMutableArray *ticketArr;
@property (nonatomic,strong) NSMutableArray *actArr;
@property (nonatomic,strong) NSMutableArray *wikiArr;
@property (nonatomic,strong) NSArray *findIcon;
@end
