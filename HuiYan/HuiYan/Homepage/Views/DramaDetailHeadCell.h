//
//  DramaDetailHeadCell.h
//  huiyan
//
//  Created by zc on 16/5/25.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DramaStar.h"
typedef void(^FocusActorBlock) (UIButton *);
@interface DramaDetailHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgPic;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;
@property (weak, nonatomic) IBOutlet UIButton *returnBtn;
@property (weak, nonatomic) IBOutlet UIButton *descriptionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headPic;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *fansLab;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *onePic;
@property (weak, nonatomic) IBOutlet UIImageView *threePic;
@property (weak, nonatomic) IBOutlet UIImageView *twoPic;
@property (strong, nonatomic) UILabel *lineLab;
@property (nonatomic,copy) FocusActorBlock focus;
- (void)setContent:(DramaStar *)model;
@end
