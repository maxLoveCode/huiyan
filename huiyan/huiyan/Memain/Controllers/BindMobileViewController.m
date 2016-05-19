//
//  BindMobileViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/16.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "BindMobileViewController.h"
#import "UITabBarController+ShowHideBar.h"
#import "Constant.h"
#import "Tools.h"
#import "ServerManager.h"
#import "NSString+Md5.h"
@interface BindMobileViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDate *star;
@property (nonatomic, strong) ServerManager *serverManager;
@end

@implementation BindMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.serverManager = [ServerManager sharedInstance];
    [self setUp];
   

}

- (void)setUp{
    self.mobile_textFiield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.confirm_btn.backgroundColor = COLOR_THEME;
    self.confirm_btn.layer.masksToBounds = YES;
    self.confirm_btn.layer.cornerRadius =20;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoverKeyBorad:)];
    tapGes.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGes];
    [self.captcha_btn addTarget:self action:@selector(sendVcode) forControlEvents:UIControlEventTouchUpInside];
    [self.confirm_btn addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.autoresizesSubviews = NO;
    [self.tabBarController setHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recoverKeyBorad:(UITapGestureRecognizer *)sender{
    [self.captcha_textField resignFirstResponder];
    [self.mobile_textFiield resignFirstResponder];
    [self.passWord_textField resignFirstResponder];
}
#pragma mark -- 发送验证码=
- (void)sendVcode{
    if ([self.mobile_textFiield.text isEqualToString:@"请输入常用的手机号"] ||[self.mobile_textFiield.text isEqualToString:@""]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:^{
        }];
    }else{
        NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"mobile":self.mobile_textFiield.text,@"scene":@"third_bind"};
       // NSLog(@"%@",params);
        [self.serverManager AnimatedPOST:@"send_vcode.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == 90000) {
             //   NSLog(@"%@",responseObject[@"msg"]);
                if (!_timer) {
                    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
                    self.star = [NSDate date];
                    [self.captcha_btn setEnabled:NO];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
        }];
    }
}

- (void)fireTimer{
    [self.captcha_btn setTitle:[NSString stringWithFormat:@"(%i秒)重新获取",(int)(60 + [self.star timeIntervalSinceNow])] forState:UIControlStateDisabled];
    if (-[self.star timeIntervalSinceNow] > 60) {
        [self.timer invalidate];
        [self.captcha_btn setEnabled:YES];
        self.timer = nil;
    }
}

- (void)confirm:(UIButton *)sender{
    if ([self.mobile_textFiield.text isEqualToString:@"请输入常用的手机号"] ||[self.mobile_textFiield.text isEqualToString:@""]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:^{
        }];
    }else if ([self.captcha_textField.text isEqualToString:@"请输入验证码"] ||[self.captcha_textField.text isEqualToString:@""]){
        [self presentViewController:[Tools showAlert:@"请输入验证码"] animated:YES completion:^{
        }];
    }else if([self.passWord_textField.text isEqualToString:@"请输入密码"] ||[self.passWord_textField.text isEqualToString:@""]){
        [self presentViewController:[Tools showAlert:@"请输入密码"] animated:YES completion:^{
        }];
    }else{
        [self getCheck_vcode];
    }

}



- (void)getCheck_vcode{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"mobile":self.mobile_textFiield.text,@"vcode":self.captcha_textField.text};
    [self.serverManager AnimatedPOST:@"check_vcode.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 90010) {
            [self getThird_bindMobile];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)getThird_bindMobile{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id,@"mobile":self.mobile_textFiield.text,@"password": [NSString getMd5_32Bit_String:self.passWord_textField.text]};
    [self.serverManager AnimatedPOST:@"third_bind_mobile.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80060) {
            [self presentViewController:[Tools showAlert:@"绑定成功"] animated:YES completion:^{
            }];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
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
