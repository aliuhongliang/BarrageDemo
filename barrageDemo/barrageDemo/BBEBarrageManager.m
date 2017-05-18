//
//  BBEBarrageManager.m
//  barrageDemo
//
//  Created by lihongwen-pc on 2017/1/13.
//  Copyright © 2017年 Univalsoft. All rights reserved.
//

#import "BBEBarrageManager.h"
#import "BBEBarrageView.h"

@interface BBEBarrageManager ()


// 存储弹幕view的数组
@property (nonatomic, strong) NSMutableArray *barrageViews;
// 所有的弹幕数组
@property (nonatomic, strong) NSMutableArray *barrages;

// 弹幕的父view
@property (nonatomic, weak) UIView *superV;
// 第一行弹幕的Y值
@property (nonatomic, assign) CGFloat firstLineY;

// 是否已经停止
@property (nonatomic, assign) BOOL stop_Animate;
// 是否是暂停
@property (nonatomic, assign) BOOL pause_Animate;

@end

@implementation BBEBarrageManager

- (instancetype) initWithSuperView:(UIView *)view andFirstLineY:(CGFloat)Y
{
    if (self = [super init]) {
        
        self.superV = view;
        _firstLineY = Y;
        self.lineMargin = 10;
        self.loop = YES;
        self.count = 3;
        self.stop_Animate = YES;
        self.pause_Animate = NO;
    }
    
    return self;
}

- (void)start
{
    if (!self.stop_Animate) {
        return;
    }
    
    if (self.pause_Animate) {
        [self resume];
        return;
    }
    self.stop_Animate = NO;
    
    
    [self.barrages removeAllObjects];
    [self.barrages addObjectsFromArray:self.barrageDataSource];
    
    // 创建弹幕view
    [self initBarrageView];
}

- (void)stop
{
    if (self.stop_Animate) {
        return;
    }
    self.stop_Animate = YES;
    
    [self.barrageViews enumerateObjectsUsingBlock:^(BBEBarrageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj stopAnimate];
        obj = nil;
    }];
    
    [self.barrageViews removeAllObjects];
}


- (void)pause
{
    
    self.stop_Animate = YES;
    if (self.pause_Animate) {
        return;
    }
    self.pause_Animate = YES;
    [self.barrageViews enumerateObjectsUsingBlock:^(BBEBarrageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj pauseAnimate];
    }];
}

- (void)resume
{
    self.stop_Animate = NO;
    if (!self.pause_Animate) {
        return;
    }
    self.pause_Animate = NO;
    [self.barrageViews enumerateObjectsUsingBlock:^(BBEBarrageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj resumeAnimate];
        
    }];
}


// 创建弹幕
- (void)initBarrageView
{
    // 1 创建弹道的个数
    NSMutableArray *trajectorys = [NSMutableArray array];
    for (NSInteger i = 0; i < self.count; i++) {
        [trajectorys addObject:@(i)];
    }
    
    for (NSInteger i = 0; i < self.count; i++) {
        
        // 获取弹道的轨迹
        NSInteger index = arc4random()%trajectorys.count;
        
        NSInteger trajectory = [trajectorys[index] integerValue];
        
        [trajectorys removeObjectAtIndex:index];
        
        // 取出第一条弹幕
        NSString *title = [self.barrages firstObject];
        
        [self.barrages removeObjectAtIndex:0];
        
        // 创建弹幕view
        [self creatBarrageView:title trajectory:trajectory];
        
    }
}

- (void)creatBarrageView:(NSString *)title trajectory:(NSInteger)trajectory
{
    if (self.stop_Animate) {
        return;
    }
    BBEBarrageView *barrageView = [[BBEBarrageView alloc] initWithComment:title];
    barrageView.trajectory = trajectory;
    
    
    __weak typeof(barrageView) wBarrageView = barrageView;
    __weak typeof(self)        wSelf = self;
    
    barrageView.moveStatusBlock = ^(MoveStatus status){
        if (self.stop_Animate) {
            return;
        }
        switch (status) {
            case MoveStatusStart:
            {
                if (![wSelf.barrageViews containsObject:wBarrageView]) {
                    [wSelf.barrageViews addObject:wBarrageView];
                }
            }
                break;
                
            case MoveStatusMoving:
            {
                // 获取下一条的弹幕数据
                NSString *nextTitle = [wSelf getNextTitle];
                if (nextTitle) {
                    [wSelf creatBarrageView:nextTitle trajectory:trajectory];
                }
                
            }
                break;
                
            case MoveStatusEnd:
            {
                [wBarrageView stopAnimate];
                [wSelf.barrageViews removeObject:wBarrageView];
                
                if (wSelf.barrageViews.count == 0) {
                    
                    wSelf.stop_Animate = YES;
                    
                    // 屏幕上没有弹幕，表示弹幕播放完毕，开始循环
                    if (wSelf.loop) {
                        
                        [wSelf start];
                    }
                    
//                    // 检查数据源中是否还有数据
//                    if (wSelf.barrages.count != 0) {
//                        
//                        // 创建弹幕view
//                        [self initBarrageView];
//                        
//                    }else{
//                        wSelf.stop_Animate = YES;
//                        // 屏幕上没有弹幕，表示弹幕播放完毕，开始循环
//                        if (wSelf.loop) {
//                            
//                            [wSelf start];
//                        }
//                    }
                    
                }
            }
                break;
                
            default:
                break;
        }
        
    };
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat barrageViewW = CGRectGetWidth(barrageView.frame);
    CGFloat barrageViewH = CGRectGetHeight(barrageView.frame);
    [self.superV addSubview:barrageView];
    barrageView.frame = CGRectMake(width, self.firstLineY + barrageView.trajectory * (_lineMargin + barrageViewH), barrageViewW, barrageViewH);
    [barrageView startAnimate];
}

- (NSString *)getNextTitle
{
    if (self.barrages.count == 0) {
        return nil;
    }
    // 取出第一条弹幕
    NSString *title = [self.barrages firstObject];
    
    [self.barrages removeObjectAtIndex:0];
    
    return  title;
}

- (NSMutableArray *)barrageDataSource
{
    if (_barrageDataSource == nil) {
        _barrageDataSource = [NSMutableArray array];
    }
    
    return _barrageDataSource;
}

- (NSMutableArray *)barrageViews
{
    if (_barrageViews == nil) {
        _barrageViews = [NSMutableArray array];
    }
    
    return _barrageViews;
}

- (NSMutableArray *)barrages
{
    if (_barrages == nil) {
        _barrages = [NSMutableArray array];
    }
    
    return _barrages;
}

//- (void)setDataSource:(NSArray *)dataSource
//{
//    _dataSource = dataSource;
//    [self.barrages addObjectsFromArray:dataSource];
//}
@end
