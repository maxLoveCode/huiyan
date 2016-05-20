//
//  EditPersonMessageViewController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/5/19.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "EditPersonMessageViewController.h"
#import "Constant.h"
#import "ServerManager.h"
#import "UITabBarController+ShowHideBar.h"
#import "PersonMessage.h"
#import "UIImageView+WebCache.h"
#import "SexTableViewController.h"
#import "Tools.h"
@interface EditPersonMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ServerManager *serverManager;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) PersonMessage *perData;
@property(nonatomic,strong)UIImage * selfPhoto;
@end

@implementation EditPersonMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"头像",@"昵称",@"性别"];
    self.view.backgroundColor = COLOR_WithHex(0xdddddd);
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.serverManager = [ServerManager sharedInstance];
    [self get_user_infoData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tabBarController setHidden:YES];
   // [self.view setFrame:CGRectMake(0, 64, kScreen_Width, kScreen_Height - 64)];
}

- (UITableView *)tableView{
    if (!_tableView) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
        self.tableView.scrollEnabled = NO;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 50;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"edit"];
    }
    return _tableView;
}

#pragma mark - tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"edit" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArr[indexPath.row];
    if (indexPath.row == 0) {
        UIImageView *imagePic = [cell viewWithTag:1000];
        if (!imagePic) {
            imagePic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width - 72, 4, 42, 42)];
            imagePic.layer.masksToBounds = YES;
            imagePic.layer.cornerRadius = 21;

            [cell.contentView addSubview:imagePic];
            imagePic.tag = 1000;
        }
        [imagePic sd_setImageWithURL:[NSURL URLWithString:self.perData.avatar]];
    }else if (indexPath.row == 1){
        UILabel *nameLab = [cell viewWithTag:1002];
        if (!nameLab) {
            nameLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 230, 4, 200, 42)];
            nameLab.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:nameLab];
            nameLab.tag = 1002;
        }
        nameLab.text = self.perData.nickname;
    }else {
        UILabel *sexLab = [cell viewWithTag:1004];
        if (!sexLab) {
            sexLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width - 230, 4, 200, 42)];
            sexLab.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:sexLab];
            sexLab.tag = 1004;
        }
        if ([self.perData.sex isEqualToString:@"1"]) {
            sexLab.text = @"男";
        }else{
            sexLab.text = @"女";
        }
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
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
        
    }else if (indexPath.row == 1){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = self.perData.nickname;
            textField.textColor = [UIColor blackColor];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.borderStyle = UITextBorderStyleRoundedRect;
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            UITextField *field = alert.textFields[0];
            if (![field.text isEqualToString:@""] && ![field.text isEqualToString:self.perData.nickname]) {
                NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":kOBJECTDEFAULTS(@"user_id"),@"nickname":field.text};
                [self.serverManager AnimatedPOST:@"edit_user_info.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
                    if ([responseObject[@"code"] integerValue] == 80010) {
                        [self get_user_infoData];
                        [self presentViewController:[Tools showAlert:@"修改成功"] animated:YES completion:nil];
                    }else{
                        [self presentViewController:[Tools showAlert:@"修改失败"] animated:YES completion:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"error = %@",error);
                }];
            }
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        SexTableViewController *sexCon = [[SexTableViewController alloc]init];
        [self.navigationController pushViewController:sexCon animated:YES];
    }
}

#pragma mark------------UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//- (void)saveImage:(UIImage *)image {
//    //    NSLog(@"保存头像！");
//    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
//    BOOL success;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error;
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
//    // NSLog(@"imageFile->>%@",imageFilePath);
//    success = [fileManager fileExistsAtPath:imageFilePath];
//    if(success) {
//        success = [fileManager removeItemAtPath:imageFilePath error:&error];
//    }
//    
//#warning 这里还都是缩略图，上传时候应该用大图标
//    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(100.0f, 100.0f)];
//    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
//    _selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
//    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
//    
//    //七牛服务器
//    [_people getQiniuAccessToken:^(NSMutableDictionary *result) {
//        if ([[result objectForKey:@"code"]integerValue] == 60055) {
//            NSString *token = [[result objectForKey:@"data"] objectForKey:@"qiniu_upload_token"];
//            NSLog(@"token is %@",token);
//            NSDate *date = [NSDate date];
//            [SVProgressHUD showWithStatus:@"正在上传图片至服务器" maskType: SVProgressHUDMaskTypeClear];
//            [_people PostImage:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//                NSString* header_string = [resp objectForKey:@"key"];
//                NSMutableDictionary* avatar_dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:header_string,@"avatar", nil];
//                [SVProgressHUD showWithStatus:@"正在修改个人信息" maskType: SVProgressHUDMaskTypeClear];
//                [_people editInfo:^(NSMutableDictionary *result) {
//                    self.selfPhoto = _selfPhoto;
//                    [_people setAvatar:[NSString stringWithFormat:@"http://7xk6qx.com1.z0.glb.clouddn.com/%@", key]];
//                    [self.tableView reloadData];
//                    [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[_people getAvatar] forKey:@"myAvatar"];
//                } Index:0 Changes:avatar_dic];
//            } Image:image Forkey:[NSString stringWithFormat:@"%@,%@",[_people getUserID],[Tools stringWithDate:date byType:date_type_YMDHMS_NoSperator]] Token:token failure:^(NSError *error) {
//                ;
//            }];
//        }
//        else
//        {
//            [SVProgressHUD showErrorWithStatus:@"上传失败"];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"上传失败"];
//    }];
//    
//}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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


- (void)get_user_infoData{
    NSString *user_id = kOBJECTDEFAULTS(@"user_id");
    if (user_id) {
        NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"user_id":user_id};
        [self.serverManager AnimatedGET:@"get_user_info.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
            if ([responseObject[@"code"]integerValue] == 80000) {
                self.perData = [PersonMessage personWithDic:responseObject[@"data"]];
                [self.tableView reloadData];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
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
