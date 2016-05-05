//
//  CoolNavi.m
//  CoolNaviDemo
//
//  Created by ian on 15/1/19.
//  Copyright (c) 2015年 ian. All rights reserved.
//

#import "CoolNavi.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "UIImage+ImageEffects.h"
@interface CoolNavi()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, assign) CGPoint prePoint;

@end


@implementation CoolNavi

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bg_img];
        [self.bg_img addSubview:self.edit_btn];
        [self.bg_img addSubview:self.head_img];
        [self.bg_img addSubview:self.fansNum_lab];
        [self.bg_img addSubview:self.fans_first_img];
        [self.bg_img addSubview:self.fans_second_img];
        [self.bg_img addSubview:self.fans_third_img];
        [self.bg_img addSubview:self.more_img];
        [self.bg_img addSubview:self.giftList_lab];
        [self.bg_img addSubview:self.name_lab];
        [self.bg_img addSubview:self.focus_btn];
         self.userInteractionEnabled = YES;
    }
    return self;
}

- (UIImageView *)bg_img{
    if (!_bg_img) {
        self.bg_img = [[UIImageView alloc]init];
        self.bg_img.userInteractionEnabled = YES;
    }
    return _bg_img;
}

- (UIImageView *)head_img{
    if (!_head_img) {
        self.head_img = [[UIImageView alloc]init];
        self.head_img.layer.masksToBounds = YES;
        self.head_img.layer.cornerRadius = 81/ 2;
    }
    return _head_img;
}

- (UIButton *)edit_btn{
    if (!_edit_btn) {
        self.edit_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.edit_btn setTitle:@"编辑" forState:UIControlStateNormal];
        self.edit_btn.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.edit_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _edit_btn;
}

- (UIImageView *)fans_first_img{
    if (!_fans_first_img) {
        self.fans_first_img = [[UIImageView alloc]init];
        self.fans_first_img.backgroundColor = [UIColor blueColor];
        self.fans_first_img.layer.masksToBounds = YES;
        self.fans_first_img.layer.cornerRadius = 21;
        self.fans_first_img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.fans_first_img.layer.borderWidth = 2;
        
    }
    return _fans_first_img;
}

- (UIImageView *)fans_second_img{
    if (!_fans_second_img) {
        self.fans_second_img = [[UIImageView alloc]init];
        self.fans_second_img.backgroundColor = [UIColor blackColor];
        self.fans_second_img.layer.masksToBounds = YES;
        self.fans_second_img.layer.cornerRadius = 21;
        self.fans_second_img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.fans_second_img.layer.borderWidth = 2;
    }
    return _fans_second_img;
}

- (UIImageView *)fans_third_img{
    if (!_fans_third_img) {
        self.fans_third_img = [[UIImageView alloc]init];
        self.fans_third_img.backgroundColor = [UIColor yellowColor];
        self.fans_third_img.layer.masksToBounds = YES;
        self.fans_third_img.layer.cornerRadius = 21;
        self.fans_third_img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.fans_third_img.layer.borderWidth = 2;
        
    }
    return _fans_third_img;
}

- (UIImageView *)more_img{
    if (!_more_img) {
        self.more_img = [[UIImageView alloc]init];
        self.more_img.backgroundColor = [UIColor redColor];
    }
    return _more_img;
}

- (UILabel *)giftList_lab{
    if (!_giftList_lab) {
        self.giftList_lab = [[UILabel alloc]init];;
        self.giftList_lab.textColor = [UIColor whiteColor];
        self.giftList_lab.font = kFONT16;
        self.giftList_lab.text = @"礼物贡献榜";
    }
    return _giftList_lab;
}

- (UILabel *)name_lab{
    if (!_name_lab) {
        self.name_lab = [[UILabel alloc]init];
        self.name_lab.textColor = [UIColor whiteColor];
        self.name_lab.font = kFONT18;
    }
    return _name_lab;
}

- (UILabel *)fansNum_lab{
    if (!_fansNum_lab) {
        self.fansNum_lab = [[UILabel alloc]init];
        self.fansNum_lab.textColor = [UIColor whiteColor];
        self.fansNum_lab.font = kFONT16;
    }
    return _fansNum_lab;
}

- (UIButton *)focus_btn{
    if (!_focus_btn) {
        self.focus_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.focus_btn setTitle:@"+关注" forState:UIControlStateNormal];
        self.focus_btn.backgroundColor = COLOR_THEME;
        self.focus_btn.layer.masksToBounds = YES;
        self.focus_btn.layer.cornerRadius = 3;
        [self.focus_btn addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
        [self.focus_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _focus_btn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.bg_img.frame = CGRectMake(0 , -25, self.frame.size.width, self.frame.size.height +20);
    self.edit_btn.frame = CGRectMake(kScreen_Width - kMargin - 20 - 40,80, 40, 50);
    self.head_img.frame = CGRectMake(kMargin, 64, 81, 81);
    self.focus_btn.frame = CGRectMake(kScreen_Width - 15 - 88, CGRectGetMaxY(self.fansNum_lab.frame), 88, 33);
    self.giftList_lab.frame = CGRectMake(kMargin, 244- 36, 100, 16);
    self.name_lab.frame = CGRectMake(108, 84, 200, 18 * 1.5);
    self.fansNum_lab.frame = CGRectMake(108, 114, 300, 16 * 1.5);
    
    self.more_img.frame = CGRectMake(kScreen_Width - 15 - 20, 182+ 11, 20, 20);
    self.fans_third_img.frame = CGRectMake(kScreen_Width - 210+56+56, 182, 42, 42);
    self.fans_second_img.frame  = CGRectMake(kScreen_Width - 210 + 56, 182, 42, 42);
    self.fans_first_img.frame = CGRectMake(kScreen_Width - 210, 182, 42, 42);
}

- (void)setContent:(DramaStar *)drama{
    [self.bg_img sd_setImageWithURL:[NSURL URLWithString:drama.avator] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        UIColor *tintColor = [UIColor colorWithWhite:0.7 alpha:0.5];
        self.bg_img.image =[image applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:4 maskImage:nil];
    }];
    [self.head_img sd_setImageWithURL:[NSURL URLWithString:drama.avator] placeholderImage:[UIImage imageNamed:@"1"]];
    self.name_lab.text = drama.nickName;
    self.fansNum_lab.text = [NSString stringWithFormat:@"粉丝数: %@人",drama.is_fans];
    
}

- (void)focus:(UIButton *)sender{
    if (self.focus) {
        self.focus(sender);
    }
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:nil];
   // [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0 ,0 , 0);
    self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGPoint newOffset = [change[@"new"] CGPointValue];
    [self updateSubViewsWithScrollOffset:newOffset];
}

-(void)updateSubViewsWithScrollOffset:(CGPoint)newOffset
{
    
    CGFloat destinaOffset = -64;
    CGFloat startChangeOffset = -self.scrollView.contentInset.top;
    newOffset = CGPointMake(newOffset.x, newOffset.y<startChangeOffset?startChangeOffset:(newOffset.y>destinaOffset?destinaOffset:newOffset.y));
    
    CGFloat subviewOffset = self.frame.size.height-40; // 子视图的偏移量
    CGFloat newY = -newOffset.y-self.scrollView.contentInset.top;
    CGFloat d = destinaOffset-startChangeOffset;
    CGFloat alpha = 1-(newOffset.y-startChangeOffset)/d;
    self.edit_btn.alpha = alpha;
    self.fans_first_img.alpha = alpha;
    self.fans_second_img.alpha = alpha;
    self.fans_third_img.alpha = alpha;
    self.more_img.alpha = alpha;
    self.giftList_lab.alpha = alpha;
    self.fansNum_lab.alpha = alpha;
    self.edit_btn.alpha = alpha;
    self.edit_btn.alpha = alpha;
    self.edit_btn.alpha = alpha;
    self.frame = CGRectMake(0, newY, self.frame.size.width, self.frame.size.height);

    CGRectMake(0, -0.5*self.frame.size.height+(1.5*self.frame.size.height-64)*(1-alpha), self.backImageView.frame.size.width, self.backImageView.frame.size.height);
    self.edit_btn.frame = CGRectMake(kScreen_Width - kMargin - 20 - 40, 80 +(subviewOffset-0.45*self.frame.size.height)*(1-alpha), 40, 50);
    self.giftList_lab.frame = CGRectMake(kMargin, 244 - 36+(subviewOffset-0.8*self.frame.size.height)*(1-alpha), 100, 16);
    self.fansNum_lab.frame = CGRectMake(108, 114 +(subviewOffset-0.45*self.frame.size.height)*(1-alpha), 300, 16 * 1.5);
    
    self.more_img.frame = CGRectMake(kScreen_Width - 15 - 20, 182+ 11 +(subviewOffset-0.8*self.frame.size.height)*(1-alpha), 20, 20);
    self.fans_third_img.frame = CGRectMake(kScreen_Width - 210 +56+56, 182 +(subviewOffset-0.8*self.frame.size.height)*(1-alpha), 42, 42);
    self.fans_second_img.frame  = CGRectMake(kScreen_Width - 210 + 56, 182 +(subviewOffset-0.8*self.frame.size.height)*(1-alpha), 42, 42);
    self.fans_first_img.frame = CGRectMake(kScreen_Width - 210, 182 +(subviewOffset-0.8*self.frame.size.height)*(1-alpha), 42, 42);
    
    //调节大小
    CGFloat f_imageReduce = 1-(newOffset.y-startChangeOffset)/(d*2) + 0.1;
    //调节距离
    CGAffineTransform f = CGAffineTransformMakeTranslation(0.5,(subviewOffset-0.51*self.frame.size.height)*(1-alpha));
    self.focus_btn.transform = CGAffineTransformScale(f,
                                                      f_imageReduce, f_imageReduce);
    
    //调节大小
    CGFloat name_imageReduce = 1-(newOffset.y-startChangeOffset)/(d*2) + 0.2;
    //调节距离
    CGAffineTransform t_name = CGAffineTransformMakeTranslation(0,(subviewOffset-0.28*self.frame.size.height)*(1-alpha));
    self.name_lab.transform = CGAffineTransformScale(t_name,
                                                     name_imageReduce , name_imageReduce );
    
    CGFloat head_imageReduce = 1-(newOffset.y-startChangeOffset)/(d*2);
    CGAffineTransform t_head = CGAffineTransformMakeTranslation(0.5,(subviewOffset-0.32*self.frame.size.height)*(1-alpha));
    self.head_img.transform = CGAffineTransformScale(t_head,
                                                       head_imageReduce, head_imageReduce);


}





@end
