//
//  JFNavigationController.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFNavigationController : UINavigationController
//整个navigation dismiss
- (void)navigationDismiss;

//pop几个页面
- (void)navigationPopViewControllerWithIndex:(NSInteger)index;

@end
