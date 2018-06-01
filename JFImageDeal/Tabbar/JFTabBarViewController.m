//
//  JFTabBarViewController.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFTabBarViewController.h"
#import "JFTabBarItem.h"
#import "JFNavigationController.h"
#import "JFHotViewController.h"
#import "JFTopicViewController.h"
#import "JFMineViewController.h"
#import "JFHeader.h"
@interface JFTabBarViewController ()
{
    JFTabBarItem * _previousItem;//记录前一次选中的按钮
    
    NSArray * titleArr; //tabbar标题
}

@end

@implementation JFTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = @"TabBar";
        // Custom initialization
    }
    return self;
}

//防止自定义tabbar中, 每次显示系统动创建tabbarBtn覆盖
-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [child removeFromSuperview];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != _tabBarView) {//_tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -JF_autoSize_X(8), self.tabBar.frame.size.width, self.tabBar.frame.size.height+JF_autoSize_X(8))];
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.image = [[UIImage imageNamed:@"tab_background.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:20];
    [self.tabBar addSubview:_tabBarView];
    
    //----------
    
    [self createContent];
}

- (void)createContent
{
    JFNavigationController * topicNavi = [[JFNavigationController alloc] initWithRootViewController:[[JFTopicViewController alloc] initWithNaviBar:NO backButton:NO]];
    
    JFNavigationController * hotVC = [[JFNavigationController alloc] initWithRootViewController:[[JFHotViewController alloc] initWithNaviBar:NO backButton:NO]];
    
    JFNavigationController * mineVC = [[JFNavigationController alloc] initWithRootViewController:[[JFMineViewController alloc] initWithNaviBar:YES backButton:NO]];
    
    self.viewControllers = @[topicNavi, hotVC, mineVC];
    
    titleArr = @[@"主题",@"推荐",@"我的"];
    NSArray * normalImageArr = @[@"bg_Tabbar_Nearby_normal.png",
                                 @"bg_Tabbar_Chatroom_normal.png",
                                 @"bg_Tabbar_Message_normal.png"
                                 ];
    NSArray * selectImageArr = @[@"bg_Tabbar_Nearby_selected.png",
                                 @"bg_Tabbar_Chatroom_selected.png",
                                 @"bg_Tabbar_Message_selected.png"
                                ];
    
    for (int i = 0; i < titleArr.count; i++) {
        
        [self creatButtonWithNormalName:normalImageArr[i] andSelectName:selectImageArr[i] andTitle:titleArr[i] andIndex:i];
    }
    //去除tabbar上的黑线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

//改变底部展示
- (void)changTabbarSelectIndex:(NSInteger)indexTag
{
    //上面创建时调整了tabbar层级, [4, 3, 2, 1, 0] 排列层级, 但tag不变(0,1,2,3,4), 所以点击一次
    if (indexTag < 0 || indexTag > titleArr.count-1) { //判断在不在区间里
        indexTag = 3; //默认聊吧
    }
    
    [self changeViewController:_tabBarView.subviews[indexTag]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 创建一个按钮

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    
    JFTabBarItem * tabBarItem = [JFTabBarItem buttonWithType:UIButtonTypeCustom];
    tabBarItem.tag = ZHFTabBarTag + index;
    
    CGFloat buttonW = _tabBarView.frame.size.width / 3;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    tabBarItem.frame = CGRectMake(buttonW * index, JF_autoSize_X(4), buttonW, buttonH);
    [tabBarItem setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [tabBarItem setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [tabBarItem setTitle:title];
    
    [tabBarItem addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    tabBarItem.imageView.contentMode = UIViewContentModeCenter;
    tabBarItem.titleLabel.textAlignment = NSTextAlignmentCenter;
    tabBarItem.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [_tabBarView addSubview:tabBarItem];
    [_tabBarView sendSubviewToBack:tabBarItem];
    
    if(index == 0)//设置第一个选择项。（默认选择项）
    {
        _previousItem = tabBarItem;
        _previousItem.selected = YES;
    }
    
}

#pragma mark 按钮被点击时调用
- (void)changeViewController:(JFTabBarItem *)sender
{
    NSLog(@"点击底栏 tag = %zd", sender.tag-ZHFTabBarTag);
    
    if(self.selectedIndex != sender.tag - ZHFTabBarTag) {
        
        self.selectedIndex = sender.tag - ZHFTabBarTag; //切换不同控制器的界面
        _previousItem.selected = ! _previousItem.selected;
        _previousItem = sender;
        _previousItem.selected = YES;
    }else {
        NSLog(@"点击同一个");
    }
}

#pragma mark 是否隐藏tabBar
//wsq
-(void)isHiddenCustomTabBarByBoolean:(BOOL)boolean{
    
    _tabBarView.hidden=boolean;
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
