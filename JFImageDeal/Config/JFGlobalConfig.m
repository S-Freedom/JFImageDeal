//
//  JFGlobalConfig.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFGlobalConfig.h"

@implementation JFGlobalConfig
+ (JFGlobalConfig *)getSingleton
{
    static JFGlobalConfig * _GlobalData;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _GlobalData = [[self alloc] init];
    });
    
    return _GlobalData;
}



@end
