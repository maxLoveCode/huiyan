//
//  MeMainViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/13.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "MeMainViewController.h"
#import "ServerManager.h"
#import "PersonMessage.h"
#import "Constant.h"
@interface MeMainViewController ()
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) PersonMessage *perData;
@end

@implementation MeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serverManager = [ServerManager sharedInstance];
    [self get_user_infoData];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 请求数据
- (void)get_user_infoData{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id};
    [self.serverManager AnimatedGET:@"get_user_info.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"]integerValue] == 80000) {
            self.perData = [PersonMessage personWithDic:responseObject[@"data"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
