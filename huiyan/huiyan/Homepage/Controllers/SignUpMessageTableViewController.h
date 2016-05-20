//
//  SignUpMessageTableViewController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Training.h"
@interface SignUpMessageTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) Training  *train;
@end
