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
#import "ForgotPassTableViewController.h"
#import "UMMobClick/MobClick.h"
#import <RongIMKit/RongIMKit.h>
#import "JPUSHService.h"
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
    
    
    self.view = _mainview;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController setHidden:YES];
    [super viewDidAppear:YES];
    
    NSString *launchImageName;
    if([UIScreen mainScreen].bounds.size.height > 667.0f) {
        launchImageName = @"LaunchImage-800-Portrait-736h"; // iphone6 plus
    }
    else if([UIScreen mainScreen].bounds.size.height > 568.0f) {
        launchImageName = @"LaunchImage-800-667h"; // iphone6
    }
    else if([UIScreen mainScreen].bounds.size.height > 480.0f){
        launchImageName = @"LaunchImage-700-568h";// iphone5/5plus
    } else {
        launchImageName = @"LaunchImage-700"; // iphone4 or below
    }
    UIImage *launchImage = [UIImage imageNamed:launchImageName];
    
    for (UIView* subview in [_mainview.bgView subviews]) {
        subview.alpha = 0;
        subview.hidden = YES;
    }
    
    //get the lauch screen at runtime
    NSURL *url = [NSURL URLWithString:@"http://7xsnr6.com2.z0.glb.clouddn.com/123.png"];
    
    //load online background image
    [_mainview.bgView sd_setImageWithURL:url placeholderImage:launchImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            
            //animates fate after loaded
            [UIView animateWithDuration:animateDuration*2 delay:0.0f options:UIViewAnimationOptionAllowAnimatedContent animations:^{
                UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
                _mainview.bgView.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    for (UIView* subview in [_mainview.bgView subviews]) {
                            subview.hidden = NO;
                            subview.alpha = 1;
                    }
                }];
            }];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    [_rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor],  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
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

#pragma mark - loginview delegates

-(void)loginViewDidSelectLogin:(LoginView*)loginView
{
    if ([loginView.mobile.text isEqualToString:@""] ||[loginView.mobile.text isEqualToString:@"请输入手机号"]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:nil];
        return;
    }else if ([loginView.password.text isEqualToString:@"请输入密码"] || [loginView.password.text isEqualToString:@""]){
        [self presentViewController:[Tools showAlert:@"请输入密码"] animated:YES completion:nil];
        return;
    }else{
            User* user = [[User alloc] initWithMobile:loginView.mobile.text Password:loginView.password.text];
            [self postToServerByUser:user Url:@"user_login.php" isLogin:YES];
  }
}

-(void)loginViewDidSelectSignUp:(LoginView*)loginView
{
    if ([loginView.reg_mobile.text isEqualToString:@""] ||[loginView.reg_mobile.text isEqualToString:@"请输入手机号"]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:nil];
        return;
    }else if ([loginView.vericode.text isEqualToString:@"请输入验证码"] || [loginView.vericode.text isEqualToString:@""]){
        [self presentViewController:[Tools showAlert:@"请输入验证码"] animated:YES completion:nil];
        return;
    }else if ([loginView.confirmPass.text isEqualToString:@""] || [loginView.confirmPass.text isEqualToString:@"请输入密码"]){
        [self presentViewController:[Tools showAlert:@"请输入密码"] animated:YES completion:nil];
        return;
    }else{
        NSDictionary *parmas = @{@"access_token":self.serverManager.accessToken,@"mobile":loginView.reg_mobile.text,@"vcode":loginView.vericode.text};
        [self.serverManager AnimatedPOST:@"check_vcode.php" parameters:parmas success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"]integerValue] == 90010) {
                User* user = [[User alloc] initWithMobile:loginView.reg_mobile.text Password:loginView.confirmPass.text];
                [self postToServerByUser:user Url:@"user_register.php" isLogin:NO];
            }
            else
                [self showAlert:responseObject[@"msg"]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error = %@",error);
        }];
    }
}

-(void)loginViewDidSelectForgotPassword:(LoginView *)loginView
{
    ForgotPassTableViewController* fpt = [[ForgotPassTableViewController alloc] init];
    [self.navigationController pushViewController:fpt animated:NO];
}

-(void)loginViewDidSelectVeriCode:(LoginView *)loginView
{
    [self sendVcode];
}

-(void)postToServerByUser:(User*)user Url:(NSString*)url isLogin:(BOOL)isLogin
{
    NSDictionary* dic = @{@"access_token":_serverManager.accessToken,
                          @"mobile": user.mobile,
                          @"password": [NSString getMd5_32Bit_String:user.password]};
    [_serverManager AnimatedPOST:url parameters:dic  success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (isLogin == YES) {
            if ([responseObject[@"code"] integerValue] == 70010) {
                kSETDEFAULTS([responseObject[@"data"]objectForKey:@"login_type"], @"login_type");
                kSETDEFAULTS([responseObject[@"data"]objectForKey:@"user_id"], @"user_id");
                
                kSETDEFAULTS([responseObject[@"data"] objectForKey:@"rongcloud_token"],RongIdentity);
                
                NSSet *set = [[NSSet alloc] initWithObjects:@"ios",nil];
                [JPUSHService setTags:set alias:[responseObject[@"data"] objectForKey:@"user_id"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    // NSString *callbackString =
                    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
                     [self logSet:iTags], iAlias];
                    // NSLog(@"TagsAlias回调:%@", callbackString);
                }];
                [self rongyunLogin];
                  [MobClick profileSignInWithPUID:[responseObject[@"data"]objectForKey:@"user_id"]];
                MainTabBarViewController *mainTabBar = [[MainTabBarViewController alloc]init];
                [self.navigationController presentViewController:mainTabBar animated:NO completion:^{
                }];
            }
            else
                [self showAlert:responseObject[@"msg"]];
        }else{
            if ([responseObject[@"code"] integerValue] == 70000) {
                NSLog(@"%@",responseObject[@"msg"]);
                kSETDEFAULTS([responseObject[@"data"]objectForKey:@"user_id"], @"user_id");
                 [MobClick profileSignInWithPUID:[responseObject[@"data"]objectForKey:@"user_id"]];
                kSETDEFAULTS([responseObject[@"data"]objectForKey:@"login_type"], @"login_type");
                kSETDEFAULTS([responseObject[@"data"] objectForKey:@"rongcloud_token"],RongIdentity);
                NSSet *set = [[NSSet alloc] initWithObjects:@"ios",nil];
                [JPUSHService setTags:set alias:[responseObject[@"data"] objectForKey:@"user_id"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    // NSString *callbackString =
                    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
                     [self logSet:iTags], iAlias];
                    // NSLog(@"TagsAlias回调:%@", callbackString);
                }];
                [self rongyunLogin];
                MainTabBarViewController *mainTabBar = [[MainTabBarViewController alloc]init];
                [self.navigationController presentViewController:mainTabBar animated:NO completion:^{
                }];
            }
            else
                [self showAlert:responseObject[@"msg"]];

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//verifiy the textfiled data
-(void)verification
{
    BOOL result = YES;
    if (!result) {
        [self showAlert:@""];
    }
}

- (void)sendVcode{
    if ([_mainview.reg_mobile.text isEqualToString:@"请输入手机号"] || [_mainview.reg_mobile.text isEqualToString:@""]) {
        [self presentViewController:[Tools showAlert:@"请输入手机号"] animated:YES completion:^{
        }];
    }else{

    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"mobile":self.mainview.reg_mobile.text,@"scene":@"register"};
        [self.serverManager POSTWithoutAnimation:@"send_vcode.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            [self showAlert:responseObject[@"msg"]];
            if ([responseObject[@"code"] integerValue] == 90000) {
                //  NSLog(@"%@",responseObject[@"msg"]);
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

-(void)showAlert:(NSString*)string
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:string message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)qqLogin{
    NSLog(@"qq");
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
          //  NSLog(@"%@",response);
           // NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
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
         //   NSLog(@"%@",user);
            [self getThird_loginData:user];
            
        }});
}

- (void)weixinLogin{
    NSLog(@"weixin");
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {

            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
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
            [self getThird_loginData:user];
            
        }
        
    });
}


//viewController 支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)getThird_loginData:(ThirdUser *)thirdUser{
    NSDictionary *params = @{@"access_token":self.serverManager.accessToken,@"type":thirdUser.type,@"openid":thirdUser.opnid,@"nickname":thirdUser.nickname,@"sex":thirdUser.sex,@"avatar":thirdUser.avatar};
    [self.serverManager AnimatedPOST:@"third_login.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 70020) {
            NSLog(@"data = %@",responseObject[@"data"]);
            kSETDEFAULTS([responseObject[@"data"]objectForKey:@"login_type"], @"login_type");
            kSETDEFAULTS([responseObject[@"data"] objectForKey:@"user_id"], @"user_id");
            kSETDEFAULTS([responseObject[@"data"] objectForKey:@"rongcloud_token"],RongIdentity);
            
            [self rongyunLogin];
                NSSet *set = [[NSSet alloc] initWithObjects:@"ios",nil];
                [JPUSHService setTags:set alias:[responseObject[@"data"] objectForKey:@"user_id"] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                    // NSString *callbackString =
                    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
                     [self logSet:iTags], iAlias];
                    // NSLog(@"TagsAlias回调:%@", callbackString);
                }];
            
             [MobClick profileSignInWithPUID:[responseObject[@"data"]objectForKey:@"user_id"]];
            MainTabBarViewController *mainTabBar = [[MainTabBarViewController alloc]init];
            [self.navigationController presentViewController:mainTabBar animated:NO completion:^{
            }];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

-(void)rongyunLogin
{
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:RongIdentity];
    if(token)
    {
        [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            NSLog(@"token错误");
        }];
    }
}

- (NSString *)logSet:(NSSet *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
   
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}



@end
