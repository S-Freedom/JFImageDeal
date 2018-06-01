//
//  JFTabBarItem.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//
#import "JFBubbleView.h"
#import <UIKit/UIKit.h>
#import "JFTabBarItem.h"
/**
 *  Badge样式
 */
typedef NS_ENUM(NSInteger, JFTabBarItemBadgeStyle) {
    JFTabBarItemBadgeStyleNumber = 0, // 数字样式
    JFTabBarItemBadgeStyleDot = 1, // 小圆点
};
@interface JFTabBarItem : UIButton

//拖拽视图
@property (nonatomic, strong) JFBubbleView * bubbleView;

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong) UIImage * defaultImage;
@property (nonatomic, strong) UIImage * selectedImage;

//显示badge数值
@property (nonatomic, assign) NSInteger badge;
//badge的样式，支持数字样式和小圆点
@property (nonatomic, assign) JFTabBarItemBadgeStyle badgeStyle;

//设置badge和badgeStyle使用此方法
- (void)setBadge:(NSInteger)badgeNumber style:(JFTabBarItemBadgeStyle)style;
@end
