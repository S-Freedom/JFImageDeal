//
//  JFCommonUtils.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JFCommonUtils : NSObject
#pragma mark - 返回顶部状态栏高度
+ (CGFloat)device_returnStatusbarHeight;
+ (CGFloat)device_returnTabbarHeight;
+ (UIImage *)createImageWithColor:(UIColor *)color;

+ (CGSize)returnSizeWithString:(NSString *)str font:(UIFont *)font size:(CGSize)size;
@end
