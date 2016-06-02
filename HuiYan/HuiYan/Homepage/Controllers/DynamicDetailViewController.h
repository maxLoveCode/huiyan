//
//  DynamicDetailViewController.h
//  huiyan
//
//  Created by zc on 16/5/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarVideo.h"
@interface DynamicDetailViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) StarVideo *starVideo;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end
