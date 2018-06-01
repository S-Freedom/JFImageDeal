//
//  JFDetailViewController.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFDetailViewController.h"
#import "JFSubTopicScrollView.h"
#import "JFHeader.h"
#import "JFCollectionViewCell.h"
#import "JFDetailViewController.h"
#import "JFDetailCell.h"
#import "JFButton.h"
#import "JFScrollView.h"
static NSString *cellID = @"CellID";
@interface JFDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) JFScrollView *scrollView;
@property (nonatomic, strong) JFSubTopicScrollView *topicView;
@property (nonatomic, strong) NSMutableArray<UICollectionView *> *collectionViews;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation JFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JFSubTopicScrollView *topicView = [[JFSubTopicScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, 40)];
    self.topicView = topicView;
    [self.view addSubview:topicView];
    
    self.scrollView = [[JFScrollView alloc] initWithFrame:CGRectMake(0, 114, kScreenW, kScreenH - 114)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    __weak typeof(self) weakSelf = self;
    [self.topicView setScrollBlock:^(NSInteger tag) {
        CGFloat widht = kScreenW * tag;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(widht, 0);
        }];
    }];
}

- (void)addColectionViewWithFrame:(CGRect)rect tag:(NSInteger)tag{
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:self.flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.tag = tag;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[JFDetailCell class] forCellWithReuseIdentifier:cellID];
    [self.scrollView addSubview:collectionView];
}

- (UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat width = kScreenW / 3.0f;
        CGFloat height = width;
        self.flowLayout.itemSize = CGSizeMake(width,height);
    }
    return _flowLayout;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSString *pic = self.dataArray[indexPath.row];
    cell.pic = pic;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *pic = self.dataArray[indexPath.row];
    NSLog(@"%@",pic);
    
//    NSArray *arr = @[@"全部",@"插画",@"中国风",@"特效设计",@"涂鸦",@"画集",@"手绘",@"摄影",@"科幻",@"著名作品",@"儿童",@"动漫",@"卡通",@"自由"];
//    JFDetailViewController *detailVC = [[JFDetailViewController alloc] initWithNaviBar:YES backButton:YES];
//    detailVC.dataArray = [arr copy];
//    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    __weak typeof(self) weakSelf = self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    if(y > 0) return;
    
    NSInteger tag = scrollView.contentOffset.x / kScreenW;
    NSLog(@"%li",tag);
    JFButton *btn = self.topicView.btns[tag];
    [self.topicView btnClick:btn];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"%s",__func__);
}

- (void)setTitleArray:(NSMutableArray *)titleArray{
    _titleArray = [titleArray copy];
    self.topicView.subTitleArray = self.titleArray;
    
    NSInteger count = _titleArray.count;
    CGFloat width = kScreenW;
    CGFloat height = self.scrollView.bounds.size.height;
    self.scrollView.contentSize = CGSizeMake(count * width, height);
    for(int i = 0; i< count; i++){
        CGRect rect = CGRectMake(width * i, 0, width, height);
        NSLog(@"%@",NSStringFromCGRect(rect));
        [self addColectionViewWithFrame:rect tag:i];
    }
}


@end
