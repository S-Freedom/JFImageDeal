//
//  JFSubTopicScrollView.h
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "JFLabel.h"
#import "JFCommonUtils.h"
#import "JFButton.h"
#import "JFHeader.h"
@interface JFSubTopicScrollView : UIScrollView

@property (nonatomic, copy) NSArray *subTitleArray;

@property (nonatomic, copy) void (^scrollBlock)(NSInteger tag);
@property (nonatomic, strong) NSMutableArray<JFButton *> *btns;
@property (nonatomic, assign) BOOL isHot;
- (void)changeBottomFrameWithFrame:(NSInteger)tag;
- (void)btnClick:(UIButton *)sender;
@end
