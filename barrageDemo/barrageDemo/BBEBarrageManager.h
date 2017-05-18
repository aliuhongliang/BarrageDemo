//
//  BBEBarrageManager.h
//  barrageDemo
//
//  Created by lihongwen-pc on 2017/1/13.
//  Copyright © 2017年 Univalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBEBarrageView;

@interface BBEBarrageManager : NSObject
// 数据源
@property (nonatomic, strong) NSMutableArray *barrageDataSource;
//// new数据源
//@property (nonatomic, strong) NSArray *dataSource;

// 位置
@property (nonatomic, assign) CGFloat lineMargin;

/// 基本设置
// 是否开启循环
@property (nonatomic, assign) BOOL loop;  // 默认为no
// 弹幕的行数
@property (nonatomic, assign) NSInteger count; // 默认为3个

- (instancetype) initWithSuperView:(UIView *)view andFirstLineY:(CGFloat)Y;

- (void)start;

- (void)stop;

- (void)pause;

- (void)resume;
@end
