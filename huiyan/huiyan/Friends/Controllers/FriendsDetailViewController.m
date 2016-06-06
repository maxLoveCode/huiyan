//
//  FriendsDetailViewController.m
//  huiyan
//
//  Created by 华印mac-001 on 16/5/26.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "FriendsDetailViewController.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"

#import "UIImage+ImageEffects.h"
#import "UIImage+UIImage_Crop.h"
#import "ServerManager.h"

#define headerSection 200
#define potraitWidth 90
#define nameLabelFont 16
#define infoHeight 60

#define circleRad 100

@interface FriendsDetailViewController()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView* mainTableView;
@property (nonatomic, strong) UICollectionView* info;
@property (nonatomic, strong) ServerManager* serverManager;

@end

@implementation FriendsDetailViewController

-(void)viewDidLoad
{
    if (_dataSource) {
        if ([_dataSource isKindOfClass:[FindFriend class]]) {
        
        }
    }
    [self.view addSubview:self.mainTableView];
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"frienddetail"];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _mainTableView;
}

-(UICollectionView *)info
{
    if (!_info) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
        _info = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, infoHeight)  collectionViewLayout:layout];
        _info.delegate = self;
        _info.dataSource = self;
        [_info registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"info"];
        _info.scrollEnabled = NO;
        [_info setBackgroundColor: [UIColor whiteColor]];
    }
    return _info;
}

#pragma mark - UITableViewdelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return headerSection;
    }
    else
        return headerSection;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"frienddetail" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [self setHeaderSection:cell];
    }
    else if(indexPath.section ==1){
        [self setSecondSection:cell];
    }
    else if(indexPath.section ==2){
        [self setThirdSection:cell];
    }
    return cell;
}

#pragma mark - UICollectionViewdelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreen_Width/3, infoHeight) ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* item = [collectionView dequeueReusableCellWithReuseIdentifier:@"info" forIndexPath:indexPath];
    return item;
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

#pragma mark - setting first section
-(void)setHeaderSection:(UITableViewCell*)cell
{
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, headerSection)];
    UIImageView* potrait = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_Width/2- potraitWidth/2, kMargin*2, potraitWidth, potraitWidth)];
    potrait.layer.cornerRadius = potraitWidth/2;
    potrait.layer.masksToBounds = YES;
    [bgView addSubview:potrait];
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake( 0, CGRectGetMaxY(potrait.frame), 100, nameLabelFont)];
    nameLabel.font = [UIFont systemFontOfSize:nameLabelFont];
    UIImageView* sex = [[UIImageView alloc] init];
    if ([_dataSource isKindOfClass:[FindFriend class]]) {
        FindFriend* model = _dataSource;
        [self setHeadContent:model bgView:bgView potrait:potrait name:nameLabel sex:sex];
    }
    [bgView addSubview:potrait];
    [bgView addSubview:nameLabel];
    [bgView addSubview:sex];
    [cell.contentView addSubview:bgView];
}

- (void)setHeadContent:(FindFriend*)model bgView:(UIImageView*)bgView potrait:(UIImageView*)potrait name:(UILabel*)nameLabel sex:(UIImageView*)sex
{
    [potrait sd_setImageWithURL:[NSURL URLWithString:model.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
     //   NSLog(@"%@, %lf, %lf",image,image.size.width,image.size.width* (headerSection/kScreen_Width));
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        CGFloat param = image.size.width/10;
        UIImage* blur = [image applyBlurWithRadius:param tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
        UIImage* croped = [blur crop:CGRectMake(0, 0, image.size.width, image.size.width* (headerSection/kScreen_Width))];
        bgView.image = croped;
    }];
    if ([model.sex isEqualToString:@"1"]) {
        sex.image = [UIImage imageNamed:@"male"];
    }else{
        sex.image = [UIImage imageNamed:@"female"];
    }
    
    nameLabel.text = model.nickname;
    CGFloat width = [self widthOfString:model.nickname withFont:[UIFont systemFontOfSize:nameLabelFont]];
    [nameLabel setFrame:CGRectMake(kScreen_Width/2-(width+10+nameLabelFont)/2, CGRectGetMaxY(potrait.frame)+20, width, nameLabelFont+10)];
    [sex setFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame)+10, CGRectGetMinY(nameLabel.frame)+5, nameLabelFont, nameLabelFont)];
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

#pragma mark - second cell
-(void)setSecondSection:(UITableViewCell*)cell
{
    NSInteger count;
    UIImageView* bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, headerSection)];
    
    if ([_dataSource isKindOfClass:[FindFriend class]]) {
        FindFriend* model = _dataSource;
        count = [model.like_wiki count];
        for (int i =0; i<count; i++) {
            CGFloat centre_x;
            if(i==5)
            {
                break;
            }
            if (i==0)
                centre_x = kScreen_Width/2;
            else if(i==1)
                centre_x = kScreen_Width/5*1.5;
            else if(i==2)
                centre_x = kScreen_Width/5*3.5;
            else if(i==3)
                centre_x = kScreen_Width/5/2;
            else
                centre_x = kScreen_Width/5*4.5;
            
            CGFloat centre_y = headerSection/2;
            centre_x += [self randomWithConstraint];
            centre_y += [self randomWithConstraint]-75;
            float rad = circleRad +[self randomWithConstraint];
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0 , 0, rad, rad)];
            lab.layer.cornerRadius = rad/2;
            lab.layer.masksToBounds = YES;
            
            lab.text = model.like_wiki[i];
            lab.textAlignment = NSTextAlignmentCenter;
            
            
            // blur
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];  // or UIBlurEffectStyleDark
            UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            [blurView setFrame:CGRectMake(centre_x, centre_y, rad, rad)];
            blurView.clipsToBounds = YES;
            blurView.layer.cornerRadius = rad/2;
            blurView.alpha= 0;
            // vibrancy
            UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
            UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
            [vibrancyView setFrame:CGRectMake(0, 0, rad, rad)];
            [blurView addSubview:vibrancyView];
            
            [vibrancyView.contentView addSubview:lab];
            [bgView addSubview:blurView];
            [UIView animateWithDuration:0.5 delay:0.5*i options:UIViewAnimationOptionLayoutSubviews animations:^{
                blurView.alpha= 1;
            } completion:^(BOOL finished) {
                
            }];
        }
        [bgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
            CGFloat param = image.size.width/10;
    
            UIImage* blur = [image applyBlurWithRadius:param tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
            UIImage* croped = [blur crop:CGRectMake(0, image.size.width* (headerSection/kScreen_Width), image.size.width, image.size.width* (headerSection/kScreen_Width)*2)];
            bgView.image = croped;
        }];
 
    }
    [cell.contentView addSubview:bgView];
}

-(double)randomWithConstraint
{
    double u =(double)(random() %100000 + 1)/100000; //for precision
    double v =(double)(random() %100000 + 1)/100000; //for precision
    double x = sqrt(-2*log(u))*cos(2*M_PI*v);
    double y = 10 *x;
    
    //NSLog(@"%lf,%lf",x,y);
    return y;
}

#pragma mark- third tableview
-(void)setThirdSection:(UITableViewCell*)cell
{
    UIButton* sendMsg = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton* request = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(kMargin, kMargin, kScreen_Width-2*kMargin, 44);
    [sendMsg setFrame:frame];
    [request setFrame:CGRectOffset(frame, 0, 44+10)];
    [sendMsg setTitle:@"发送消息" forState: UIControlStateNormal];
    [request setTitle:@"好友申请" forState: UIControlStateNormal];
    sendMsg.backgroundColor = [UIColor whiteColor];
    UIColor* theme = COLOR_WithHex(0xe54863);
    [sendMsg setTitleColor:theme forState:UIControlStateNormal];
    request.backgroundColor =COLOR_THEME;
    
    cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sendMsg.layer.cornerRadius = 4;
    request.layer.cornerRadius = 4;
#pragma warning 第二版加增加好友申请的功能
    //[cell.contentView addSubview:sendMsg];
    [request addTarget:self action:@selector(friendRequest) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:request];
}

-(void)friendRequest
{
    FindFriend* model = _dataSource;
    NSString* userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSDictionary* params =@{@"access_token":_serverManager.accessToken, @"user_id":userid, @"follow_id":model.ID};
    NSLog(@"%@", params);
    [_serverManager AnimatedPOST:@"add_friend.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject[@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
