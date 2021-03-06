//
//  HomePageController.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/5.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePageController.h"
#import "RecommondedTableViewCell.h"
#import "WikiViewController.h"
#import "HomePage.h"
#import "TicketBoxViewController.h"
#import "TrainingTableViewController.h"
#import "LoginViewController.h"
#import "DramaStarViewController.h"
#import "LoginViewController.h"
#import "TrainingTableViewCell.h"
#import "BuyTicket.h"
#import "HomePageCell.h"
#import "BuyTicketDetailsViewController.h"
#import "Training.h"
#import "WikiWorksDetailsViewController.h"
#import "TrainingDetailsTableViewController.h"
#import "SignUpMessageTableViewController.h"
#import "MessageViewController.h"
#import "UITabBarController+ShowHideBar.h"
#define bannerHeight kScreen_Width / 2
#define menuHeight 114
#define menuPicWidth 36
#define actCellHeight 152
#define imageWidth (kScreen_Width - 84) / 3
#define imageHeight (kScreen_Width - 84) / 3 * 1.3
#define titleLabelHeight 30

@interface HomePageController()
{
    CGFloat scrollOffset;
    BOOL statusBarHidden;
}
@end

@implementation HomePageController

- (void)viewDidLoad
{
    [super viewDidLoad];
   // self.title = @"发  现";
    self.findIcon = [NSArray array];
    [self.tableView setFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height -  64)];
    //侧滑关闭
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"homePage"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"interaction"] style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.view setBackgroundColor:COLOR_WithHex(0xefefef)];
    self.head_title = @[@"最新剧目",@"最新活动",@"百科推荐"];
  
    self.ticketArr  = [NSMutableArray array];
    self.wikiArr = [NSMutableArray array];
    self.actArr = [NSMutableArray array];
    [self get_opera_listData];
    [self get_wiki_listData];
    [self get_train_listData];
    [self app_find_iconData];

}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = COLOR_THEME;
    [super viewWillAppear:animated];
    if (self.tabBarController.tabBar.hidden == YES) {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    
   // NSLog(@"homepage will appear");
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    [self.tabBarController setHidden:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    float fHeight = screenRect.size.height;
    UIDeviceOrientation orientation = [[UIDevice currentDevice]orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
        fHeight = screenRect.size.width;
    }
    
    
    if(!self.tabBarController.tabBar.hidden) fHeight -= self.tabBarController.tabBar.frame.size.height;
    
    [UIView animateWithDuration:0.25 animations:^{
        for(UIView *view in self.view.subviews){
            if([view isKindOfClass:[UITabBar class]]){
                [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
            }else{
                if(self.tabBarController.tabBar.hidden) [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            }
        }
    }completion:^(BOOL finished){
        if(!self.tabBarController.tabBar.hidden){
            
            [UIView animateWithDuration:0.25 animations:^{
                
                for(UIView *view in self.view.subviews)
                {
                    if(![view isKindOfClass:[UITabBar class]])
                        [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
                }
            }completion:^(BOOL finished) {
                if(finished)
                    self.tabBarController.tabBar.hidden = YES;
            //    NSLog(@"tabbar hidden is YES");
            }];
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (UITableView *)activityTableView{
    if (!_activityTableView) {
        self.activityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, actCellHeight * 3) style:UITableViewStylePlain];
        self.activityTableView.delegate = self;
        self.activityTableView.dataSource = self;
        self.activityTableView.scrollEnabled = NO;
        self.activityTableView.rowHeight = actCellHeight;
        [self.activityTableView registerClass:[TrainingTableViewCell class] forCellReuseIdentifier:@"activity"];
    }
    return _activityTableView;
}

-(UICollectionView* )menuView
{
    if(!_menuView){
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
        _menuView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, menuHeight) collectionViewLayout:layout];
        [_menuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"menu"];
        _menuView.scrollEnabled = NO;
        _menuView.delegate = self;
        _menuView.dataSource = self;
        _menuView.backgroundColor = [UIColor whiteColor];
        _menuView.scrollEnabled = NO;
    }
    return _menuView;
}

- (UICollectionView *)ticketCollectionView{
    if (!_ticketCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        self.ticketCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, imageHeight + titleLabelHeight+ 30) collectionViewLayout:layout];
        self.ticketCollectionView.pagingEnabled = YES;
        self.ticketCollectionView.scrollEnabled = NO;
        self.ticketCollectionView.bounces = NO;
        self.ticketCollectionView.delegate = self;
        self.ticketCollectionView.dataSource = self;
        self.ticketCollectionView.backgroundColor = [UIColor whiteColor];
        self.ticketCollectionView.showsVerticalScrollIndicator = NO;
        self.ticketCollectionView.showsHorizontalScrollIndicator = NO;
        [self.ticketCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ticket"];
    }
    return _ticketCollectionView;
}

- (UICollectionView *)wikiCollectionView{
    if (!_wikiCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        self.wikiCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width,imageHeight + titleLabelHeight+ 30) collectionViewLayout:layout];
        self.wikiCollectionView.pagingEnabled = YES;
        self.wikiCollectionView.scrollEnabled = NO;
        self.wikiCollectionView.bounces = NO;
        self.wikiCollectionView.delegate = self;
        self.wikiCollectionView.dataSource = self;
        self.wikiCollectionView.backgroundColor = [UIColor whiteColor];
        self.wikiCollectionView.showsVerticalScrollIndicator = NO;
        self.wikiCollectionView.showsHorizontalScrollIndicator = NO;
        [self.wikiCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"wiki"];
    }
    return _wikiCollectionView;
}


#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.activityTableView) {
        return 1;
    }
        return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.activityTableView) {
        return 3;
    }
        return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        switch (section) {
            case 0:
                return 0.01;
            case 1:
                return 32;
            case 2:
                return 32;
            default:
                return 32;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section == 0 || section == 1 || section == 2) {
            return 10;
        }
        return 0.01;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
        [view setBackgroundColor:[UIColor clearColor]];
        return view;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section != 0) {
            UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 32)];
            UILabel *h_lab = [[UILabel alloc]initWithFrame:CGRectMake(21, 7, 5, 19)];
            h_lab.backgroundColor = COLOR_THEME;
            h_lab.layer.masksToBounds = YES;
            h_lab.layer.cornerRadius = 2;
            [headerView addSubview:h_lab];
            [headerView setBackgroundColor:[UIColor whiteColor]];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(35,3, 60, 29)];
            label.text = self.head_title[section - 1];
            label.font = kFONT14;
            [headerView addSubview:label];
            UIButton *more_btn = [UIButton buttonWithType:UIButtonTypeCustom];
            more_btn.tag = section + 60;
            more_btn.titleLabel.font = kFONT14;
            more_btn.frame = CGRectMake(kScreen_Width - 21- 80,3, 100, 29);
            more_btn.titleLabel.textAlignment = NSTextAlignmentRight;
            [more_btn setTitle:@"查看更多  >" forState:UIControlStateNormal];
            [more_btn setTitleColor:COLOR_WithHex(0xa5a5a5) forState:UIControlStateNormal];
            [more_btn addTarget:self action:@selector(lookMore:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:more_btn];
            UIView* lab = [[UIView alloc] initWithFrame:CGRectMake(0, 31, kScreen_Width, 1)];
            [lab setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [headerView addSubview:lab];
            return headerView;
        }
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView){
        if (indexPath.section == 0) {
            return 114;
        }else if (indexPath.section == 1){
            return imageHeight + titleLabelHeight+ 30;
        }else if(indexPath.section == 2){
            return actCellHeight * 3;
        }else{
            return imageHeight + titleLabelHeight+ 30;
        }
    }
    return actCellHeight;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.activityTableView) {
        TrainingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activity" forIndexPath:indexPath];
        if (self.actArr.count > 0) {
             [cell setContent:self.actArr[indexPath.row]];
        }
        cell.enroll_btn.tag = indexPath.section ;
        [cell.enroll_btn addTarget:self action:@selector(enroll:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homePage" forIndexPath:indexPath];
        for (UIView* view in [cell.contentView subviews])
        {
            [view removeFromSuperview];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section ==0) {
        
            [cell.contentView addSubview:self.menuView];
        }
        else if (indexPath.section == 1) {
            [cell.contentView addSubview:self.ticketCollectionView];
        }
        else if(indexPath.section == 2)
        {
            [cell.contentView addSubview:self.activityTableView];
        }else if(indexPath.section == 3){
            [cell.contentView addSubview:self.wikiCollectionView];

        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.activityTableView) {
        TrainingDetailsTableViewController *traDetailCon = [[TrainingDetailsTableViewController alloc]init];
        traDetailCon.train  = self.actArr[indexPath.row];
        [self.navigationController pushViewController:traDetailCon animated:NO];
    }
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreen_Width/3, imageHeight+titleLabelHeight) ;
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == _menuView) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(20, 0, 10, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

#pragma mark <UICollectionViewDataSource>
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView == self.menuView) {
         UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menu" forIndexPath:indexPath];
    NSArray *title = @[@"购  票",@"活  动",@"戏曲百科"];
        UIImageView *image_pic = [cell viewWithTag:500];
        if (!image_pic) {
            image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width /
                                                                     3/ 2 - menuPicWidth/2, 28, menuPicWidth ,menuPicWidth)];
           // [image_pic sd_setImageWithURL:[NSURL URLWithString:self.findIcon[indexPath.item +1]]];
          
            [cell.contentView addSubview:image_pic];
            image_pic.tag = 500;
        }
        if (self.findIcon.count > 0) {
            [image_pic sd_setImageWithURL:[NSURL URLWithString:self.findIcon[indexPath.item]]];
        }
        UILabel *title_lab = [cell viewWithTag:501];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image_pic.frame)+5, kScreen_Width / 3, 16)];
            title_lab.font = kFONT13;
            title_lab.textAlignment = NSTextAlignmentCenter;
            title_lab.textColor = COLOR_WithHex(0x020202);
           
            [cell.contentView addSubview:title_lab];
                        title_lab.tag = 501;
        }
         title_lab.text = title[indexPath.item];
    UILabel *line_lab = [cell viewWithTag:502];
    if (!line_lab) {
    
        line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 3 - 0.5, 0,0.5, 114)];
        line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [cell.contentView addSubview:line_lab];
        line_lab.tag = 502;
    }
        return cell;
    }else if(collectionView == self.ticketCollectionView){
    
          UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ticket" forIndexPath:indexPath];
        UIImageView *image_pic = [cell viewWithTag:506];
        if (!image_pic) {
            image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, imageWidth ,imageHeight)];
            [cell.contentView addSubview:image_pic];
            image_pic.tag = 506;
        }

        UILabel *title_lab = [cell viewWithTag:508];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(image_pic.frame), imageWidth, titleLabelHeight)];
            title_lab.font = kFONT12;
            title_lab.numberOfLines = 2;
            title_lab.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:title_lab];
            title_lab.tag = 508;
        }
        if (self.ticketArr.count > 0) {
            BuyTicket *model = self.ticketArr[indexPath.item];
            [image_pic sd_setImageWithURL:[NSURL URLWithString:model.cover]];
            title_lab.text = model.title;
            
        }
        return cell;
    }else{
        UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wiki" forIndexPath:indexPath];
        UIImageView *image_pic = [cell viewWithTag:506];
        if (!image_pic) {
            image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, imageWidth ,imageHeight)];
            [cell.contentView addSubview:image_pic];
            image_pic.tag = 506;
        }
        UILabel *title_lab = [cell viewWithTag:508];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(image_pic.frame), imageWidth, titleLabelHeight)];
            title_lab.font = kFONT12;
            title_lab.numberOfLines = 2;
            title_lab.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:title_lab];
            title_lab.tag = 508;
        }
        if (self.wikiArr.count > 0) {
            HomePage *model = self.wikiArr[indexPath.item];
            [image_pic sd_setImageWithURL:[NSURL URLWithString:model.cover]];
            title_lab.text = model.title;
        }
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tabBarController setHidden:YES];
    if (collectionView == self.menuView) {
        
        if (indexPath.item == 0) {
            TicketBoxViewController *tickCon = [[TicketBoxViewController alloc]init];
            [self.navigationController pushViewController:tickCon animated:NO];
        }else if (indexPath.item == 1){
            TrainingTableViewController *trainCon = [[TrainingTableViewController alloc]init];
            
            [self.navigationController pushViewController:trainCon animated:NO];
        }else {
            WikiViewController *wikiCon = [[WikiViewController alloc]init];
            
            [self.navigationController pushViewController:wikiCon animated:NO];
        }

    }else if (collectionView == self.ticketCollectionView){
        BuyTicketDetailsViewController *btdCon = [[BuyTicketDetailsViewController alloc]init];
        if (self.ticketArr.count > 0) {
              btdCon.ticket = self.ticketArr[indexPath.item];
        }
      
      //  NSLog(@"%@",btdCon.ticket);
        
        [self.navigationController pushViewController:btdCon animated:NO];
    }else if (collectionView == self.wikiCollectionView){
        WikiWorksDetailsViewController *wikiCon = [[WikiWorksDetailsViewController alloc]init];
        wikiCon.homePage = self.wikiArr[indexPath.item];
        
        [self.navigationController pushViewController:wikiCon animated:NO];
    }
   
}

- (void)lookMore:(UIButton *)sender{
    [self.tabBarController setHidden:YES];
    if (sender.tag == 61) {
        TicketBoxViewController *tickCon = [[TicketBoxViewController alloc]init];
        
        [self.navigationController pushViewController:tickCon animated:NO];
    }else if (sender.tag == 62){
        TrainingTableViewController *trainCon = [[TrainingTableViewController alloc]init];
        
        [self.navigationController pushViewController:trainCon animated:NO];
    }else{
        WikiViewController *wikiCon = [[WikiViewController alloc]init];
        
        [self.navigationController pushViewController:wikiCon animated:NO];
    }
}

- (void)enroll:(UIButton *)sender{
    SignUpMessageTableViewController *signCon = [[SignUpMessageTableViewController alloc]init];
    signCon.train = self.actArr[sender.tag];
    [self.tabBarController setHidden:YES];
    [self.navigationController pushViewController:signCon animated:NO];
    
}

#pragma mark 请求数据

- (void)get_opera_listData{
    self.serverManager = [ServerManager sharedInstance];
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"length":@"3"};
 
    [self.serverManager GETWithoutAnimation:@"get_opera_list.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 30010) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                BuyTicket *model = [BuyTicket dataWithDic:dic];
                [self.ticketArr addObject:model];
            }
            [self.ticketCollectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)get_wiki_listData{
    self.serverManager = [ServerManager sharedInstance];
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"length":@"3"};
    [self.serverManager AnimatedGET:@"get_wiki_list.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 20010) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                HomePage *model = [HomePage parseDramaJSON:dic];
                [self.wikiArr addObject:model];
            }
            [self.wikiCollectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)get_train_listData{
    self.serverManager = [ServerManager sharedInstance];
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"length":@"3"};
    [self.serverManager AnimatedGET:@"get_train_list.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue] == 40000) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                Training *model = [Training dataWithDic:dic];
                [self.actArr addObject:model];
            }
            [self.activityTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error = %@",error);
    }];
}

//发现图标
- (void)app_find_iconData{
    NSDictionary *parameters = @{@"access_token":self.serverManager.accessToken,@"key":@"app_find_icon"};
    [self.serverManager GETWithoutAnimation:@"get_app_config.php" parameters:parameters success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
         if ([responseObject[@"code"] integerValue] == 60000) {
             //  NSLog(@"-------%@",[responseObject[@"data"] objectForKey:@"app_find_icon"]);
             self.findIcon = [responseObject[@"data"]objectForKey:@"value"];
             [self.menuView reloadData];
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error = %@",error);
     }];

}

- (void)rightClick:(UIBarButtonItem *)sender{
    MessageViewController *mes = [[MessageViewController alloc]init];
    [self.tabBarController setHidden:YES];
    [self.navigationController pushViewController:mes animated:YES];
}

@end
