//
//  JFDetailCell.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFDetailCell.h"

#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "JFCommonUtils.h"

@interface JFDetailCell()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation JFDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    UIImageView *imgView = [[UIImageView alloc] init];
    self.imageView = imgView;
    [self.contentView addSubview:imgView];
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
}

@end
