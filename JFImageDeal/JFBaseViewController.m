//
//  JFBaseViewController.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFBaseViewController.h"
#define leftBtnTag 2000
#import "JFHeader.h"
#import "JFNavigationController.h"
@interface JFBaseViewController ()
{
    UIButton * backBtn;
    UILabel * myTitleLabel;
    NSString * selfTitle;
    __weak id _weakSelf;
}
@end

@implementation JFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (instancetype)initWithNaviBar:(BOOL)hasNaviBar backButton:(BOOL)hasBtn
{
    self = [super init];
    if (self) {
        
        _hasNaviBar = hasNaviBar;
        
        _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 44+kStatusbarH)];
        _naviBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_naviBar];
        
        myTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenW-200)/2, kStatusbarH, 200, 44)];
        myTitleLabel.font = [UIFont systemFontOfSize:16.0f];
        myTitleLabel.textColor = ZHFColorRGB(34, 34, 34, 1);
        myTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        //返回按钮
        backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"bg_navi_backBtnIamge.png"] forState:UIControlStateNormal];
        backBtn.tag = leftBtnTag;
        backBtn.frame = CGRectMake(0, kStatusbarH, 40, 44);
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 13, 12, 7);
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_hasNaviBar) {
            
            [_naviBar addSubview:myTitleLabel];
            
            UIView * lowline = [[UIView alloc] initWithFrame:CGRectMake(0, _naviBar.frame.size.height-0.5, kScreenW, 0.5)];
            lowline.backgroundColor = ZHFAllCutoffRuleColor;
            [_naviBar addSubview:lowline];
            
            if (hasBtn) {
                [_naviBar addSubview:backBtn];
            }
            
        }else {
            
            _naviBar.hidden = YES;
            [self.view addSubview:myTitleLabel];
            
            if (hasBtn) {
                [self.view addSubview:backBtn];
            }
        }
    }
    return self;
}

- (void)missViewController
{
    if (self.navigationController) {
        
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            JFNavigationController * navi = (JFNavigationController *)self.navigationController;
            [navi navigationDismiss];
        }
    }else {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

- (void)backBtnClick:(UIButton *)btn {
    [self missViewController];
}

@end
