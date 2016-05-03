//
//  MQPayClient.h
//  WeixinPayDemo
//
//  Created by WsdlDev on 15/10/6.
//  Copyright © 2015年 mazengyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"
#import "MQUntils.h"
#import "ApiXml.h"
#import "WXApiObject.h"
#import "WXApi.h"

@interface MQPayClient : NSObject<WXApiDelegate>

@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *mchId;
@property (nonatomic, copy) NSString *mchKey;
@property (nonatomic, copy) NSString *notifyUrl;

- (BOOL)registerWeiXinApp:(NSString *)appid mch_id:(NSString *)mch_id mch_key:(NSString *)mch_key notifyUrl:(NSString *)notifyUrl withDescription:(NSString *)appdesc;

/**
 *  @author NSRoss99, 15-10-06 21:15:46
 *
 *  @brief  获取单例
 *
 *  @return 返回实例
 */
+ (MQPayClient *)shareInstance;

/**
 *  @author NSRoss99, 15-10-06 21:37:32
 *
 *  @brief  微信openUrl处理
 *
 *  @param url url连接
 *
 *  @return 时候成功处理
 */
+ (BOOL)weiXinHandleOpenURL:(NSURL *)url;


- (void)weiXinPayWithTitle:(NSString *)title money:(NSString *)money tradeNo:(NSString *)tradeNo
              successBlock:(void(^)(NSDictionary *result))successBlock
              failureBlock:(void(^)(NSDictionary *result))failureBlock;

@end
