//
//  JFTopicViewController.m
//  JFImageDeal
//
//  Created by huangpengfei on 2018/6/1.
//  Copyright © 2018年 huangpengfei. All rights reserved.
//

#import "JFTopicViewController.h"
#import "JFHeader.h"
#import "JFCollectionViewCell.h"
#import "JFDetailViewController.h"
static NSString *cellID = @"CellID";
@interface JFTopicViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, copy) NSMutableArray *dataArray;
@end

@implementation JFTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.minimumInteritemSpacing = 5;
    CGFloat width = kScreenW * 0.5 - 10;
    CGFloat height = width * 9 / 9;
    self.flowLayout.itemSize = CGSizeMake(width,height);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 5, 0, 5);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[JFCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSString *pic = self.dataArray[indexPath.row];
    cell.pic = pic;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *pic = self.dataArray[indexPath.row];
    NSLog(@"%@",pic);
    
    NSArray *arr = @[@"全部",@"插画",@"中国风",@"特效设计",@"涂鸦",@"画集",@"手绘",@"摄影",@"科幻",@"著名作品",@"儿童",@"动漫",@"卡通",@"自由"];
    JFDetailViewController *detailVC = [[JFDetailViewController alloc] initWithNaviBar:YES backButton:YES];
    detailVC.titleArray = [arr copy];
    detailVC.dataArray = [self.dataArray copy];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] initWithObjects:
                      @"http://p2.iaround.com/201804/10/PHOTO/de321d3901c1eb9103f4d37da64e3a18_750x1000.jpg",
                      @"http://p4.iaround.com/201805/26/PHOTO/1b9d138560826e66ce2d0187e67a863d_414x414.jpg",
                      @"http://p1.iaround.com/201805/29/PHOTO/e6d862fb6a1e75f25dd640093c1204c4_750x1500.jpg",
                      @"http://p4.iaround.com/201803/05/PHOTO/99f318cf4d22a0f96510ea3be94d7c01_540x540.jpg",
                      @"http://p3.iaround.com/201802/27/PHOTO/29dc7da02a42b2ddbf941bf6842e35b9_640x640.png",
                      @"http://p3.iaround.com/201805/30/PHOTO/03228327759d37212360bea5a877df7f_720x1280.jpg",
                      @"http://p3.iaround.com/201805/18/PHOTO/5123a1bc7674fef202ed067dfd3af6df_660x660.jpg",
                      @"http://p3.iaround.com/201805/11/PHOTO/772acfc538b7f8c9440b611284c33114_750x1333.jpg",
                      @"http://p7.iaround.com/201803/18/PHOTO/babeeb329490d607b3e9a0d7b98d4994_750x750.jpg",
                      @"http://p4.iaround.com/201803/08/PHOTO/b778a0c766d17bbcee0f1bcd94be0d64_750x1333.jpg",
                      @"http://p3.iaround.com/201805/13/PHOTO/f6aa343a368a458f7ca52e0bdedf0dba_750x750.jpg",
                      @"http://p2.iaround.com/201804/13/PHOTO/18f6f23babfb95cc15afc2c1ac7d076f_750x1000.jpg",
                      @"http://p4.iaround.com/201805/11/PHOTO/d542592430c583bdf4eeec489496a289_414x414.jpg",
                      @"http://p1.iaround.com/201802/02/PHOTO/3c56a2f038ff7480dbb1e5d37a89025a_750x1000.jpg",
                      @"http://p7.iaround.com/201802/07/PHOTO/42a8a1de41a55eeca1fdf9573a87d9fe_720x720.jpg",
                      @"http://p3.iaround.com/201802/27/PHOTO/eeae88019019ae313b50960159882753_540x540.jpg",
                      @"http://p4.iaround.com/201805/18/PHOTO/41782611cff1d375f92eee3a76ad18e5_750x1333.png",
                      @"http://p2.iaround.com/201803/02/PHOTO/9124d602281cce4fc6bc6a652275ed46_750x1333.png",
                      @"http://p2.iaround.com/201805/16/PHOTO/d7d36a774ba034940b40d812d9c6d869_750x1333.jpg",
                      @"http://p1.iaround.com/201804/17/PHOTO/78efb22fa49024c9cc05609a1d17f9e5_750x1000.jpg",
                      @"http://p4.iaround.com/201805/11/PHOTO/d542592430c583bdf4eeec489496a289_414x414.jpg",
                      @"http://p1.iaround.com/201802/02/PHOTO/3c56a2f038ff7480dbb1e5d37a89025a_750x1000.jpg",
                      @"http://p4.iaround.com/201805/18/PHOTO/41782611cff1d375f92eee3a76ad18e5_750x1333.png",
                      @"http://p2.iaround.com/201803/02/PHOTO/9124d602281cce4fc6bc6a652275ed46_750x1333.png",
                      @"http://p2.iaround.com/201805/16/PHOTO/d7d36a774ba034940b40d812d9c6d869_750x1333.jpg",
                      @"http://p1.iaround.com/201804/17/PHOTO/78efb22fa49024c9cc05609a1d17f9e5_750x1000.jpg",
                      @"http://p7.iaround.com/201804/23/PHOTO/a6af9d8003b0c62c225cc064e9eafeb1_672x1280.jpg",
                      @"http://p4.iaround.com/201805/08/PHOTO/995ecabdda678d4027468423f7e8df10_414x414.jpg",
                      @"http://p7.iaround.com/201802/07/PHOTO/42a8a1de41a55eeca1fdf9573a87d9fe_720x720.jpg",
                      @"http://p3.iaround.com/201802/27/PHOTO/eeae88019019ae313b50960159882753_540x540.jpg",
                      @"http://p3.iaround.com/201805/30/PHOTO/31a5b0dd6677ee3536fa24ededa84dd7_414x414.jpg",
                      @"http://p7.iaround.com/201804/24/PHOTO/7a09611bd9f4cd2814bd743390766813_750x1000.jpg",
                      @"http://p2.iaround.com/201805/11/PHOTO/cea4315f79fdcbf42fd4777eb004188a_375x375.jpg",
                      @"http://p1.iaround.com/201803/20/PHOTO/d90045595cf78c748a75dfcbc4c12872_750x1000.jpg",
                      @"http://p3.iaround.com/201805/31/PHOTO/664369594bda5f882cf3858478b264be_750x1333.jpg",
                      @"http://p2.iaround.com/201803/23/PHOTO/0019053b8b6d321fa07da737d2773ed8_750x1000.jpg",
                      @"http://p2.iaround.com/201804/03/PHOTO/7504d0f6931b148bad4b037323e66f76_750x1333.jpg",
                      @"http://p2.iaround.com/201802/09/PHOTO/d2f76f30da56601c94083ff3bbddc79d_720x1280.jpg",
                      @"http://p1.iaround.com/201802/01/PHOTO/159572896b0f51cc4541c9e33863c50a_750x1000.jpg",
                      @"http://p2.iaround.com/201803/21/PHOTO/3c2b7318482e7d746b8514a263eaf821_600x750.jpg",
                      @"http://p2.iaround.com/201805/14/PHOTO/7f1a9d554182f9cb87d47c69156219e2_414x414.jpg",
                      @"http://p4.iaround.com/201804/09/PHOTO/cf858449aa68a7e6dc9c76ccb05d7493_720x1280.jpg",
                      @"http://p3.iaround.com/201802/08/PHOTO/5be3478db8c472916939c2e0b1177efb_750x1333.jpg",
                      @"http://p3.iaround.com/201803/10/PHOTO/6e7af30c7137d4a3fb21816514999465_750x1333.jpg",
                      @"http://p1.iaround.com/201804/10/PHOTO/557e5442f140e2f7ab17c6c1d79faf68_750x1333.jpg",
                      @"http://p3.iaround.com/201803/08/PHOTO/9ede9171a34356855cad457dd97fdcbd_750x750.jpg",
                      @"http://p3.iaround.com/201805/12/PHOTO/144e62fdbb7acb85fb9ab4bf40c751d4_720x1280.jpg",
                      @"http://p3.iaround.com/201804/04/PHOTO/8f0358fa54ff60a0ec77225b10ae5fe3_750x1333.jpg",
                      @"http://p2.iaround.com/201805/14/PHOTO/7f1a9d554182f9cb87d47c69156219e2_414x414.jpg",
                      @"http://p4.iaround.com/201804/09/PHOTO/cf858449aa68a7e6dc9c76ccb05d7493_720x1280.jpg",
                      @"http://p1.iaround.com/201804/10/PHOTO/557e5442f140e2f7ab17c6c1d79faf68_750x1333.jpg",
                      @"http://p3.iaround.com/201803/08/PHOTO/9ede9171a34356855cad457dd97fdcbd_750x750.jpg",
                      @"http://p3.iaround.com/201805/12/PHOTO/144e62fdbb7acb85fb9ab4bf40c751d4_720x1280.jpg",
                      @"http://p3.iaround.com/201804/04/PHOTO/8f0358fa54ff60a0ec77225b10ae5fe3_750x1333.jpg",
                      @"http://p7.iaround.com/201802/12/PHOTO/b9153ff8fc1b1f2365f9f543b6c34e99_750x1333.jpg",
                      @"http://p3.iaround.com/201802/08/PHOTO/5be3478db8c472916939c2e0b1177efb_750x1333.jpg",
                      @"http://p1.iaround.com/201801/24/FACE/57924942.jpg", nil];
    }
    return _dataArray;
}

@end
