//
//  TrainOrdersCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/11.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainOrderDetail.h"
@interface TrainOrdersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image_pic;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
@property (weak, nonatomic) IBOutlet UILabel *address_lab;
- (void) setContent:(TrainOrderDetail *)model;
@end
