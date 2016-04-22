//
//  LoginViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "LoginViewController.h"
#import "UIImageView+Webcache.h"
#import "UIImage+ImageEffects.h"
#import "LoginView.h"
#import "Constant.h"
#import "UITabBarController+ShowHideBar.h"
#import "User.h"
#import "ServerManager.h"
#import "MainTabBarViewController.h"
#import "NSString+Md5.h"
#import "UMSocial.h"
#import "ThirdUser.h"
#import "Tools.h"
#import <AFNetworking.h>
#define animateDuration 0.25
#define animateDelay 0.2

@interface LoginViewController () <LoginViewEvents>

@property (strong,nonatomic) LoginView* mainview;
@property (strong,nonatomic) UIBarButtonItem* rightItem;
@property (strong,nonatomic) ServerManager* serverManager;
@property (nonatomic, strong) NSTimer *thetimer;
@property (nonatomic, strong) NSDate *star;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登  录";
    _serverManager = [ServerManager sharedInstance];
    
    _mainview = [[LoginView alloc] initWithFrame:self.view.frame];
    _mainview.delegate = self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    [self navigationBarItem];

    NSURL *url = [NSURL URLWithString:@"http://7xsnr6.com2.z0.glb.clouddn.com/123.png"];
    [_mainview.bgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
         _mainview.bgView.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
        
    }];
    
    self.view = _mainview;
    [self.mainview.timer addTarget:self action:@selector(sendVcode) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
    self.navigationController.navigationBar.translucent = NO;
}

-(void)signup
{
    [self signUpAnimates];
}


-(void)navigationBarItem
{
    _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style: UIBarButtonItemStylePlain target:self action:@selector(signup)];
    _rightItem.tag = -1;
    self.navigationItem.rightBarButtonItem = _rightItem;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}

-(void)signUpAnimates
{
   
    [UIView animateWithDuration:animateDuration animations:^{
        [self.mainview.u_mobile setFrame:CGRectOffset(self.mainview.u_mobile.frame, _rightItem.tag*kScreen_Width, 0)];
        if (_rightItem.tag == -1) {
            self.title = @"注  册";
            _rightItem.title = @"登  录";
        }
        else
        {
            self.title = @"登  录";
            _rightItem.title = @"注  册";
        }
        
    }];
    
    [UIView animateWithDuration:animateDuration delay:animateDelay options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.mainview.u_pass_veri setFrame:CGRectOffset(self.mainview.u_pass_veri.frame, _rightItem.tag*kScreen_Width, 0)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:animateDuration delay:animateDelay*2 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.mainview.thirdPart setFrame:CGRectOffset(self.mainview.thirdPart.frame, _rightItem.tag*kScreen_Width, 0)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:animateDuration delay:animateDelay*3 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.mainview.lastPart setFrame:CGRectOffset(self.mainview.lastPart.frame, _rightItem.tag*kScreen_Width, 0)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:animateDuration delay:animateDelay*3 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        [self.mainview.QQ setFrame:CGRectOffset(self.mainview.QQ.frame, _rightItem.tag*kScreen_Width, 0)];
        [self.mainview.weiXin setFrame:CGRectOffset(self.mainview.weiXin.frame, _rightItem.tag*kScreen_Width, 0)];
        [self.mainview.thirdParty setFrame:CGRectOffset(self.mainview.thirdParty.frame, _rightItem.tag*kScreen_Width, 0)];
    } completion:^(BOOL finished) {
        
    }];
    
    _rightItem.tag = -_rightItem.tag;
}

-(void)loginViewDidSelectLogin:(LoginView*)loginView
{
    if ([loginView.mobile.text isEqualToString:@""] ||[loginView.mobile.text isEqualToString:@"请输入手机号"]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:^{
        }];
        return;
    }else if ([loginView.password.text isEqualToString:@"请输入密码"] || [loginView.password.text isEqualToString:@""]){
        [self presentViewController:[Tools showAlert:@"请输入密码"] animated:YES completion:^{
        }];
        return;
    }else{
            User* user = [[User alloc] initWithMobile:loginView.mobile.text Password:loginView.password.text];
            [self postToServerByUser:user Url:@"user_login.php" isLogin:YES];
  }
}

-(void)loginViewDidSelectSignUp:(LoginView*)loginView
{
     //NSLog(@"select2");
    if ([loginView.reg_mobile.text isEqualToString:@""] ||[loginView.reg_mobile.text isEqualToString:@"请输入手机号"]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:^{
        }];
        return;
    }else if ([loginView.vericode.text isEqualToString:@"请输入验证码"] || [loginView.vericode.text isEqualToString:@""]){
        [self presentViewController:[Tools showAlert:@"请输入验证码"] animated:YES completion:^{
        }];
        return;
    }else if ([loginView.confirmPass.text isEqualToString:@""] || [loginView.confirmPass.text isEqualToString:@"请输入密码"]){
        [self presentViewController:[Tools showAlert:@"请输入密码"] animated:YES completion:^{
        }];
        return;
    }else{
        NSDictionary *parmas = @{@"access_token":self.serverManager.accessToken,@"mobile":loginView.reg_mobile.text,@"vcode":loginView.vericode.text};
        [self.serverManager AnimatedPOST:@"check_vcode.php" parameters:parmas success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"]integerValue] == 90010) {
                NSLog(@"%@",responseObject[@"msg"]);
                User* user = [[User alloc] initWithMobile:loginView.reg_mobile.text Password:loginView.confirmPass.text];
                [self postToServerByUser:user Url:@"user_register.php" isLogin:NO];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
        }];
    }
    
    
    
   
}


-(void)postToServerByUser:(User*)user Url:(NSString*)url isLogin:(BOOL)isLogin
{
    NSDictionary* dic = @{@"access_token":_serverManager.accessToken,
                          @"mobile": user.mobile,
                          @"password": [NSString getMd5_32Bit_String:user.password]};
    [_serverManager AnimatedPOST:url parameters:dic  success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject[@"msg"]);
        if (isLogin == YES) {
            if ([responseObject[@"code"] integerValue] == 70010) {
                NSLog(@"%@",responseObject[@"msg"]);
                kSETDEFAULTS([responseObject[@"data"]objectForKey:@"user_id"], @"user_id");
                MainTabBarViewController *mainTabBar = [[MainTabBarViewController alloc]init];
                [self.navigationController presentViewController:mainTabBar animated:NO completion:^{
                }];
            }
        }else{
            if ([responseObject[@"code"] integerValue] == 70000) {
                NSLog(@"%@",responseObject[@"msg"]);
                kSETDEFAULTS([responseObject[@"data"]objectForKey:@"user_id"], @"user_id");
                MainTabBarViewController *mainTabBar = [[MainTabBarViewController alloc]init];
                [self.navigationController presentViewController:mainTabBar animated:NO completion:^{
                }];
            }

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//verifiy the textfiled data
-(void)verification
{
    BOOL result = YES;
    if (!result) {
        [self showAlert];
    }
}

- (void)sendVcode{
    if ([_mainview.reg_mobile.text isEqualToString:@"请输入手机号"] || [_mainview.reg_mobile.text isEqualToString:@""]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:^{
        }];
    }else{

    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"mobile":self.mainview.reg_mobile.text,@"scene":@"register"};
        NSLog(@"%@",params);
    [self.serverManager AnimatedPOST:@"send_vcode.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 90000) {
            NSLog(@"%@",responseObject[@"msg"]);
            if (!_thetimer) {
                self.thetimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
                self.star = [NSDate date];
                [_mainview.timer setEnabled:NO];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    }
}

- (void)fireTimer{
    [_mainview.timer setTitle:[NSString stringWithFormat:@"%i秒",(int)(60 + [self.star timeIntervalSinceNow])] forState:UIControlStateDisabled];
    if (-[self.star timeIntervalSinceNow] > 60) {
        [self.thetimer invalidate];
        [_mainview.timer setEnabled:YES];
        self.thetimer = nil;
    }
}

-(void)showAlert
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)qqLand{
    NSLog(@"qq");
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            NSLog(@"%@",response);
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            NSString *sex = @"0";
            if ([response.thirdPlatformUserProfile[@"gender"] isEqualToString:@"男"]) {
                sex = @"1";
            }else{
                sex = @"2";
            }
            ThirdUser *user = [[ThirdUser alloc]init];
            user.type = @"qq";
            user.opnid = snsAccount.openId;
            user.nickname = snsAccount.userName;
            user.sex = sex;
            user.avatar = snsAccount.iconURL;
            NSLog(@"%@",user);
            [self getThird_loginData:user];
            
        }});
}

- (void)weixinLand{
    NSLog(@"weixin");
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {

            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
              NSLog(@"------%@",[snsAccount description]);
            NSString *const UMSCustomAccountGenderMale;
            NSString *const UMSCustomAccountGenderFeMale;
            NSLog(@"---%@---%@",UMSCustomAccountGenderMale,UMSCustomAccountGenderFeMale);
            NSString *sex = @"0";
            if ([response.thirdPlatformUserProfile[@"sex"] integerValue]  == 1) {
                sex = @"1";
            }else{
                sex = @"2";
            }
            ThirdUser *user = [[ThirdUser alloc]init];
            user.type = @"wx";
            user.opnid = snsAccount.openId;
            user.nickname = snsAccount.userName;
            user.sex = sex;
            user.avatar = snsAccount.iconURL;
            NSLog(@"%@",user);
            [self getThird_loginData:user];
            
        }
        
    });
    
    
}



- (void)getThird_loginData:(ThirdUser *)thirdUser{
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"type":thirdUser.type,@"openid":thirdUser.opnid,@"nickname":thirdUser.nickname,@"sex":thirdUser.sex,@"avatar":thirdUser.avatar};
    [self.serverManager AnimatedPOST:@"third_login.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 70020) {
            NSLog(@"data = %@",responseObject[@"data"]);
            kSETDEFAULTS([responseObject[@"data"] objectForKey:@"user_id"], @"user_id");
            MainTabBarViewController *mainTabBar = [[MainTabBarViewController alloc]init];
            [self.navigationController presentViewController:mainTabBar animated:NO completion:^{
            }];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}


@end
