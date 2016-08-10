//
//  PostActivityController.m
//  huiyan
//
//  Created by zc on 16/8/1.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "PostActivityController.h"
#import "UITextField+ZCExtension.h"
#import "MHDatePicker.h"
#import "Tools.h"
#import <ELCImagePickerController.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
@interface PostActivityController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ELCImagePickerControllerDelegate>
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *secondTitleArr;
@property (nonatomic, strong) NSArray *detailArr;
@property (nonatomic, strong) NSArray *secondDetailArr;
@property (nonatomic, strong) UIView *selectTimeView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView  *navView;
@property (nonatomic, strong) UITextField *title_textField;
@property (nonatomic, strong) UIButton *deadlineBtn;
@property (nonatomic, strong) MHDatePicker *selectDatePicker;
@property (nonatomic, strong) UITextField *address_textField;
@property (nonatomic, strong) UITextField *price_textField;
@property (nonatomic, strong) UITextField *peopleCount_textField;
@property (nonatomic, strong) UITextField *peopleMax_textField;
@property (nonatomic, strong) UITextView *activityDes_textView;
@property (nonatomic, strong) UIImageView *addCover;
@property (nonatomic, strong) UIImageView *addMuchPic;
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *endBtn;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSMutableArray *imagePicArr;
@property (nonatomic, strong) NSString *imagePic;
@property (nonatomic, strong) NSString *oneAndMore;
@end

@implementation PostActivityController
static NSString *const normalCell = @"normal";
static NSString *const timeCell = @"timeNormal";
static NSString *const picCell = @"picCell";
#define kImagePic kScreen_Width / 3 - 15
- (UITextField *)price_textField{
    if (!_price_textField) {
        self.price_textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.price_textField.placeholder = @"请填写活动价格";
        self.price_textField.textAlignment = NSTextAlignmentRight;
        self.price_textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    return _price_textField;
}

- (UITextField *)peopleCount_textField{
    if (!_peopleCount_textField) {
        self.peopleCount_textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.peopleCount_textField.placeholder = @"如无限制，请输入“0“";
        self.peopleCount_textField.textAlignment = NSTextAlignmentRight;
        self.peopleCount_textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _peopleCount_textField;
}

- (UITextField *)peopleMax_textField{
    if (!_peopleMax_textField) {
        self.peopleMax_textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.peopleMax_textField.placeholder = @"请填写报名人数上限";
        self.peopleMax_textField.textAlignment = NSTextAlignmentRight;
        self.peopleMax_textField.keyboardType = UIKeyboardTypePhonePad;
    }
    return _peopleMax_textField;
}

- (UITextField *)address_textField{
    if (!_address_textField) {
        self.address_textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.address_textField.placeholder = @"请填写活动地址";
        self.address_textField.textAlignment = NSTextAlignmentRight;
    }
    return _address_textField;
}

- (UITextField *)title_textField{
    if (!_title_textField) {
        self.title_textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        self.title_textField.placeholder = @"如暑假京剧夏令营培训";
        self.title_textField.textAlignment = NSTextAlignmentRight;
        self.title_textField.returnKeyType = UIReturnKeyDefault;
    }
    return _title_textField;
}

- (UIButton *)deadlineBtn{
    if (!_deadlineBtn) {
        self.deadlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deadlineBtn.frame = CGRectMake(0, 0, 200, 50);
        [self.deadlineBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forState:UIControlStateNormal];
        self.deadlineBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.deadlineBtn setTitle:@"请选择报名截止时间" forState:UIControlStateNormal];
        [self.deadlineBtn addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deadlineBtn;
}

- (UIView *)navView{
    if (!_navView) {
        self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 64)];
        self.navView.backgroundColor = COLOR_THEME;
        UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        returnBtn.frame = CGRectMake(15, 20, 30, 50);
        [returnBtn setImage:[UIImage imageNamed:@"returnBack"] forState:UIControlStateNormal];
        [returnBtn addTarget:self action:@selector(returnNav) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:returnBtn];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 30, 20, 60, 50)];
        lab.textColor = [UIColor whiteColor];
        lab.font = kFONT14;
         lab.text = @"活动发布";
        [self.navView addSubview:lab];
        UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        postBtn.frame = CGRectMake(kScreen_Width - 65, 20, 60, 50);
        [postBtn setTitle:@"发布" forState:UIControlStateNormal];
        postBtn.titleLabel.font = kFONT14;
        [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [postBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:postBtn];
        self.navView.userInteractionEnabled = YES;
        [self.navView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnkeyBoard)]];
    }
    return _navView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCell];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:timeCell];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:picCell];
        [self.tableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnkeyBoard)]];
    }
    return _tableView;
}

- (UIView *)selectTimeView{
    if (!_selectTimeView) {
        self.selectTimeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 190, 50)];
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame = CGRectMake(0, 0, 80, 50);
        [startBtn setTitle:@"开始日期" forState:UIControlStateNormal];
        startBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        startBtn.titleLabel.font = kFONT14;
        [startBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forState:UIControlStateNormal];
        [self.selectTimeView addSubview:startBtn];
        [startBtn addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
        self.startBtn = startBtn;
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(85, 0, 20, 50)];
        lab.text = @"至";
        [self.selectTimeView addSubview:lab];
        UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        endBtn.frame = CGRectMake(110, 0, 80, 50);
        [endBtn setTitle:@"结束日期" forState:UIControlStateNormal];
        endBtn.titleLabel.font = kFONT14;
        [endBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forState:UIControlStateNormal];
        [self.selectTimeView addSubview:endBtn];
        [endBtn addTarget:self action:@selector(changeTime:) forControlEvents:UIControlEventTouchUpInside];
        self.endBtn = endBtn;
    }
    return _selectTimeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    self.serverManager = [ServerManager sharedInstance];
    self.imagePicArr = [NSMutableArray array];
    self.tabBarItem.title = @"活动发布";
    self.titleArr  = @[@"活动主题",@"截止日期",@"活动时间",@"活动地点",@"活动价格"];
    self.secondTitleArr = @[@"开团人数",@"报名上限"];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.tableView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 2;
            break;
        default:
            return 1;
            break;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 132;
    }else if (indexPath.section == 3){
        return kScreen_Width / 3 + 50;
    }else if (indexPath.section == 4){
        if (self.imagePicArr.count >= 6) {
            return kScreen_Width + 50;
        }else if (self.imagePicArr.count >= 3){
            return kScreen_Width / 3 * 2 + 50;
        }else
        return kScreen_Width / 3  + 50 ;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderAtIndexPath:(NSIndexPath *)indexPath{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row != 2) {
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.titleArr[indexPath.row];
            if (indexPath.row == 0) {
                cell.accessoryView = self.title_textField;
            }else if(indexPath.row == 1){
                cell.accessoryView = self.deadlineBtn;
            }else if(indexPath.row == 3){
                cell.accessoryView = self.address_textField;
            }else{
                cell.accessoryView = self.price_textField;
            }
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:timeCell forIndexPath:indexPath];
            cell.textLabel.text = self.titleArr[indexPath.row];
            cell.accessoryView = self.selectTimeView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }else if(indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
        cell.textLabel.text = self.secondTitleArr[indexPath.row];
        if (indexPath.row == 0) {
            cell.accessoryView = self.peopleCount_textField;
        }else{
            cell.accessoryView = self.peopleMax_textField;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLab = [cell viewWithTag:1000];
        if (!titleLab) {
            titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
            titleLab.text = @"活动简介";
            titleLab.font = kFONT14;
            [cell.contentView addSubview:titleLab];
            titleLab.tag = 1000;
        }
        UITextView  *textView = [cell viewWithTag:1002];
        if (!textView) {
            textView = [[UITextView alloc]initWithFrame:CGRectMake(kMargin, 50, kScreen_Width - 30, 132 - 50)];
            textView.textColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
            textView.text = @"详细介绍下活动的内容，例如活动内容，活动安排等";
            textView.delegate = self;
            [cell.contentView addSubview:textView];
            textView.tag = 1002;
            self.activityDes_textView = textView;
        }
        return cell;
    }else if (indexPath.section == 3){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:picCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLab = [cell viewWithTag:1004];
        if (!titleLab) {
            titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
            titleLab.text = @"活动封面";
            titleLab.font = kFONT14;
            [cell.contentView addSubview:titleLab];
            titleLab.tag = 1004;
        }
        UIImageView *addCover = [cell viewWithTag:1006];
        if (!addCover) {
            addCover = [[UIImageView alloc]init];;
            addCover.frame = CGRectMake(kMargin, 50, kImagePic, kImagePic);
              addCover.image = [UIImage imageNamed:@"addactivityPic"];
            [cell.contentView addSubview:addCover];
            addCover.tag = 1006;
            addCover.userInteractionEnabled = YES;
            [addCover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postCover:)]];
             self.addCover = addCover;
        }
        if (self.imagePic) {
            [self.addCover sd_setImageWithURL:[NSURL URLWithString:self.imagePic] placeholderImage:nil];
        }
       

        return cell;
        
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:picCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *titleLab = [cell viewWithTag:1008];
        if (!titleLab) {
            titleLab = [[UILabel alloc]initWithFrame:CGRectMake(kMargin, 0, 100, 50)];
            titleLab.font = kFONT14;
            [cell.contentView addSubview:titleLab];
            titleLab.tag = 1008;
        }
          titleLab.text = [NSString stringWithFormat:@"宣传图片(%zd/9)",self.imagePicArr.count];
         NSInteger count = self.imagePicArr.count;
        if (count > 0) {
            for (int i = 0; i < count; i++) {
                UIImageView *imagePic = [[UIImageView alloc]init];
                imagePic.frame = CGRectMake(i % 3  * (kImagePic + 10) + 10, i / 3 * (kImagePic + 10) + 60 , kImagePic,kImagePic);
                [imagePic sd_setImageWithURL:[NSURL URLWithString:self.imagePicArr[i]] placeholderImage:nil];
                imagePic.backgroundColor = [UIColor redColor];
                [cell.contentView addSubview:imagePic];
            }
            
        }
        if (count != 9) {
            UIImageView *addCover = [cell viewWithTag:1010];
            if (!addCover) {
                addCover = [[UIImageView alloc]init];
                  addCover.image = [UIImage imageNamed:@"addactivityPic"];
                [cell.contentView addSubview:addCover];
                addCover.tag = 1010;
                addCover.userInteractionEnabled = YES;
                [addCover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(postCover:)]];
                self.addMuchPic = addCover;
            }
             addCover.frame = CGRectMake(count % 3 * (kImagePic + 10) + 10, count / 3 * (kImagePic + 10) + 60, kImagePic, kImagePic);
        }
       
        return cell;
    }
}

#pragma mark -- 上传数据
- (void)postData{
    if ([self.title_textField.text isEqualToString:@""] || [self.title_textField.text isEqualToString:@"如暑假京剧夏令营培训"]) {
        [self presentViewController:[Tools showAlert:@"请输入活动主题"] animated:YES completion:nil];
    }else if ([self.deadlineBtn.currentTitle isEqualToString:@"请选择报名截止时间"]){
        [self presentViewController:[Tools showAlert:@"请输入报名截止时间"] animated:YES completion:nil];
    }else if ([self.startBtn.currentTitle isEqualToString:@"开始日期"]){
        [self presentViewController:[Tools showAlert:@"请输入开始日期"] animated:YES completion:nil];
    }else if([self.endBtn.currentTitle isEqualToString:@"结束日期"]){
        [self presentViewController:[Tools showAlert:@"请输入结束日期"] animated:YES completion:nil];

    }else if ([self.address_textField.text isEqualToString:@""] || [self.address_textField.text isEqualToString:@"请填写活动地址"]){
        [self presentViewController:[Tools showAlert:@"请输入活动地址"] animated:YES completion:nil];
    }else if ([self.price_textField.text isEqualToString:@""] || [self.price_textField.text isEqualToString:@"请填写活动价格"]){
        [self presentViewController:[Tools showAlert:@"请输入活动价格"] animated:YES completion:nil];
    }else if ([self.peopleCount_textField.text isEqualToString:@""] || [self.peopleCount_textField.text isEqualToString:@"如无限制，请输入“0“"]){
        [self presentViewController:[Tools showAlert:@"请输入开团人数"] animated:YES completion:nil];
    }else if ([self.peopleMax_textField.text isEqualToString:@""] || [self.peopleMax_textField.text isEqualToString:@"请填写报名人数上限"]){
        [self presentViewController:[Tools showAlert:@"请输入报名人数上限"] animated:YES completion:nil];
    }else if ([self.activityDes_textView.text isEqualToString:@""] || [self.activityDes_textView.text isEqualToString:@"详细介绍下活动的内容，例如活动内容，活动安排等"]){
        [self presentViewController:[Tools showAlert:@"请填写活动简介"] animated:YES completion:nil];
    }else if ([self.imagePic isEqualToString:@""] || self.imagePic == nil){
        [self presentViewController:[Tools showAlert:@"请添加活动封面"] animated:YES completion:nil];
    }else{
    NSDictionary *paramers = @{@"access_token":self.serverManager.accessToken,@"user_id":[[NSUserDefaults standardUserDefaults]objectForKey:@"user_id"],@"title":self.title_textField.text,@"bm_deadline":self.deadlineBtn.currentTitle,@"date":[NSString stringWithFormat:@"%@-%@",self.startBtn.currentTitle,self.endBtn.currentTitle],@"address":self.address_textField.text,@"price":self.price_textField.text,@"begin_count":self.peopleCount_textField.text,@"end_count":self.peopleMax_textField.text,@"content":self.activityDes_textView.text,@"cover":self.imagePic,@"imgs":self.imagePicArr};
    [self.serverManager POSTWithoutAnimation:@"publish_train.php" parameters:paramers success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 40030) {
            [self dismissViewControllerAnimated:NO completion:^{
                [self presentViewController:[Tools showAlert:@"发布成功"] animated:NO completion:nil];
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZCLog(@"error = %@",error);
    }];
    }

}

#pragma mark --上传图片
- (void)postCover:(UITapGestureRecognizer *)sender{
    ZCLog(@"+++%zd",sender.view.tag);
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"请选择图片来源" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *UIAlertAction){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *UIAlertAction){
        if (sender.view.tag == 1006) {
            self.oneAndMore = @"one";
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }else{
            self.oneAndMore = @"more";
            ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc]init];
            elcPicker.maximumImagesCount = 9;
            elcPicker.imagePickerDelegate = self;
            [self presentViewController:elcPicker animated:YES completion:nil];
            
        }
        
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertCon animated:YES completion:nil];
    
}

#pragma mark -- 选择时间
- (void)changeTime:(UIButton *)sender{
    [self.view endEditing:YES];
    _selectDatePicker = [[MHDatePicker alloc] init];
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

- (void)returnNav{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- textField delegate

- (void)returnkeyBoard{
    [self.view endEditing:YES];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = @"";
    self.activityDes_textView.textColor = [UIColor blackColor];
}

#pragma mark------------UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
       // UIImage *smallImage = [self thumbnailWithImageWithoutScale:img size:CGSizeMake(100.0f, 100.0f)];
        NSData *data = UIImageJPEGRepresentation(img, 1.0);
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
                              if ([self.oneAndMore isEqualToString:@"one"]) {
                                  self.imagePic = str;
                                  [self.tableView reloadData];
                                  self.addCover.userInteractionEnabled = NO;
                              }else{
                                  [self.imagePicArr addObject:str];
                                  [self.tableView reloadData];
                              }
                              
                          }else{
                              [self presentViewController:[Tools showAlert:@"修改失败"] animated:YES completion:nil];
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
#pragma mark -- ELCImageDelegate
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    for (NSDictionary *dic in info) {
        if ([[dic objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"ALAssetTypePhoto"]) {
            UIImage *img = [dic objectForKey:UIImagePickerControllerOriginalImage];
           // UIImage *smallImage = [self thumbnailWithImageWithoutScale:img size:CGSizeMake(100.0f, 100.0f)];
            NSData *data = UIImageJPEGRepresentation(img, 1.0);
            [self getUploadImage:data];
        }
    }
    ZCLog(@"+++++++++%@",self.imagePicArr);
     [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
