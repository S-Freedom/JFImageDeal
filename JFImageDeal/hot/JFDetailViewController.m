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
#import <AVFoundation/AVFoundation.h>
#import "FSAudioStream.h"

static NSString *cellID = @"CellID";
@interface JFDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate,AVAudioRecorderDelegate>

@property (nonatomic, strong) JFScrollView *scrollView;
@property (nonatomic, strong) JFSubTopicScrollView *topicView;
@property (nonatomic, strong) NSMutableArray<UICollectionView *> *collectionViews;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) FSAudioStream *stream;
@end

@implementation JFDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *urlStr = @"http://sc1.111ttt.cn/2018/1/03/13/396131226156.mp3";
//    NSURL *url = [NSURL URLWithString:urlStr];
//    self.stream = [[FSAudioStream alloc] initWithUrl:url];
//    self.stream.strictContentTypeChecking = NO;
////    self.stream.defaultContentType = @"audio/mpeg";
//    [self.stream setOnCompletion:^{
//        NSLog(@"over");
//    }];
//
//    [self.stream setOnStateChange:^(FSAudioStreamState state) {
//         NSLog(@"statechange %ld",state);
//    }];
//    [self.stream setOnFailure:^(FSAudioStreamError error, NSString *errorDescription) {
//        NSLog(@"fail %@", errorDescription);
//    }];
    
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100,50)];
    btn.tag = 1;
    [btn setTitle:@"record" forState:UIControlStateNormal];
    [btn setTitle:@"record-pause" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *play = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100,50)];
    play.tag = 1001;
    [play setTitle:@"play" forState:UIControlStateNormal];
    [play setTitle:@"play-pause" forState:UIControlStateSelected];
    [play setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [play addTarget:self action:@selector(playPause:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:play];
    
    UIButton *reverse = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100,50)];
    reverse.tag = 1001;
    [reverse setTitle:@"play" forState:UIControlStateNormal];
    [reverse setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [reverse addTarget:self action:@selector(rever:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reverse];
    //
    //    [self setAVAudioSession];
    //    [self initRecord];
    //    [self initPlay];
    
    
    //    JFSubTopicScrollView *topicView = [[JFSubTopicScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenW, 40)];
    //    self.topicView = topicView;
    //    [self.view addSubview:topicView];
    //
    //    self.scrollView = [[JFScrollView alloc] initWithFrame:CGRectMake(0, 114, kScreenW, kScreenH - 114)];
    //    self.scrollView.pagingEnabled = YES;
    //    self.scrollView.delegate = self;
    //    [self.view addSubview:self.scrollView];
    //
    //    __weak typeof(self) weakSelf = self;
    //    [self.topicView setScrollBlock:^(NSInteger tag) {
    //        CGFloat widht = kScreenW * tag;
    //        [UIView animateWithDuration:0.3 animations:^{
    //            weakSelf.scrollView.contentOffset = CGPointMake(widht, 0);
    //        }];
    //    }];
}

/* 获取录音存放路径 */
- (NSString *)getSaveFilePath{
    NSString *urlStr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                           NSUserDomainMask,YES).firstObject;
    urlStr = [urlStr stringByAppendingPathComponent:@"recorder.caf"];
    return urlStr;
}

- (void)click:(UIButton *)sender{
//    sender.selected = !sender.selected;
//    if(![self.recorder isRecording]){
//        [self.recorder record];
//
//    }else if([self.recorder isRecording]){
//        [self.recorder stop];
//    }
//    NSLog(@"%i",[self.recorder isRecording]);
    
   [self.stream play];
}

- (void)playPause:(UIButton *)sender{
//    [self initPlay];
//    [self.player play];
    [self.stream pause];
}

- (void)rever:(UIButton *)sender{
    FSStreamPosition pos = {1};
    pos.position = 0.0f;
    [self.stream seekToPosition:pos];
}

- (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0) {
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    bCanRecord = YES;
                } else {
                    bCanRecord = NO;
                }
            }];
        }
    }
    
    NSLog(@"bCanRecord1 : %d",bCanRecord);
    return bCanRecord;
}

- (void)initRecord{
    NSString *path = [self getSaveFilePath];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithCapacity:10];
//    [mDic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
//    [mDic setObject:@(8000) forKey:AVSampleRateKey];
//    [mDic setObject:@(1) forKey:AVNumberOfChannelsKey];
//    [mDic setObject:@(8) forKey:AVLinearPCMBitDepthKey];
//    [mDic setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    //设置录音格式
    [mDic setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [mDic setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道,这里采用单声道
    [mDic setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [mDic setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [mDic setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    NSError *error;
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:mDic error:&error];
    if(error){
        NSLog(@"recorder %@",error);
    }
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
    [recorder prepareToRecord];
    self.recorder = recorder;
}

/* 设置音频会话支持录音和音乐播放 */
- (void)setAVAudioSession{
    //获取音频会话
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
    //激活修改
    [audioSession setActive:YES error:NULL];
}


- (void)initPlay{
    
    NSString *path = [self getSaveFilePath];
    NSURL *url = [NSURL URLWithString:path];
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if(error){
        NSLog(@"initPlay %@",error);
    }
    player.numberOfLoops = 0;
    self.player = player;
}


#pragma mark -- AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"%s",__func__);
    [self.player prepareToPlay];
    [self.player play];
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    NSLog(@"%s",__func__);
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
    self.topicView.isHot = self.isHot;
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
