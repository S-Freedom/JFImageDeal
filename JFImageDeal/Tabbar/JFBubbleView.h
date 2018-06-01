//
//  JFBubbleView.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CleanMessageBlock)(BOOL);

@interface JFBubbleView : UIView

@property (nonatomic, copy) CleanMessageBlock cleanMessageBlock;

//  气泡颜色
@property (nonatomic, strong) UIColor *bubbleColor;

//  拉伸系数，取值（0~1），系数越大，拉伸距离越长。
@property (nonatomic, assign) CGFloat decayCoefficent;

//设置未读数,是否为小红点
- (void)setBadgeNumber:(NSString *)numberStr isPoint:(BOOL)isPoint;

/**
 *  初始化bubbleView
 *
 *  @param centerPoint 中心点坐标
 *  @param radius      半径
 *  @param superView   父视图
 *
 *  @return 实例对象
 */
- (instancetype)initWithCenterPoint:(CGPoint)centerPoint bubleRadius:(CGFloat)radius addToSuperView:(UIView *)superView;

//隐藏气泡
- (void)hidenBubbleView;

//显示气泡
- (void)showBubbleView;

@end
