//
//  HomePageHeadView.m
//  huiyan
//
//  Created by zc on 16/8/1.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import "HomePageHeadView.h"
#import <UIImageView+WebCache.h>
@interface HomePageHeadView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger arrayCount;


@end

@implementation HomePageHeadView


- (void)awakeFromNib{
    [self addSubview:self.grayView];
    [self addSubview:self.pageControl];
    [self setupScrollow];
    [self setupOther];
}

- (void)setupScrollow{
    self.ScrollView.pagingEnabled = YES;
    self.ScrollView.delegate = self;
    
}

- (void)setupOther{
    self.timeLab.textColor = COLOR_THEME;
}

- (UIView *)grayView{
    if (!_grayView) {
        self.grayView = [[UIView alloc]init];
        self.grayView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    }
    return _grayView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        self.pageControl.currentPageIndicatorTintColor = COLOR_THEME;
    }
    return _pageControl;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pageControl.center = CGPointMake(self.zc_width / 2, 50 + kScreen_Width / 2 - 10);
    self.pageControl.zc_height = 30;
    self.grayView.frame = CGRectMake(0, kScreen_Width / 2 + 20, kScreen_Width, 30);
}

#pragma mark -- 滑动事件
//开启定时器
- (void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

//关闭定时器
- (void)removeTimer{
    [self.timer invalidate];
}

- (void)nextImage{
    self.pageCount ++;
    if (self.pageCount == self.arrayCount - 1) {
        self.pageCount = 0;
    }
    self.pageControl.currentPage = self.pageCount;
    [UIView animateWithDuration:1 animations:^{
        self.ScrollView.contentOffset = CGPointMake(kScreen_Width * self.pageCount, 0);
    }];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / kScreen_Width;
    self.pageControl.currentPage = index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

- (IBAction)clickNotice:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickNotices)]) {
        [self.delegate clickNotices];
    }
}

- (void)uploaData:(NSArray *)dataSource{
    self.arrayCount = dataSource.count;
    self.ScrollView.contentSize = CGSizeMake(kScreen_Width * dataSource.count, 0);
      self.pageControl.numberOfPages = dataSource.count;
    for (int i = 0; i < dataSource.count; i++) {
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width * i, 0, kScreen_Width, kScreen_Width / 2)];
        [view sd_setImageWithURL:[NSURL URLWithString:[dataSource[i] objectForKey:@"cover"]]];
        [self.ScrollView addSubview:view];
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 + (kScreen_Width * i), kScreen_Width / 2 - 50, 200, 20)];
        titleLab.font = kFONT14;
        titleLab.textColor = [UIColor whiteColor];
        titleLab.text = [dataSource[i] objectForKey:@"title"];
        titleLab.textAlignment = NSTextAlignmentLeft;
        [self.ScrollView addSubview:titleLab];
        
    }
    [self setNeedsLayout];
    [self addTimer];
}

@end
