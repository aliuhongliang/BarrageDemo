//
//  BBEBarrageView.h
//  barrageDemo
//
//  Created by lihongwen-pc on 2017/1/13.
//  Copyright © 2017年 Univalsoft. All rights reserved.
/**
 
    该view表示： 一条弹幕
 
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MoveStatus) {
    MoveStatusStart,
    MoveStatusMoving,
    MoveStatusEnd,
};

@interface BBEBarrageView : UIView

@property (nonatomic, assign) NSInteger trajectory;  // 弹幕的轨道

@property (nonatomic, strong) void(^moveStatusBlock)(MoveStatus status); // 弹幕移动的状态

- (instancetype) initWithComment:(NSString *)comment;  // 初始化弹幕的方法 （临时以一端文字来初始化）

- (void)startAnimate;

- (void)stopAnimate;

- (void)pauseAnimate;

- (void)resumeAnimate;
@end
