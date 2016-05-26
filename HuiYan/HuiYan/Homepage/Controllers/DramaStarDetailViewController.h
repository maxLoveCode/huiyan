//
//  DramaStarDetailViewController.h
//  huiyan
//
//  Created by zc on 16/5/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaStar.h"
@interface DramaStarDetailViewController : UIViewController
@property (nonatomic,strong) DramaStar *drama;
@property (strong,nonatomic) UITableView* mainTable;
@property (strong,nonatomic) UITableView* videoTable;
@property (strong,nonatomic) NSMutableArray* dataSource;
@end
