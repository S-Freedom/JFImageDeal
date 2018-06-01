//
//  JFHeader.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#ifndef JFHeader_h
#define JFHeader_h

#import "JFGlobalConfig.h"
#import "JFCommonUtils.h"
#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height
#define ZHFTabBarTag 12000
#define ZHFColorRGB(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255. alpha:A]
#define DefaultTitleColor ZHFColorRGB(155, 155, 155, 1)
#define SelectedTitleColor ZHFColorRGB(255, 64, 100, 1)
#define TitleFont [UIFont systemFontOfSize:14]
#define BackgroundColor [UIColor whiteColor]

#define ZHFAllBackgroundGray ZHFColorRGB(246,246,246,1)//全局灰背景
#define JFAllBackGroundRed ZHFColorRGB(255,64,100,1)//全局红色
#define ZHFAllCutoffRuleColor ZHFColorRGB(230, 230, 230, 1)//全局分割线颜色
#define ZHfAllCoverColor  ZHFColorRGB(67, 67, 78, 0.6) //蒙层颜色
#define JF_autoSize_X(x) ((x) * [JFGlobalConfig getSingleton].autoSizeX_iphone6)
#define kCleanMessage   @"kCleanMessage"    //小红点消失通知
#define kStatusbarH ([JFCommonUtils device_returnStatusbarHeight])
#define kTabbarH ([JFCommonUtils device_returnTabbarHeight])
#define kBaseNaviH (kStatusbarH+44.0f)
#endif /* JFHeader_h */
