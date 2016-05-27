//
//  DynamicCommentCell.h
//  HuiYan
//
//  Created by zc on 16/5/27.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DynamicCommentCell : UITableViewCell
@property (nonatomic, strong) UIImageView *headPic;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *commentLab;
- (void)setContent:(NSDictionary *)dic;
@end
