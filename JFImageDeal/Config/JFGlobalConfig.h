//
//  JFGlobalConfig.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JFGlobalConfig : NSObject
@property (nonatomic, assign) float autoSizeX_iphone6; //以iphone6为标准
+ (JFGlobalConfig *)getSingleton;

@end
