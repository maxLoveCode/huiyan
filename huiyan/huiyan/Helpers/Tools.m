//
//  Tools.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/22.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(UIAlertController *)showAlert:(NSString *)mes
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    return alert;
}
@end
