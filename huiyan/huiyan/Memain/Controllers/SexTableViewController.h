//
//  SexTableViewController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SexTableViewController : UITableViewController
@property (strong, nonatomic) void (^clickBlock)(int);

-(void)loadSex:(BOOL)sex;
@end
