
//
//  ZCBannerView.m
//  huiyan
//
//  Created by 华印mac－002 on 16/4/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "ZCBannerView.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#define Height 187.5
#define Width kScreen_Width

static NSString *const resuseIdentufier = @"banner";

@implementation ZCBannerView

- (instancetype)init{
    if (self = [super init]) {
        [self setFrame:CGRectMake(0, 0, Width, Height)];
        self.pageCount = 0;
    }
    return self;
}


- (UICollectionView *)bannerCollection{
    if (!_bannerCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(Width, Height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.bannerCollection = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        self.bannerCollection.pagingEnabled = YES;
        self.bannerCollection.bounces = NO;
        self.bannerCollection.delegate = self;
        self.bannerCollection.dataSource = self;
        self.bannerCollection.backgroundColor = [UIColor whiteColor];
        self.bannerCollection.showsVerticalScrollIndicator = NO;
        self.bannerCollection.showsHorizontalScrollIndicator = NO;
        [self.bannerCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:resuseIdentufier];
        
        
    }
    return _bannerCollection;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
        //[self addTimer];
}


-(UIPageControl *)pageControl{
    if (!_pageControl) {
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(kScreen_Width / 2 - 50, Height - 20, 100, 20)];
        _pageControl.numberOfPages = self.dataSource.count;
        _pageControl.pageIndicatorTintColor = COLOR_WithHex(0xefefef);
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
       
    }
    return _pageControl;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuseIdentufier forIndexPath:indexPath];
    UIImageView *image_pic = [cell viewWithTag:1000];
    if (!image_pic) {
        image_pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, Height)];
        
        [image_pic sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.item]] placeholderImage:[UIImage imageNamed:@"1"]];
        [cell.contentView addSubview:image_pic];
        image_pic.tag = 1000;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerMenu:didSelectAtIndexPath:)]) {
         [self.delegate bannerMenu:self didSelectAtIndexPath:indexPath];
    }
   
    
}
//开启定时器
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
}

- (void)removeTimer{
    [self.timer invalidate];
}

- (void)nextImage{
    self.pageCount++;
    if (self.pageCount == self.dataSource.count) {
        self.pageCount = 0;
    }
    self.pageControl.currentPage = self.pageCount;
    
   
   // [UIView animateWithDuration:1 animations:^{
        [self.bannerCollection selectItemAtIndexPath:[NSIndexPath indexPathForItem:self.pageCount inSection:1] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self.bannerCollection reloadData];
   // }];

}

#pragma mark --ScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.bannerCollection) {
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.bannerCollection) {
        NSInteger index = self.bannerCollection.contentOffset.x / kScreen_Width;
        self.pageControl.currentPage = index;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.bannerCollection) {
       // [self addTimer];
    }
}


- (void)reloadMenu{
    [self.bannerCollection reloadData];
    [self.pageControl reloadInputViews];
    [self addSubview:self.bannerCollection];
    [self addSubview:self.pageControl];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
