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

#define animateDuration 0.25
#define animateDelay 0.2

@interface LoginViewController ()

@property (strong,nonatomic) LoginView* mainview;
@property (strong,nonatomic) UIBarButtonItem* rightItem;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登  录";
    
    _mainview = [[LoginView alloc] initWithFrame:self.view.frame];
    
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
}

-(void)signup
{
    [self signUpAnimates];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)navigationBarItem
{
    _rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style: UIBarButtonItemStylePlain target:self action:@selector(signup)];
    _rightItem.tag = -1;
    self.navigationItem.rightBarButtonItem = _rightItem;
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
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

@end
