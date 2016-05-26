//
//  DynamicDetailViewController.h
//  huiyan
//
//  Created by zc on 16/5/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicDetailViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray  *dataSource;
@end
