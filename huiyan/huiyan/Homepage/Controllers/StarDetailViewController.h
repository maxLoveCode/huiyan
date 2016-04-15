//
//  StarDetailViewController.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarDetailViewController : UIViewController

@property (strong,nonatomic) UITableView* mainTable;
@property (strong,nonatomic) UITableView* videoTable;

@property (strong,nonatomic) NSMutableArray* dataSource;

@end
