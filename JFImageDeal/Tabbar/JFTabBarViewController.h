//
//  JFTabBarViewController.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFTabBarViewController : UITabBarController
@property (strong, nonatomic) UIImageView * tabBarView;//自定义的覆盖原先的tarbar的控件

-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean;

//改变底部展示
- (void)changTabbarSelectIndex:(NSInteger)indexTag;
@end
