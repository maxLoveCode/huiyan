//
//  WriteCommentViewController.m
//  huiyan
//
//  Created by zc on 16/5/30.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "WriteCommentViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "Tools.h"
@interface WriteCommentViewController ()
@property (nonatomic, strong)UITextView *writeField;
@property (nonatomic, strong)ServerManager *serverManager;
@property (nonatomic, strong)UIButton *confirmBtn;
@end

@implementation WriteCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self.view addSubview:self.writeField];
    [self.view addSubview:self.confirmBtn];
    self.serverManager = [ServerManager sharedInstance];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recoverKeyBorad:)];
    tapGes.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGes];

    // Do any additional setup after loading the view.
}

- (UITextView *)writeField{
    if (!_writeField) {
        self.writeField = [[UITextView alloc]initWithFrame:CGRectMake(15, 50, kScreen_Width - 30, 200)];
        self.writeField.returnKeyType = UIReturnKeyDefault;//返回键的类型
        
        self.writeField.keyboardType = UIKeyboardTypeDefault;//键盘类型
        
    }
    return _writeField;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmBtn.backgroundColor = COLOR_THEME;
        [self.confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
        self.confirmBtn.layer.masksToBounds = YES;
        self.confirmBtn.layer.cornerRadius = 5;
        self.confirmBtn.frame = CGRectMake(15, CGRectGetMaxY(self.writeField.frame)+ 50, kScreen_Width - 30, 40);
        [self.confirmBtn addTarget:self action:@selector(WriteComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (void)WriteComment:(UIButton *)sender{
    if (self.writeField.text != nil && ![self.writeField.text isEqualToString:@""]) {
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"did":self.starVideo.ID,@"comment":self.writeField.text};
    [self.serverManager AnimatedPOST:@"write_dongtai_comment.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 50070) {
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"评论成功" preferredStyle:UIAlertControllerStyleActionSheet];
            [alertCon addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:NO];
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
        }else{
            [self presentViewController:[Tools showAlert:responseObject[@"msg"]] animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
    }
}

- (void)recoverKeyBorad:(UITapGestureRecognizer *)sender{
    [self.writeField resignFirstResponder];
}

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
