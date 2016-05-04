//
//  FriendsViewController.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerManager.h"
#import <RongIMKit/RongIMKit.h>
#import "Constant.h"
#import "ServerManager.h"

@interface FriendsViewController : UIViewController


@property (nonatomic, assign) NSString* token;
@property (nonatomic, strong) ServerManager* serverManager;
@property (nonatomic, strong) UIView* loginRequest;
@property (nonatomic, strong) UIButton* login;

@end
