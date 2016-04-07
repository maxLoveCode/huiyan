//
//  ArticalViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/4/7.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ArticalViewController.h"
#import "Constant.h"

@interface ArticalViewController ()

@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIScrollView* bgView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation ArticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSError *error;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[_originData dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                                                                                      NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}documentAttributes:nil error:&error];
    
    
    NSString* formatString = [attributedString string];
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


-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.view.frame];
        _label.numberOfLines = 0;
    }
    return _label;
}

-(UIScrollView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-48)];
    }
    return _bgView;
}

@end
