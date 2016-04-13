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
#import "ArticalViewController.h"
#import "LoginViewController.h"
#define bannerHeight 187.5
#define menuHeight 72.5

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
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"homePage"];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.view setBackgroundColor:COLOR_WithHex(0xefefef)];
    //侧滑关闭
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    _serverManager = [ServerManager sharedInstance];
    [self.view addSubview:self.banner_view];
    [self getRecommendDrama];
    [self getBannerData];
    
#ifdef DEBUG
    NSLog(@"Homepage loaded");
#endif
}

-(void)viewWillAppear:(BOOL)animated
{
    scrollOffset =-20;
    statusBarHidden = YES;
    
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.barTintColor = COLOR_THEME;
    
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // [self.view setFrame:CGRectOffset(self.view.frame, 0, -(self.navigationController.navigationBar.frame.size.height))];

    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.alpha=1.0;
}

- (ZCBannerView *)banner_view{
    if (!_banner_view) {
        self.banner_view = [[ZCBannerView alloc]init];
    }
    return _banner_view;
}

-(UITableView *)recommendTableView
{
    if (!_recommendTableView) {
        _recommendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, [RecommondedTableViewCell cellHeight]*5-10) style:UITableViewStylePlain];
        _recommendTableView.delegate = self;
        _recommendTableView.dataSource = self;
        _recommendTableView.scrollEnabled = NO;
        [_recommendTableView registerClass:[RecommondedTableViewCell class] forCellReuseIdentifier:@"recommends"];
        _recommendTableView.separatorStyle = NO;
        
#ifdef DEBUG
        [_recommendTableView setBackgroundColor:[UIColor redColor]];
#endif
        
    }
    return _recommendTableView;
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

#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _recommendTableView) {
        return 1;
    }
    else
        return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _recommendTableView) {
        return [_dataSource count];
    }
    else
    {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        switch (section) {
            case 0:
                return 0.01;
            case 1:
                return 0.01;
            case 2:
                return 32;
            default:
                return 0.01;
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section != 2) {
            return 10;
        }
        else
            return 64;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if (section == 2) {
            UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 32)];
            [headerView setBackgroundColor:[UIColor whiteColor]];
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(kMargin, 10, 60, 12)];
            label.text = @"热门推荐";
            label.font = kFONT14;
            [headerView addSubview:label];
            
            return headerView;
        }
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView)
    {
        if (indexPath.section == 0)
        {
            return bannerHeight;
        }
        else if(indexPath.section == 1)
        {
            return menuHeight;
        }
        else
            return self.recommendTableView.frame.size.height;
    }
    return [RecommondedTableViewCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _recommendTableView) {
        RecommondedTableViewCell* cell = [_recommendTableView dequeueReusableCellWithIdentifier:@"recommends" forIndexPath:indexPath];
        [cell setContent:[_dataSource objectAtIndex:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homePage" forIndexPath:indexPath];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section ==0) {
            [cell.contentView setBackgroundColor:[UIColor orangeColor]];
        }
        else if (indexPath.section == 1) {
            [cell.contentView addSubview:self.menuView];
        }
        else if(indexPath.section == 2)
        {
            [cell.contentView addSubview:self.recommendTableView];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticalViewController *artCon = [[ArticalViewController alloc]init];
    HomePage *homePage = self.dataSource[indexPath.row];
    artCon.originData = homePage.content;
    [self.navigationController pushViewController:artCon animated:YES];
}

#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreen_Width/4, kScreen_Width/4) ;
}

#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

#pragma mark <UICollectionViewDataSource>
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *title = @[@"购票",@"培训",@"红团/红角",@"戏曲百科"];
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menu" forIndexPath:indexPath];
        UIImageView *image_pic = [cell viewWithTag:500];
        if (!image_pic) {
            image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width / 4 / 2 - 25,5, 50 ,50)];
            image_pic.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.item + 1]];
            [cell.contentView addSubview:image_pic];
            image_pic.tag = 500;
        }
        UILabel *title_lab = [cell viewWithTag:501];
        if (!title_lab) {
            title_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, kScreen_Width / 4, 16)];
            title_lab.font = kFONT14;
            title_lab.textAlignment = NSTextAlignmentCenter;
            title_lab.textColor = COLOR_WithHex(0x020202);
            title_lab.text = title[indexPath.item];
            [cell.contentView addSubview:title_lab];
                        title_lab.tag = 501;
        }
    UILabel *line_lab = [cell viewWithTag:502];
    if (!line_lab) {
        line_lab = [[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width / 4 - 0.5, 0,0.5, kScreen_Width / 4)];
        line_lab.backgroundColor = COLOR_WithHex(0xdddddd);
        [cell.contentView addSubview:line_lab];
        line_lab.tag = 502;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        TicketBoxViewController *tickCon = [[TicketBoxViewController alloc]init];
        [self.navigationController pushViewController:tickCon animated:YES];
    }else if (indexPath.item == 1){
        TrainingTableViewController *trainCon = [[TrainingTableViewController alloc]init];
        [self.navigationController pushViewController:trainCon animated:YES];
    }else if (indexPath.item == 2) {
        LoginViewController* login = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    }else {
        WikiViewController *wikiCon = [[WikiViewController alloc]init];
        [self.navigationController pushViewController:wikiCon animated:YES];
    }
}

#pragma mark statusbar transparent
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma scroll delegate
-(void)scrollViewDidBeginDecelerating:(UIScrollView *)scrollView
{

}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
#ifdef DEBUG
        //NSLog(@"tableview scrolling %.1lf, %.1lf", scrollView.contentOffset.y, scrollView.contentOffset.y-scrollOffset);
#endif
        if (scrollView.contentOffset.y-scrollOffset-20>0 && statusBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            statusBarHidden = !statusBarHidden;
        }
        
        if (scrollView.contentOffset.y-scrollOffset-20<=0&& !statusBarHidden) {
            
            [self.navigationController setNavigationBarHidden:YES animated:NO];
            
            statusBarHidden = !statusBarHidden;
        }
        
        if (!statusBarHidden&&self.navigationController.navigationBar.alpha<=1.0 &&self.navigationController.navigationBar.alpha>0.0) {
#ifdef DEBUG
            //NSLog(@"alpha %lf", self.navigationController.navigationBar.alpha);
#endif
            self.navigationController.navigationBar.alpha =(scrollView.contentOffset.y-scrollOffset-20)/24;
        }
    }
}
#pragma mark 请求数据

-(void)getRecommendDrama
{
    _dataSource = [[NSMutableArray alloc] init];
    NSDictionary *dic = @{@"access_token":_serverManager.accessToken,
                          @"is_hot":@"1"};
  
    [_serverManager AnimatedPOST:@"get_wiki_list.php" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        if ([[responseObject objectForKey:@"code"] integerValue] == 20010) {

            for(NSDictionary* drama in [responseObject objectForKey:@"data"])
            {
                [_dataSource addObject:[HomePage parseDramaJSON:drama]];
            }
            
            [_recommendTableView setFrame:CGRectMake(0, 0, kScreen_Width, [RecommondedTableViewCell cellHeight]*[_dataSource count]-10)];
            [_recommendTableView reloadData];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

- (void)getBannerData{
    NSDictionary *params = @{@"access_token":_serverManager.accessToken,@"key":@"app_banner"};
    [_serverManager AnimatedPOST:@"get_app_config.php" parameters:params success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 60000) {
              self.banner_view.dataSource = [NSJSONSerialization JSONObjectWithData:[[responseObject[@"data"] objectForKey:@"imgs"] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            [self.banner_view reloadMenu];
       
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



@end
