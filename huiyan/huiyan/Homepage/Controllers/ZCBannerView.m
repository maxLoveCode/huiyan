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
    }
    return self;
}

- (UICollectionView *)bannerCollection{
    if (!_bannerCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(Width, Height);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        self.bannerCollection = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:layout];
        self.bannerCollection.pagingEnabled = YES;
        self.bannerCollection.delegate = self;
        self.bannerCollection.dataSource = self;
        self.bannerCollection.backgroundColor = [UIColor whiteColor];
        self.bannerCollection.showsVerticalScrollIndicator = NO;
        self.bannerCollection.showsHorizontalScrollIndicator = NO;
        [self.bannerCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:resuseIdentufier];
        [self addSubview:self.bannerCollection];
    }
    return _bannerCollection;
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
        [image_pic sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.item]] placeholderImage:[UIImage imageNamed:@"arrow"]];
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

- (void)reloadMenu{
    [self.bannerCollection reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
