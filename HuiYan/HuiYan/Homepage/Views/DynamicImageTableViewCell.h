//
//  DynamicImageTableViewCell.h
//  huiyan
//
//  Created by zc on 16/5/26.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarVideo.h"
@interface DynamicImageTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *onePic;
@property (nonatomic, strong) UIImageView *twoPic;
@property (nonatomic, strong) UIImageView *threePic;
@property (nonatomic, strong) UILabel *lineLab;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIImageView *typePic;
- (void)setContent:(StarVideo *)model;
@end
