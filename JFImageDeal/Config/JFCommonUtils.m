//
//  JFCommonUtils.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFCommonUtils.h"


@implementation JFCommonUtils
#pragma mark - 返回顶部状态栏高度

+ (CGFloat)device_returnStatusbarHeight
{
    NSUserDefaults * userDefa = [NSUserDefaults standardUserDefaults];
    
    NSString * iphoneDevice = [userDefa objectForKey:@"ZHF_iPhoneDevice"];
    if (iphoneDevice == nil || [iphoneDevice isEqual:[NSNull null]]) {
        //没有存储过, 需要判断
        if ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO) {
            //是iPhone X
            [userDefa setObject:@"iPhone_X_zhf" forKey:@"ZHF_iPhoneDevice"];
            return 44.0f;
        }else {
            [userDefa setObject:@"not_iPhone_X_zhf" forKey:@"ZHF_iPhoneDevice"];
            return 20.0f;
        }
    }else {
        if ([iphoneDevice isEqualToString:@"iPhone_X_zhf"]) {
            return 44.0f;
        }else {
            return 20.0f;
        }
    }
}

+ (CGFloat)device_returnTabbarHeight
{
    return [self device_returnStatusbarHeight]==20.0f?0.0f:34.0f;
}

+ (UIImage *)createImageWithColor:(UIColor*)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

//返回文字size
+ (CGSize)returnSizeWithString:(NSString *)str font:(UIFont *)font size:(CGSize)size
{
    if (font == nil || str == nil || [str isEqual:[NSNull null]]) {
        return CGSizeMake(1, 1);
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize retSize = [str boundingRectWithSize:size
                                       options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    return retSize;
}
@end
