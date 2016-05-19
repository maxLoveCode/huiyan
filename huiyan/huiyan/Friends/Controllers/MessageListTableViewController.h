//
//  MessageListTableViewController.h
//  huiyan
//
//  Created by 华印mac-001 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageListTableViewController;

typedef NS_ENUM(NSInteger, MessageType)
{
    MessageTypeSystem,
    MessageTypeNotification
};

@interface MessageListTableViewController: UITableViewController

@property (nonatomic, assign) MessageType style;

@end
