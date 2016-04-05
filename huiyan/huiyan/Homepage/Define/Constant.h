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

#define COLOR_WITH_ARGB(a,r,g,b) [UIColor colorWithRed:\
(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define COLOR_WITH_RGB(r,g,b) [UIColor colorWithRed:\
(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define COLOR_WithAlphaHex(argb) COLOR_WITH_ARGB(\
(argb&0xFF000000)>>24, (argb&0xFF0000)>>16, (argb&0xFF00)>>8, (argb&0xFF))
#define COLOR_WithHex(rgb) COLOR_WITH_RGB(\
(rgb&0xFF0000)>>16, (rgb&0xFF00)>>8, (rgb&0xFF))

#define kTitleBGColor [UIColor colorWithHexString:@"020202"]
#define kViewBGColor [UIColor colorWithHexString:@"efefef"]
#define kTitleBlackColor [UIColor colorWithRed:47 green:47 blue:47 alpha:1.0]
#define kTitleGrayColor [UIColor colorWithRed:181 green:181 blue:181 alpha:1.0]
#define kNavigationColor [UIColor colorWithRed:224 green:48 blue:63 alpha:1.0]


#define kViewBGColor [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:239 / 255.0 alpha:1.0]
#define kTitleBlackColor [UIColor colorWithRed:47 / 255.0 green:47/ 255.0 blue:47 / 255.0 alpha:1.0]
#define kTitlrGrayColor [UIColor colorWithRed:181 / 255.0 green:181 / 255.0blue:181 / 255.0 alpha:1.0]
#define kNavigationColor [UIColor colorWithRed:224 / 255.0 green:48 / 255.0 blue:63 / 255.0 alpha:1.0]
#define kTitleColor [UIColor colorWithRed:66 / 255.0 green:66 / 255.0 blue:66 / 255.0 alpha:1.0]

#define kMargin 15// 边距

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


#endif /* Constant_h */
