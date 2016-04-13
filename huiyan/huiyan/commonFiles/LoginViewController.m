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

@interface LoginViewController ()

@property (strong,nonatomic) LoginView* mainview;

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
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)navigationBarItem
{
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style: UIBarButtonItemStylePlain target:self action:@selector(signup)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
}

@end
