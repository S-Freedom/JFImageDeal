//
//  JFCollectionViewCell.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFCollectionViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JFCommonUtils.h"
@interface JFCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) UIView *tit;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation JFCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    UIImageView *imgView = [[UIImageView alloc] init];
//    imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView = imgView;
    [self.contentView addSubview:imgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"美女图片";
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
}

- (void)setPic:(NSString *)pic{
    _pic = pic;
    if(pic == nil) return;
    NSURL *url = [NSURL URLWithString:pic];
    UIImage *placeHolderImg = [JFCommonUtils createImageWithColor:[UIColor lightGrayColor]];
    [self.imageView sd_setImageWithURL:url placeholderImage:placeHolderImg];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
}

@end
