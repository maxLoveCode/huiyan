//
//  TrainOrdersTableViewController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Training.h"
@interface TrainOrdersTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSString *oid;
@property (nonatomic,copy) NSString *type;
@end
