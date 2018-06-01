//
//  JFLabel.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFLabel.h"

@implementation JFLabel

- (instancetype)init{
    if(self = [super init]){
        self.text = @"";
        self.textColor = [UIColor blackColor];
        self.textAlignment = NSTextAlignmentLeft;
        self.font = [UIFont systemFontOfSize:14.0f];
    }
    return self;
}

+ (JFLabel *)createLabelWithTitle:(NSString *)title{
    return [self createLabelWithTitle:title color:nil font:nil align:0];
}
+ (JFLabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color{
    return [self createLabelWithTitle:title color:color font:nil align:0];
}
+ (JFLabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font{
    return [self createLabelWithTitle:title color:color font:font align:0];
}
+ (JFLabel *)createLabelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font align:(NSTextAlignment)align{
    JFLabel *label = [[JFLabel alloc] init];
    if(title) label.text = title;
    if(color) label.textColor = color;
    if(font)  label.font = font;
    if(align) label.textAlignment = align;
    return label;
}
@end
