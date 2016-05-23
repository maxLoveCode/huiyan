//
//  BuyTicketDetailsTableViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/8.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyTicket.h"
@interface BuyTicketDetailsTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *bg_view;
@property (nonatomic,strong) UIImageView *image_pic;
@property (nonatomic,strong) UILabel *title_lab;
@property (nonatomic,strong) UILabel *time_lab;
@property (nonatomic,strong) UILabel *address_lab;
@property (nonatomic,strong) UILabel *price_lab;
@property (nonatomic,strong) UIImageView *time_pic;
@property (nonatomic,strong) UIImageView *address_pic;
@property (nonatomic,strong) UIImageView *price_pic;
@property (nonatomic,strong) UIButton *collect_btn;
@property (nonatomic,strong) UIButton *writeComment_btn;
@property (nonatomic,strong) UIButton  *share_btn;
@property (nonatomic,strong) UITextField *write_textField;
- (void)setContent:(BuyTicket *)ticket;

+ (CGFloat)cellHeight;
@end
