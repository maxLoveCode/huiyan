//
//  MCSwipableMenuViewController.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSwipableMenuViewController : UICollectionViewController

@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic, assign) CGFloat menuWidth;

@property (nonatomic, strong) NSMutableArray* dataSource;

@end