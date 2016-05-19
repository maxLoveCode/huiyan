//
//  PersonDramaTicketCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/15.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayData.h"
@interface PersonDramaTicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *head_pic;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
@property (weak, nonatomic) IBOutlet UILabel *address_lab;
@property (weak, nonatomic) IBOutlet UILabel *Count_lab;
@property (weak, nonatomic) IBOutlet UIImageView *status_pic;

- (void)setContent:(PayData *)model;
@end
