//
//  JFSubTopicScrollView.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFSubTopicScrollView.h"

@interface JFSubTopicScrollView()

@property (nonatomic, strong) UIView *bottomView;
@end

@implementation JFSubTopicScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor lightGrayColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, 100, 0.5)];
        self.bottomView.backgroundColor = [UIColor redColor];
        [self addSubview:self.bottomView];
        self.btns = [NSMutableArray arrayWithCapacity:10];
        
        if(self.scrollBlock){
            __weak typeof(self) weakSelf = self;
            [self setScrollBlock:^(NSInteger tag) {
                [weakSelf changeBottomFrameWithFrame:tag];
            }];
        }
    }
    return self;
}

- (void)setSubTitleArray:(NSArray *)subTitleArray{
    _subTitleArray = [subTitleArray copy];
    
    [self.btns removeAllObjects];
    CGFloat width = 50;
    CGFloat height = 40;
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i<_subTitleArray.count; i++) {
        NSString *title = _subTitleArray[i];
        JFButton *btn = [JFButton createButtonWithTitle:title norColor:[UIColor blackColor] selectColor:nil hightLightColor:nil img:nil font:[UIFont systemFontOfSize:14.0f]];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        width = [JFCommonUtils returnSizeWithString:title font:btn.titleLabel.font size:CGSizeMake(100, 40)].width;
        btn.frame = CGRectMake(x, y, width + 20, height);
        [self addSubview:btn];
        [self.btns addObject:btn];
        x = CGRectGetMaxX(btn.frame) + 5;
    }
    
    CGFloat maxW = x;
    self.contentSize = CGSizeMake(maxW, 40);
    
    if(_subTitleArray.count > 0){
        JFButton *btn = self.btns.firstObject;
        [self changeBottomFrameWithFrame:btn.tag];
    }
}

- (void)btnClick:(UIButton *)sender{
    NSLog(@"%ld click %@",sender.tag, sender.titleLabel.text);
    if(self.scrollBlock){
        self.scrollBlock(sender.tag);
    }
    
    CGPoint point = sender.center;
    CGFloat halfScreenW = kScreenW * 0.5;
    CGFloat maxOffsetW = self.contentSize.width - halfScreenW;
    [self changeBottomFrameWithFrame:sender.tag];
    if(point.x <= halfScreenW){
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
        return;
    }else  if(maxOffsetW <= point.x){
        point.x = maxOffsetW;
    }
    point.x = point.x - halfScreenW;
    [self setContentOffset:CGPointMake(point.x, 0) animated:YES];
}

- (void)changeBottomFrameWithFrame:(NSInteger)tag{
    JFButton *btn = self.btns[tag];
     __block CGRect rect = self.bottomView.frame;
    CGRect firstBtnFrame = btn.frame;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        rect.origin.x = firstBtnFrame.origin.x;
        rect.size = CGSizeMake(firstBtnFrame.size.width, 0.5);
        weakSelf.bottomView.frame = rect;
    }];
}
@end
