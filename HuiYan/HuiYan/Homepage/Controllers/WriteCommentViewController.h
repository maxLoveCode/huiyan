//
//  WriteCommentViewController.h
//  huiyan
//
//  Created by zc on 16/5/30.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarVideo.h"
#import "BuyTicket.h"
@interface WriteCommentViewController : UIViewController
@property (nonatomic, strong)StarVideo *starVideo;
@property (nonatomic, strong)BuyTicket *buyTicket;
@property (nonatomic,copy) NSString *writeType;
@end
