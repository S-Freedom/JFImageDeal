//
//  JFBaseViewController.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFBaseViewController : UIViewController
//{
//    ZHFRefreshHeader * _header;
//    ZHFRefreshFooter * _footer;
//}

@property (nonatomic, strong) UIView * naviBar;
@property (nonatomic, assign) BOOL hasNaviBar; //是否有navi

//创建调用此方法
- (instancetype)initWithNaviBar:(BOOL)hasNaviBar backButton:(BOOL)hasBtn;

//dismiss调用此方法
- (void)missViewController;

//vc消失前执行 (放入.h主要为了聊吧跳转聊吧的时候退出之前的聊吧)
- (void)selfWillDealloc;

@end
