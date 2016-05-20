//
//  UnBindMobileViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/16.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "UnBindMobileViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import "Tools.h"
@interface UnBindMobileViewController ()
@property (nonatomic, strong) UILabel *captcha_lab;
@property (nonatomic, strong) UITextField *captcha_textField;
@property (nonatomic, strong) UIButton *captcha_btn;
@property (nonatomic, strong) UILabel *explain_lab;
@property (nonatomic, strong) UILabel *h_lab;
@property (nonatomic, strong) UILabel *w_lab;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDate *star;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, assign) BOOL bind_type;

@end

@implementation UnBindMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.serverManager = [ServerManager sharedInstance];
    [self setUp];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
    [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.bind_type = NO;
    self.view.autoresizesSubviews = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)setUp{
    NSRange range = NSMakeRange(3, 5);
    NSString *mobile = [self.mobile stringByReplacingCharactersInRange:range withString:@"*****"];
    self.mobile_lab.text = mobile;
    self.UnBind.backgroundColor = COLOR_THEME;
    self.UnBind.layer.masksToBounds = YES;
    self.UnBind.layer.cornerRadius = 20;
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoverKeyBorad:)];
    tapGes.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGes];
    [self.view addSubview:self.bind_view];
    [self.UnBind addTarget:self action:@selector(unbind:) forControlEvents:UIControlEventTouchUpInside];
}

- (UIView *)bind_view{
    if (!_bind_view) {
        self.bind_view = [[UIView alloc]initWithFrame:CGRectMake( kScreen_Width, CGRectGetMaxY(self.mobile_lab.frame) + 20, kScreen_Width, 80)];
        [self.bind_view addSubview:self.captcha_lab];
        [self.bind_view addSubview:self.captcha_textField];
        [self.bind_view addSubview:self.captcha_btn];
        [self.bind_view addSubview:self.h_lab];
        [self.bind_view addSubview:self.w_lab];
        [self.bind_view addSubview:self.explain_lab];
        
    }
    return _bind_view;
}

- (UIButton *)captcha_btn{
    if (!_captcha_btn) {
        self.captcha_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.captcha_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.captcha_btn.frame = CGRectMake(kScreen_Width - 100 - 15, 0, 100, 20);
        [self.captcha_btn addTarget:self action:@selector(sendVcode) forControlEvents:UIControlEventTouchUpInside];
        [self.captcha_btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.captcha_btn.titleLabel.font = kFONT14;
    }
    return _captcha_btn;
}

- (UILabel *)captcha_lab{
    if (!_captcha_lab) {
        self.captcha_lab = [[UILabel alloc]init];
        self.captcha_lab.text = @"验证码";
        self.captcha_lab.font = kFONT14;
          self.captcha_lab.frame = CGRectMake(kMargin, 0, 50, 20);
    }
    return _captcha_lab;
}

- (UITextField *)captcha_textField{
    if (!_captcha_textField) {
        self.captcha_textField = [[UITextField alloc]init];
        self.captcha_textField.placeholder = @"短信验证码";
        self.captcha_textField.font = kFONT14;
        self.captcha_textField.keyboardType = UIKeyboardTypeNumberPad;
        self.captcha_textField.frame = CGRectMake(CGRectGetMaxX(self.captcha_lab.frame) + 20, 0,kScreen_Width - 100, 20);
    }
    return _captcha_textField;
}

- (UILabel *)explain_lab{
    if (!_explain_lab) {
        self.explain_lab = [[UILabel alloc]init];
        self.explain_lab.font = kFONT14;
        self.explain_lab.text = @"(请及时填写短信验证码并完成手机解绑操作)";
        self.explain_lab.frame = CGRectMake(kMargin, CGRectGetMaxY(self.captcha_lab.frame) + 20, kScreen_Width, 20);
    }
    return _explain_lab;
}

- (UILabel *)h_lab{
    if (!_h_lab) {
        self.h_lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.captcha_btn.frame), 0, 1, 20)];
        self.h_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _h_lab;
}

- (UILabel *)w_lab{
    if (!_w_lab) {
        self.w_lab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, CGRectGetMaxY(self.captcha_lab.frame) + 10, kScreen_Width - 2 * kMargin, 1)];
        self.w_lab.backgroundColor = COLOR_WithHex(0xdddddd);
    }
    return _w_lab;
}

- (void)unbind:(UIButton *)sender{
    if (self.bind_type == NO) {
        [UIView animateWithDuration:1.0 animations:^{
            [self.bind_view setFrame:CGRectMake(0, CGRectGetMaxY(self.mobile_lab.frame) + 20, kScreen_Width, 80)];
            self.text_lab.hidden = YES;
        }];
        self.bind_type = YES;
    }else{
        if ([self.captcha_textField.text isEqualToString:@""] || [self.captcha_textField.text isEqualToString:@"短信验证码"]) {
            [self presentViewController:[Tools showAlert:@"请输入验证码"] animated:YES completion:nil];
        }else{
        [self getCheck_vcode];
        }
    }
    
}

- (void)recoverKeyBorad:(UITapGestureRecognizer *)sender{
    [self.captcha_textField resignFirstResponder];
}

#pragma mark -- 发送验证码=
- (void)sendVcode{
        NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"mobile":self.mobile,@"scene":@"unbind"};
        NSLog(@"%@",params);
        [self.serverManager AnimatedPOST:@"send_vcode.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue] == 90000) {
                NSLog(@"%@",responseObject[@"msg"]);
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

- (void)fireTimer{
    [self.captcha_btn setTitle:[NSString stringWithFormat:@"(%i秒)重新获取",(int)(60 + [self.star timeIntervalSinceNow])] forState:UIControlStateDisabled];
    if (-[self.star timeIntervalSinceNow] > 60) {
        [self.timer invalidate];
        [self.captcha_btn setEnabled:YES];
        self.timer = nil;
    }
}

- (void)getCheck_vcode{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"mobile":self.mobile,@"vcode":self.captcha_textField.text};
    [self.serverManager AnimatedPOST:@"check_vcode.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 90010) {
            [self getThird_unbindMobile];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)getThird_unbindMobile{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id,@"mobile":self.mobile};
    [self.serverManager AnimatedPOST:@"third_unbind_mobile.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 80070) {
             [self.navigationController popViewControllerAnimated:YES];
            [self presentViewController:[Tools showAlert:@"解绑成功"] animated:YES completion:^{
            }];
           
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}\


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
