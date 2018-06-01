//
//  JFLabel.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFLabel : UILabel

+ (JFLabel *)createLabelWithTitle:(NSString *)title;
+ (JFLabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color;
+ (JFLabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;
+ (JFLabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font align:(NSTextAlignment)align;

@end
