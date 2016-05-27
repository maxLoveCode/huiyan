//
//  StarVideoTableViewCell.h
//  huiyan
//
//  Created by 华印mac-001 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayer.h"
#import "StarVideo.h"
typedef void(^PlayBtnCallBackBlock)(UIButton *);
@interface StarVideoTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *v_lab;
@property (nonatomic, strong) UILabel* timeLabel;
@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic,strong) UIButton *playBtn;
@property (nonatomic,strong) UIImageView *typePic;
@property (nonatomic,strong) UIButton *number_likeBtn;
@property (nonatomic,strong) UIButton *number_mesBtn;

//播放按钮Block
@property (nonatomic,copy) PlayBtnCallBackBlock playBlock;

- (void)setContent:(StarVideo *)starVideo;

@end
