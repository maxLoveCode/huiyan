//
//  SendLivigViewController.m
//  huiyan
//
//  Created by zc on 16/8/3.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "SendLivigViewController.h"
#import "MHDatePicker.h"
#import "Tools.h"
#import "ServerManager.h"
#import <UIImageView+WebCache.h>
@interface SendLivigViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *selectTime;
@property (nonatomic, strong) UIImageView *imagePic;
@property (nonatomic, strong) UIButton *selectPic;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) MHDatePicker *selectDatePicker;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSString *updatePic;
@end

@implementation SendLivigViewController
static NSString *const normalCell = @"normal";
static NSString *const timeCell = @"timeNormal";
static NSString *const picCell = @"picCell";

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.sureBtn.layer.masksToBounds = YES;
        self.sureBtn.layer.cornerRadius = 5;
        self.sureBtn.frame = CGRectMake(kMargin, CGRectGetMaxY(self.tableView.frame) + 50, kScreen_Width - 2 * kMargin, 50);
        [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sureBtn addTarget:self action:@selector(sureUpdate:) forControlEvents:UIControlEventTouchUpInside];
        self.sureBtn.backgroundColor = COLOR_THEME;
    }
    return _sureBtn;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Width + 100) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCell];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:timeCell];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:picCell];
    }
    return _tableView;
}

- (UIView *)navView{
    if (!_navView) {
        self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
        self.navView.backgroundColor = COLOR_THEME;
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        returnBtn.frame = CGRectMake(15, 20, 30, 50);
        [returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        returnBtn.titleLabel.font = kFONT14;
        [returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [returnBtn addTarget:self action:@selector(returnNav) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:returnBtn];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 30, 20, 60, 50)];
        lab.textColor = [UIColor whiteColor];
        lab.font = kFONT14;
        lab.text = @"发布直播";
        [self.navView addSubview:lab];
    }
    return _navView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sureBtn];
     [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnkeyBoard)]];
    // Do any additional setup after loading the view.
}

#pragma mark -- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return kScreen_Width;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
        UITextField *textField = [cell viewWithTag:1000];
        if (!textField) {
            textField = [[UITextField alloc]initWithFrame:CGRectMake(kMargin, 0, kScreen_Width - 2* kMargin, 50)];
            textField.placeholder = @"给你的直播写个标题吧(20字以内)";
            [cell.contentView addSubview:textField];
            textField.tag = 1000;
            self.textField = textField;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:timeCell forIndexPath:indexPath];
        UIButton *selectTime = [cell viewWithTag:1006];
        if (!selectTime) {
            selectTime = [UIButton buttonWithType:UIButtonTypeCustom];
            selectTime.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            selectTime.frame = CGRectMake(kMargin, 0, 200, 50);
            [selectTime addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
            [selectTime setTitle:@"直播时间" forState:UIControlStateNormal];
            [selectTime setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22]  forState:UIControlStateNormal];
            [cell.contentView addSubview:selectTime];
            self.selectTime = selectTime;
            selectTime.tag = 1006;
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:picCell forIndexPath:indexPath];
        UIImageView *bgView = [cell viewWithTag:1002];
        if (!bgView) {
            bgView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, kMargin, kScreen_Width - 2 * kMargin, kScreen_Width - 2* kMargin)];
            bgView.backgroundColor = COLOR_WithHex(0xe5e5e5);
            [cell.contentView addSubview:bgView];
            bgView.tag = 1002;
            self.imagePic = bgView;
        }
        UIButton *selectBtn = [cell viewWithTag:1004];
        if (!selectBtn) {
            selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectBtn.frame = CGRectMake(kMargin, kMargin, kScreen_Width - 2 * kMargin, kScreen_Width - 2* kMargin);
            [selectBtn setTitleColor:COLOR_WithHex(0x7d7d7d) forState:UIControlStateNormal];
            [selectBtn setTitle:@"观众们喜欢好看的封面哦" forState:UIControlStateNormal];
            [cell.contentView addSubview:selectBtn];
            selectBtn.tag = 1004;
            [selectBtn addTarget:self action:@selector(selectPic:) forControlEvents:UIControlEventTouchUpInside];
            self.selectPic = selectBtn;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark -- 选择图片
- (void)selectPic:(UIButton *)sender{
  
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *UIAlertAction){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *UIAlertAction){
    
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
           }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertCon animated:YES completion:nil];

}

#pragma mark------------UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage *smallImage = [self thumbnailWithImageWithoutScale:img size:CGSizeMake(100.0f, 100.0f)];
        NSData *data = UIImageJPEGRepresentation(smallImage, 1.0);
        [self getUploadImage:data];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)getUploadImage:(NSData *)image{
    NSString *urlStr = [NSString stringWithFormat:@"%@/index.php/Home/Qiniu/upload_file/access_token/%@",kServerUrl,self.serverManager.accessToken];
    NSDictionary *parameters = @{@"upload_file":image};
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:image name:@"upload_file" fileName:@"somefilename.png" mimeType:@"image/png"];// you file to upload
        
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      dispatch_async(dispatch_get_main_queue(), ^{
                          //Update the progress view
                          //[progressView setProgress:uploadProgress.fractionCompleted];
                      });
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      //    NSLog(@"msg is %@", responseObject[@"msg"]);
                      
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          //   NSLog(@"%@ %@", response, responseObject);
                          if ([responseObject[@"data"] objectForKey:@"url"] != nil) {
                              NSString *str = [responseObject[@"data"] objectForKey:@"url"];
                              NSLog(@"str = %@",str);
                              self.updatePic = str;
                              [self.imagePic sd_setImageWithURL:[NSURL URLWithString:str]];
                              self.selectPic.enabled = NO;
                              
                          }else{
                              [self presentViewController:[Tools showAlert:@"上传失败"] animated:YES completion:nil];
                          }
                          
                      }
                  }];
    
    [uploadTask resume];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//2.保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

- (void)returnkeyBoard{
    [self.view endEditing:YES];
}

- (void)returnNav{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 选择时间
- (void)changeTime:(UIButton *)sender{
      [self.textField resignFirstResponder];
    self.selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    __weak typeof(self) weakSelf = self;
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        //        NSString *string = [NSString stringWithFormat:@"%@",[NSDate dateWithTimeInterval:3600*8 sinceDate:selectedDate]];
        //        weakSelf.myLabel2.text = string;
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sender setTitle:[weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    }];
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

#pragma mark --上传直播预告
- (void)sureUpdate:(UIButton *)sender{
    if ([self.textField.text isEqualToString:@""] || [self.textField.text isEqualToString:@"给你的直播写个标题吧(20字以内)"] ) {
        [self presentViewController:[Tools showAlert:@"请输入您要直播的标题"] animated:YES completion:nil];
    }else if([self.selectTime.currentTitle isEqualToString:@"直播时间"]){
        [self presentViewController:[Tools showAlert:@"请选择您要直播的时间"] animated:YES completion:nil];
    }else if(self.updatePic == nil || [self.updatePic isEqualToString:@""]){
        [self presentViewController:[Tools showAlert:@"请选择您要直播的封面"] animated:YES completion:nil];
    }else{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":[[NSUserDefaults   standardUserDefaults]objectForKey:@"user_id"],@"title":self.textField.text,@"time":self.selectTime.currentTitle,@"cover":self.updatePic};
    [self.serverManager POSTWithoutAnimation:@"publish_webcast.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 130000) {
            [self presentViewController:[Tools showAlert:@"上传成功"] animated:YES completion:nil];
            [self dismissViewControllerAnimated:NO completion:^{
                
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZCLog(@"%@",error);
    }];
    }
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
