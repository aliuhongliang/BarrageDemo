//
//  ViewController.m
//  barrageDemo
//
//  Created by lihongwen-pc on 2017/1/13.
//  Copyright © 2017年 Univalsoft. All rights reserved.
//

#import "ViewController.h"
#import "BBEBarrageManager.h"
#import "BBEBarrageView.h"

@interface ViewController ()
@property (nonatomic, strong) BBEBarrageManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = @[
                     @"弹幕1~~~~~~~~~~",
                     @"弹幕2~~~~~",
                     @"弹幕3~~~~~~~~~~~~~~~~",
                     @"弹幕4~~~~~~~~~~",
                     @"弹幕5~~~~~",
                     @"弹幕6~~~~~~~~~~~~~~~~",
                     @"弹幕7~~~~~~~~~~~~~~~~",
                     @"弹幕8~~~~~~~~~~",
                     @"弹幕9~~~~~",
                     @"弹幕0~~~~~~~~~~~~~~~~"
                     ];
//    NSMutableArray *arrM = [NSMutableArray array];
//    for (NSInteger i = 0; i < 10000; i++) {
//        NSString *string = [NSString stringWithFormat:@"弹幕1~~~~~~~~%ld",i];
//        [arrM addObject:string];
//    }
    
    _manager = [[BBEBarrageManager alloc] initWithSuperView:self.view andFirstLineY:200];
    [_manager.barrageDataSource addObjectsFromArray:arr];
//    _manager.dataSource = arr;
   
    
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeSystem];
    [start setTitle:@"开始" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(clickStart) forControlEvents:UIControlEventTouchUpInside];
    start.frame = CGRectMake(0, 500, 100, 40);
    [self.view addSubview:start];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeSystem];
    [stop setTitle:@"停止" forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(clickStop) forControlEvents:UIControlEventTouchUpInside];
    stop.frame = CGRectMake(80, 500, 100, 40);
    [self.view addSubview:stop];
    
    UIButton *pause = [UIButton buttonWithType:UIButtonTypeSystem];
    [pause setTitle:@"暂停" forState:UIControlStateNormal];
    [pause addTarget:self action:@selector(clickPause) forControlEvents:UIControlEventTouchUpInside];
    pause.frame = CGRectMake(160, 500, 100, 40);
    [self.view addSubview:pause];
    
    UIButton *resume = [UIButton buttonWithType:UIButtonTypeSystem];
    [resume setTitle:@"恢复" forState:UIControlStateNormal];
    [resume addTarget:self action:@selector(clickResume) forControlEvents:UIControlEventTouchUpInside];
    resume.frame = CGRectMake(240, 500, 100, 40);
    [self.view addSubview:resume];
    
    UIButton *dataButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [dataButton setTitle:@"新数据" forState:UIControlStateNormal];
    [dataButton addTarget:self action:@selector(clickDataButton) forControlEvents:UIControlEventTouchUpInside];
    dataButton.frame = CGRectMake(100, 600, 100, 40);
    [self.view addSubview:dataButton];
}

- (void)clickStart
{
    [_manager start];
}

- (void)clickStop
{
    [_manager stop];
}

- (void)clickPause
{
    [_manager pause];
}

- (void)clickResume
{
    [_manager resume];
}

- (void)clickDataButton
{
    NSArray *arr = @[
                     @"彩蛋--------",
                     @"蛋2——————++++++————————————+++++++",
                     @"彩蛋3++++++",
                     @"彩蛋4&&&&&888888",
                     @"彩蛋5000000",
                     @"彩蛋6=======&&&&&&&&&&&&&&&&&&",
                     @"彩蛋7---------------",
                     @"彩蛋8-----",
                     @"彩蛋9-----------",
                     @"彩蛋0====================="
                     ];
    [_manager.barrageDataSource addObjectsFromArray:arr];
//    _manager.dataSource = arr;
}


@end
