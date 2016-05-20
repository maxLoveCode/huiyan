//
//  TicketCommentTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/16.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentContent.h"
@interface TicketCommentTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *name_lab;
@property (nonatomic,strong) UILabel *comment_lab;
@property (nonatomic,strong) UILabel *time_lab;
- (void)setContent:(CommentContent *)comment;
@end
