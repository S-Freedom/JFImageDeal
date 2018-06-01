//
//  JFTabBarItem.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFTabBarItem.h"
#import "JFHeader.h"
static CGFloat spacing = 0; //间隔
static CGFloat verticalOffset = 0; //垂直偏移

@interface JFTabBarItem ()

@end
@implementation JFTabBarItem

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
    
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType {
    JFTabBarItem *item = [super buttonWithType:buttonType];
    [item setup];
    return item;
}

- (void)setup {
    
    self.adjustsImageWhenHighlighted = NO;
    _badgeStyle = JFTabBarItemBadgeStyleNumber;
    //    self.backgroundColor = BackgroundColor;
}

- (void)createDragBubbleView
{
    if (_bubbleView) {
        return;
    }
    
    _bubbleView  = [[JFBubbleView alloc] initWithCenterPoint:CGPointMake(self.frame.size.width/2+JF_autoSize_X(13), JF_autoSize_X(16)) bubleRadius:JF_autoSize_X(10) addToSuperView:self];
    _bubbleView.decayCoefficent = .2;
    _bubbleView.bubbleColor = JFAllBackGroundRed;
    
    __weak typeof(self) weakSelf = self;
    self.bubbleView.cleanMessageBlock = ^(BOOL isClean) {
        if (isClean) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kCleanMessage object:nil userInfo:@{@"tag":@(weakSelf.tag-ZHFTabBarTag)}];
        } else {
            
        }
    };
}

/**
 *  覆盖父类的setHighlighted:方法，按下ZHFTabBarItem时，不高亮该item
 */
- (void)setHighlighted:(BOOL)highlighted {
    
    if (self.adjustsImageWhenHighlighted) {
        [super setHighlighted:highlighted];
    }
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if ([self imageForState:UIControlStateNormal]) {
        
        CGSize titleSize = self.titleLabel.frame.size;
        CGSize imageSize = self.imageView.frame.size;
        titleSize = CGSizeMake(ceilf(titleSize.width), ceilf(titleSize.height));
        CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
        
        self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height - verticalOffset), 0, 0, - titleSize.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(verticalOffset, - imageSize.width, - (totalHeight - titleSize.height), 0);
        
    } else {
        self.imageEdgeInsets = UIEdgeInsetsZero;
        self.titleEdgeInsets = UIEdgeInsetsZero;
    }
}

#pragma mark - Title and Image

- (void)setTitle:(NSString *)title {
    
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:DefaultTitleColor forState:UIControlStateNormal];
    [self setTitleColor:SelectedTitleColor forState:UIControlStateSelected];
    self.titleLabel.font = TitleFont;
}

-(void)setDefaultImage:(UIImage *)defaultImage {
    
    _defaultImage = defaultImage;
    [self setImage:defaultImage forState:UIControlStateNormal];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
    
    _selectedImage = selectedImage;
    [self setImage:selectedImage forState:UIControlStateSelected];
}

#pragma mark - Badge

- (void)setBadge:(NSInteger)badgeNumber style:(JFTabBarItemBadgeStyle)style
{
    [self createDragBubbleView];
    
    _badge = badgeNumber;
    _badgeStyle = style;
    [self updateBadge];
}

- (void)updateBadge {
    
    if (self.badgeStyle == JFTabBarItemBadgeStyleNumber) {
        
        if (self.badge == 0) {
            
            [_bubbleView hidenBubbleView];
            
        } else {
            
            [_bubbleView showBubbleView];
            
            NSString * badgeStr = @(self.badge).stringValue;
            
            if (self.badge > 99) {
                badgeStr = @"99+";
            } else if (self.badge < -99) {
                badgeStr = @"-99+";
            }
            
            [_bubbleView setBadgeNumber:badgeStr isPoint:NO];
            
        }
        
    } else if (self.badgeStyle == JFTabBarItemBadgeStyleDot) {
        
        if (self.badge == 0) {
            
            [_bubbleView hidenBubbleView];
            
        }else {
            
            [_bubbleView setBadgeNumber:@"" isPoint:YES];
        }
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
