//
//  HomePageHeadView.h
//  huiyan
//
//  Created by zc on 16/8/1.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LivingModel.h"
@protocol NoticesDelegate <NSObject>
- (void)clickNotices;
@end

@interface HomePageHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *noticesPic;
@property (nonatomic, weak) id <NoticesDelegate> delegate;
@end
