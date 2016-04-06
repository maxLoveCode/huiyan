//
//  WikiViewCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/6.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyTicket.h"
#import "UIImageView+WebCache.h"
@interface BuyTicketCell : UITableViewCell
@property (nonatomic, strong) UIImageView *_Nonnull image_pic;
@property (nonatomic, strong) UILabel *_Nonnull time_lab;
@property (nonatomic, strong) UILabel *_Nonnull title_lab;
@property (nonatomic, strong) UILabel *_Nonnull address_lab;
@property (nonatomic, strong) UILabel *_Nonnull price_lab;
@property (nonatomic, strong) UIButton *_Nonnull buy_btn;

- (void) setContent:(BuyTicket *_Nonnull)ticket;
@end
