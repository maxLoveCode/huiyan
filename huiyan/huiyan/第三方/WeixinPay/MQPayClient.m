//
//  MQPayClient.m
//  WeixinPayDemo
//
//  Created by WsdlDev on 15/10/6.
//  Copyright © 2015年 mazengyi. All rights reserved.
//

#import "MQPayClient.h"

#define WeixinUnifiedorderUrl @"https://api.mch.weixin.qq.com/pay/unifiedorder"

@interface MQPayClient ()


@property (nonatomic, copy) void(^successBlock)(NSDictionary *result);
@property (nonatomic, copy) void(^failureBlock)(NSDictionary *result);

@end

@implementation MQPayClient


- (BOOL)registerWeiXinApp:(NSString *)appid mch_id:(NSString *)mch_id mch_key:(NSString *)mch_key notifyUrl:(NSString *)notifyUrl withDescription:(NSString *)appdesc
{
    self.appId = appid;
    self.mchId = mch_id;
    self.mchKey = mch_key;
    self.notifyUrl = notifyUrl;
    return [WXApi registerApp:appid withDescription:appdesc];

}

+ (MQPayClient *)shareInstance
{
    static MQPayClient *payClientInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payClientInstance = [[MQPayClient alloc]init];
    });
    return payClientInstance;
}

+ (BOOL)weiXinHandleOpenURL:(NSURL *)url
{
   return  [WXApi handleOpenURL:url delegate:[MQPayClient shareInstance]];
}

- (void)onResp:(BaseResp *)resp
{
    switch (resp.errCode) {
        case 0:
        {
            if (self.successBlock) {
                self.successBlock(@{@"msg":@"支付成功", @"code":@0});
            }
        }
        break;
        case -1:
        {
            if (self.failureBlock) {
                 self.failureBlock(@{@"msg":@"支付失败", @"code":@(-1)});
            }
        }
        break;
        case -2:
        {
            if (self.failureBlock) {
                self.failureBlock(@{@"msg":@"支付失败，用户取消", @"code":@(-2)});
            }
        }
        break;
        default:
            break;
    }
}


- (void)weiXinPayWithTitle:(NSString *)title money:(NSString *)money tradeNo:(NSString *)tradeNo
       successBlock:(void(^)(NSDictionary *result))successBlock
       failureBlock:(void(^)(NSDictionary *result))failureBlock
{
    //随机数
    NSString *noncer_str = [NSString stringWithFormat:@"%d", arc4random()];;
    NSString *ip = [MQUntils getIPAddress:YES];
    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    parma[@"appid"] = self.appId;
    parma[@"body"] = title;
    parma[@"mch_id"] = self.mchId;
    parma[@"nonce_str"] = noncer_str;
    parma[@"notify_url"] = self.notifyUrl;
    parma[@"out_trade_no"] = tradeNo;
    parma[@"spbill_create_ip"] = ip;
    parma[@"total_fee"] = money;
    parma[@"trade_type"] = @"APP";
    NSString *reqString =  [NSString stringWithFormat:@"appid=%@&body=%@&mch_id=%@&nonce_str=%@&notify_url=%@&out_trade_no=%@&spbill_create_ip=%@&total_fee=%@&trade_type=APP&key=", self.appId, title,self.mchId, noncer_str, self.notifyUrl, tradeNo, ip, money];
    reqString = [reqString stringByAppendingString:self.mchKey];
    NSString *md5 = [MQUntils md5:reqString];
    //生成xml
    NSMutableString *reqPars=[NSMutableString string];
    NSArray *keys = parma.allKeys;
    [reqPars appendString:@"<xml>\n"];
    for (NSString *categoryId in keys) {
        [reqPars appendFormat:@"<%@>%@</%@>\n", categoryId, [parma objectForKey:categoryId],categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign>\n</xml>", md5];
    NSLog(@"respars = %@", reqPars);
    NSData *d = [MQUntils httpSend:WeixinUnifiedorderUrl method:@"post" data:reqPars];
    XMLHelper *xml  = [[XMLHelper alloc]init];
    //开始解析
    [xml startParse:d];
    NSMutableDictionary *resParams = [xml getDict];
    //判断返回
    NSLog(@"%@, %@",resParams, [resParams objectForKey:@"return_msg"]);
    NSString *return_code   = [resParams objectForKey:@"return_code"];
    NSString *result_code   = [resParams objectForKey:@"result_code"];
    if ([return_code isEqualToString:@"SUCCESS"] && [result_code isEqualToString:@"SUCCESS"]) {
        NSString *prepay_id = resParams[@"prepay_id"];
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = self.mchId;
        request.prepayId= prepay_id;
        request.package = @"Sign=WXPay";
        request.nonceStr= noncer_str;
        request.timeStamp= [NSDate date].timeIntervalSince1970;
        //计算sign
        NSString *s1=  [NSString stringWithFormat:@"appid=%@&noncestr=%@&package=Sign=WXPay&partnerid=%@&prepayid=%@&timestamp=%d&key=%@", self.appId, noncer_str, self.mchId, prepay_id, (unsigned int)request.timeStamp,self.mchKey];
        request.sign = [MQUntils md5:s1];
        self.successBlock = successBlock;
        self.failureBlock = failureBlock;
        [WXApi sendReq:request];
        
    }

}


@end
