//
//  ArticalViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ArticalViewController.h"
#import "Constant.h"
#import "UITabBarController+ShowHideBar.h"
#import "UITabBarController+ShowHideBar.h"
@interface ArticalViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIScrollView* bgView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *gray_view;

@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
     self.navigationItem.leftBarButtonItem.title  = @"返回";
    NSError *error;
    //图文混排
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[_originData dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                                                                      NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}documentAttributes:nil error:&error];
    
    
    NSString* formatString = [attributedString string];
    NSLog(@"%@", formatString);
    
    [self resizeImage:formatString];
    NSAttributedString *secondDecoding =[[NSAttributedString alloc] initWithData:[formatString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                                                                  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}documentAttributes:nil error:&error];
    self.textView.attributedText = secondDecoding;
    self.label.attributedText = secondDecoding;
    
    [self.label sizeToFit];
    [self.bgView addSubview:self.label];
    [self.bgView setContentSize:CGSizeMake(CGRectGetWidth(self.label.frame), CGRectGetHeight(self.label.frame))];
    [self.view addSubview:self.bgView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 10, kScreen_Width - 30, kScreen_Height  - 64)];
        _label.numberOfLines = 0;
    }
    return _label;
}

-(UIScrollView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 64)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.delegate = self;
    }
    return _bgView;
}

- (UIView *)gray_view{
    if (!_gray_view) {
        self.gray_view = [[UILabel alloc]init];
        self.gray_view.backgroundColor = [UIColor grayColor];
        [self.gray_view.layer addSublayer:[self shadowAsInverse]];
    }
    return _gray_view;
}

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, kScreen_Width,3 );
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合（颜色透明度的改变）
    newShadow.colors = [NSArray arrayWithObjects:
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor] ,
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.4] CGColor],
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.3] CGColor],
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.2] CGColor],
                        (id)[[[UIColor grayColor] colorWithAlphaComponent:0.1] CGColor],
                        nil];
    return newShadow;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y == 0) {
        [self.gray_view removeFromSuperview];
    }
    [self.view addSubview:self.gray_view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y == 0) {
        [self.gray_view removeFromSuperview];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   // CGFloat height = self.bgView.contentSize.height;
<<<<<<< HEAD
=======
   // NSLog(@"---%f---%f",scrollView.contentOffset.y,height);
>>>>>>> cad69dba4ead7dee24f5d8eaac5f5ad372591378
    if (scrollView.contentOffset.y == CGRectGetHeight(self.label.frame)) {
        
    }
}

-(NSString*)resizeImage:(NSString*)source
{
    NSAttributedString* ats = [[NSAttributedString alloc] initWithString:source];
    NSString* substring = @"<img";
    NSRange range = [[ats string] rangeOfString:substring];
    NSLog(@"range is %@", range);
    return [ats string];
}




@end
