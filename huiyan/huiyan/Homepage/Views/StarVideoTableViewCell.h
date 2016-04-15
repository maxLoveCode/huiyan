//
//  StarVideoTableViewCell.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayer.h"

@interface StarVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView* videoIcon;
@property (nonatomic, strong) UILabel* timeLabel;

@property (nonatomic, strong) UIView* cellContent;
@property (nonatomic, strong) ZFPlayerView* player;
@property (nonatomic, strong) UILabel* titleLabel;


@end
