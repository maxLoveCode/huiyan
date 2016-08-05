//
//  LivingProjectCell.h
//  huiyan
//
//  Created by zc on 16/8/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LivingModel.h"
@interface LivingProjectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *playLiving;
- (void)setContentModel:(LivingModel *)model;
@end
