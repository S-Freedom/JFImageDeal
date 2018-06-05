//
//  JFCollectionViewCell.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFCollectionViewCell.h"
#import "Masonry.h"
//#import "UIImageView+WebCache.h"
#import "JFCommonUtils.h"
#import "YYImageCoder.h"
#import "UIImageView+YYWebImage.h"
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
//    UIImage *placeHolderImg = [JFCommonUtils createImageWithColor:[UIColor lightGrayColor]];
//    [self.imageView sd_setImageWithURL:url placeholderImage:placeHolderImg];
    
    UIImage *placeHolderImg = [JFCommonUtils createImageWithColor:[UIColor lightGrayColor]];
    [self.imageView setImageWithURL:url placeholder:placeHolderImg];
    
//    NSData *sourceData = [NSData dataWithContentsOfURL:url];
//    NSLog(@"sourceData %ld kb",sourceData.length/1000);
//    UIImage *img = [UIImage imageWithData:sourceData];
//     NSData *data = UIImageJPEGRepresentation(img, 1.0f);
//    do {
//         data = UIImageJPEGRepresentation(img, 1.0f);
//    } while (data.length > 50000);
//
//    NSLog(@"%ld kb ",data.length/1000);
//    CGSize size = self.contentView.bounds.size;
////    UIImage *newImg = [self imageByScalingAndCroppingForSize:size withSourceImage:img];
////    self.imageView.image = newImg;
//    NSLog(@"\n\n");
}

/**
 * 图片压缩到指定大小
 * @param targetSize 目标图片的大小
 * @param sourceImage 源图片
 * @return 目标图片
 */
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
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
