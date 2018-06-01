//
//  JFNavigationController.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFNavigationController.h"


@interface JFNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation JFNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBackIndicatorTransitionMaskImage:[[UIImage alloc]init]];
    [self.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self setNavigationBarHidden:YES animated:NO];
    
    //1.解决 interactivePopGestureRecognizer 卡住的问题
    __weak JFNavigationController * weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

//push的时候判断到子控制器的数量。当大于零时隐藏BottomBar 也就是UITabBarController 的tababar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏底部bar
    if(self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //2.解决 interactivePopGestureRecognizer 卡住的问题
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES ) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
//    if ([self.topViewController isKindOfClass:NSClassFromString(@"ZHFGroupChatViewController")]) {
//        //退出时礼物系统取消所有的未执行的操作,删除队列
//        [[FYGiftOperationManger shareOperationManger] clearAllOperationWithIsClearWorldQueue:NO];
//
//        [self.topViewController.view endEditing:YES];
//    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)navigationDismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        for (id vc in self.viewControllers) {
            __weak id weakSelf = vc;
//            [[ZHFAppExecutant getSingleton].vcDelegateArr removeObject:weakSelf];
        }
    }];
}

- (void)navigationPopViewControllerWithIndex:(NSInteger)index
{
    NSInteger vcNum = self.viewControllers.count;
    if (index > vcNum) {
        NSLog(@"navigation 中没有这么多页面");
        return;
    }
    
    NSInteger indexAA = vcNum-(index+1);
    
    for (int i = 0; i < vcNum; i++) {
        
        if (i > indexAA) {
            __weak id weakSelf = self.viewControllers[i];
//            [[ZHFAppExecutant getSingleton].vcDelegateArr removeObject:weakSelf];
        }
    }
    [self popToViewController:self.viewControllers[indexAA] animated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *controller = [super popViewControllerAnimated:animated];
    
    //页面返回的时候,如果页面展示是用户领取金币页面,要回调block刷新礼物面板的金币
    if ([controller isKindOfClass:NSClassFromString(@"AboutYJWebVC")]) {
        
//        AboutYJWebVC * aboutVC = (AboutYJWebVC *)controller;
//        if (aboutVC.getGlodBlock) {
//            aboutVC.getGlodBlock();
//        }
    }
    return controller;
}

//3.解决 interactivePopGestureRecognizer 卡住的问题
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer == self.interactivePopGestureRecognizer ) {
        if (self.viewControllers.count < 2
            || self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}
@end

