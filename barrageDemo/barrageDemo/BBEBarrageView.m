//
//  BBEBarrageView.m
//  barrageDemo
//
//  Created by lihongwen-pc on 2017/1/13.
//  Copyright © 2017年 Univalsoft. All rights reserved.
//

#import "BBEBarrageView.h"

#define padding 10
#define Duration 3.0f  // 动画持续时间

@interface BBEBarrageView ()

@property (nonatomic, strong) UILabel *titleLabel; // 展示文字的label

@end

@implementation BBEBarrageView

- (instancetype) initWithComment:(NSString *)comment  // 初始化弹幕的方法 （临时以一端文字来初始化）
{
    if (self = [super init]) {
        
        // 计算文字的宽度
        NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
        CGFloat titleWidth = [comment sizeWithAttributes:dic].width;
        
        self.bounds = CGRectMake(0, 0, titleWidth + 2 * padding, 30);
        
        self.titleLabel.text = comment;
        self.titleLabel.frame = CGRectMake(padding, 0, titleWidth, 30);
        
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}


- (void)startAnimate
{
    // 计算运动的距离
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat selfWidth = CGRectGetWidth(self.frame);
    CGFloat wholeWidth = screen_width + selfWidth;
    CGFloat duration = Duration;
    
    // 弹幕开始运动
    if (_moveStatusBlock) {
        _moveStatusBlock(MoveStatusStart);
    }
    
    // 弹幕完全进入屏幕...
    CGFloat speed = wholeWidth / duration;
    CGFloat enterTime = selfWidth / speed;
    
    // 延时多少时间执行什么事
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterTime];
    
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
       
        frame.origin.x -= wholeWidth;
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
        
        if (_moveStatusBlock) {
            _moveStatusBlock(MoveStatusEnd);
        }
        
    }];
}


// 完全进入屏幕后，获取下一条的字母数据
- (void)enterScreen
{
    if (_moveStatusBlock) {
        _moveStatusBlock(MoveStatusMoving);
    }
}

- (void)stopAnimate
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

// 暂停动画
- (void)pauseAnimate
{
    
    CGRect rect = self.frame;
    rect = self.layer.presentationLayer.frame;
    rect.origin.x -= 1;
    self.frame = rect;
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];

}

// 恢复动画
- (void)resumeAnimate
{
    [self startAnimate];
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
    }
    
    return _titleLabel;
}
@end
