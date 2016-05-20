//
//  LookTicketCell.h
//  
//
//  Created by 华印mac－002 on 16/5/3.
//
//

#import <UIKit/UIKit.h>
#import "PayData.h"
@interface LookTicketCell : UITableViewCell
@property (nonatomic,strong) UIView *bg_view;
@property (nonatomic,strong) UILabel *title_lab;
@property (nonatomic,strong) UILabel *time_lab;
@property (nonatomic,strong) UILabel *name_lab;
@property (nonatomic,strong) UILabel *seat_lab;
@property (nonatomic,strong) UILabel *mobile_lab;
@property (nonatomic,strong) UILabel *code_lab;
@property (nonatomic,strong) UIImageView *barCode_pic;
@property (nonatomic,strong) UILabel *line_lab;
- (void)setContent:(PayData *)payData;
@end
