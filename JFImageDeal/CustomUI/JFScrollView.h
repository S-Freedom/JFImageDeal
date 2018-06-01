//
//  JFScrollView.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFScrollView : UIScrollView
@property (nonatomic, copy) void (^scrollTitleBlock)(NSInteger tag);
@end
