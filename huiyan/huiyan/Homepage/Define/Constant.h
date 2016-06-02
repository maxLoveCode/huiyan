//
//  Constant.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define kScreen_Width [[UIScreen mainScreen] bounds].size.width
#define kScreen_Height [[UIScreen mainScreen] bounds].size.height

//设置颜色
#define COLOR_WITH_ARGB(a,r,g,b) [UIColor colorWithRed:\
(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define COLOR_WITH_RGB(r,g,b) [UIColor colorWithRed:\
(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define COLOR_WithAlphaHex(argb) COLOR_WITH_ARGB(\
(argb&0xFF000000)>>24, (argb&0xFF0000)>>16, (argb&0xFF00)>>8, (argb&0xFF))
#define COLOR_WithHex(rgb) COLOR_WITH_RGB(\
(rgb&0xFF0000)>>16, (rgb&0xFF00)>>8, (rgb&0xFF))
#define COLOR_THEME  COLOR_WithHex(0xe54863);
#define kMargin 15// 边距

#ifdef DEBUG
#define kServerUrl @"http://139.196.32.98/huiyan/api1_0"
#else
#define kServerUrl @"http://www.mydreamovie.com/huiyan/api1_0
#endif

/**字体设置*/
#define kFONT18  [UIFont systemFontOfSize:18]
#define kFONT17  [UIFont systemFontOfSize:17]
#define kFONT16  [UIFont systemFontOfSize:16]
#define kFONT15  [UIFont systemFontOfSize:15]
#define kFONT14  [UIFont systemFontOfSize:14]
#define kFONT13  [UIFont systemFontOfSize:13]
#define kFONT12  [UIFont systemFontOfSize:12]
#define kFONT11  [UIFont systemFontOfSize:11]
#define kFONT(s) [UIFont systemFontOfSize:s]

//偏好设置
#define kSETDEFAULTS(value,key) [[NSUserDefaults standardUserDefaults]setObject:value forKey:key]
#define kOBJECTDEFAULTS(s) [[NSUserDefaults standardUserDefaults]objectForKey:s]

#define KALERTVIEW(msg) [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show]

#ifdef DEBUG
    #define RongIMKey @"bmdehs6pd30zs"
#else
    #define RongIMKey @"pkfcgjstfl708"
#endif

#define RongIdentity @"chatToken"

#define Build @"1.1"

#endif /* Constant_h */
