//
//  JFButton.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFButton : UIButton

+ (JFButton *)createButtonWithTitle:(NSString *)title;

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor;

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor img:(NSString *)imgName font:(UIFont *)font;

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor font:(UIFont *)font;

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor selectColor:(UIColor *)selectColor hightLightColor:(UIColor *)hightLightColor img:(NSString *)imgName font:(UIFont *)font;

@end
