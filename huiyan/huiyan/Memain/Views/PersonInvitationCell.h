//
//  PersonInvitationCell.h
//  huiyan
//
//  Created by 华印mac－002 on 16/5/20.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invitation.h"
@interface PersonInvitationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headPic;
@property (weak, nonatomic) IBOutlet UILabel *person_lab;
@property (weak, nonatomic) IBOutlet UILabel *phonrLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
- (void)setContent:(Invitation *)model;
@end
