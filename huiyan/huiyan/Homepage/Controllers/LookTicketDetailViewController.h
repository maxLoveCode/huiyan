//
//  LookTicketDetailViewController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayData.h"
@interface LookTicketDetailViewController : UIViewController
@property (nonatomic, strong) PayData *payData;
@property (nonatomic, copy) NSString *returntype;
@end
