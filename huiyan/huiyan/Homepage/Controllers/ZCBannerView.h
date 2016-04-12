//
//  ZCBannerView.h
//  huiyan
//
//  Created by 华印mac－002 on 16/4/12.
//  Copyright © 2016年 com.huayin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCBannerView;
@protocol ZCBannerDelegate <NSObject>

- (void)bannerMenu:(ZCBannerView *)menu didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZCBannerView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *bannerCollection;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, weak) id <ZCBannerDelegate> delegate;

- (void)reloadMenu;
@end