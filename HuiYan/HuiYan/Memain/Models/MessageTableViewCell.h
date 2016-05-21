//
//  MessageTableViewCell.h
//  huiyan
//
//  Created by zc on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* content;

-(void)setCellContent:(Message*)msg;

@end
