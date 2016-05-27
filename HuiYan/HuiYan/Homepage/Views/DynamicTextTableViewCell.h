//
//  DynamicTextTableViewCell.h
//  HuiYan
//
//  Created by zc on 16/5/26.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarVideo.h"
@interface DynamicTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *typePic;
- (void)setContent:(StarVideo *)model;
@end
