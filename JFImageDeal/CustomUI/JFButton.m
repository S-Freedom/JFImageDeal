//
//  JFButton.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFButton.h"

@implementation JFButton

- (instancetype)init{
    if(self = [super init]){
        [self setTitle:@"" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

+ (JFButton *)createButtonWithTitle:(NSString *)title{
    return [self createButtonWithTitle:title norColor:nil selectColor:nil hightLightColor:nil img:nil font:nil];
}

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor{
    return [self createButtonWithTitle:title norColor:norColor selectColor:nil hightLightColor:nil img:nil font:nil];
}

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor img:(NSString *)imgName font:(UIFont *)font{
    return [self createButtonWithTitle:title norColor:norColor selectColor:nil hightLightColor:nil img:imgName font:font];
}

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor font:(UIFont *)font{
    return [self createButtonWithTitle:title norColor:norColor selectColor:nil hightLightColor:nil img:nil font:font];
}

+ (JFButton *)createButtonWithTitle:(NSString *)title norColor:(UIColor *)norColor selectColor:(UIColor *)selectColor hightLightColor:(UIColor *)hightLightColor img:(NSString *)imgName font:(UIFont *)font{
    JFButton *btn = [[JFButton alloc] init];
    if(title) [btn setTitle:title forState:UIControlStateNormal];
    if(norColor) [btn setTitleColor:norColor forState:UIControlStateNormal];
    if(font) btn.titleLabel.font = font;
    if(selectColor) [btn setTitleColor:selectColor forState:UIControlStateSelected];
    if(hightLightColor) [btn setTitleColor:hightLightColor forState:UIControlStateHighlighted];
    if(imgName) [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    
    return btn;
}


@end
