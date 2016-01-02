//
//  ViewController.m
//  BSCoordinateView
//
//  Created by 董富强 on 16/1/2.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "ViewController.h"

#import "BSChartCoordinateView.h"
#import "UIColor+BSExt.h"

@interface ViewController ()

@property (nonatomic, weak) BSChartCoordinateView *baseView;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation ViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (NSDateFormatter *)dateFormatter {
    
    if (_dateFormatter == nil) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"MM-dd HH:mm";
    }
    return _dateFormatter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    // Dispose of any resources that can be recreated.
    CGFloat sW = self.view.bounds.size.width;
    CGFloat sH = self.view.bounds.size.height;
    
    //1.根据要创建的视图类型创建表视图
    BSChartCoordinateView *bschartBase = [[BSChartCoordinateView alloc] initWithFrame:CGRectMake(0, 100, sW, sH-200)];
    self.baseView = bschartBase;
    [self.view addSubview:bschartBase];
    
    //2.配置表视图显示的坐标和比例尺以及基础视图
    [bschartBase configChartCoordinateXAxisWith:[NSMutableArray arrayWithArray:@[@"1:30",@"2:30",@"3:30",@"4:34",@"2:30",@"2:30",@"2:30",@"2:30",@"2:30",@"2:30",@"2:30",@"2:30"]] andYAxisWith:[NSMutableArray arrayWithArray:@[@0,@20,@40,@60,@80,@100,@120,@140,@160,@180,@200,@220,@240]] andXScale:0.4 andYScale:BSPxToPt(3.0) andDataType:BSChartBMPType andXAxisColor:[UIColor colorWithHexString_Ext:@"#959595"] andYAxisColor:[UIColor colorWithHexString_Ext:@"#959595"]];
    
    //3.更新视图显示的折线图
    NSArray *arr = @[KSStringFromBMPResult(KSChartBMPResultMake(134, 80, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(147, 56, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(135, 50, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(134, 88, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(145, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(123, 56, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     KSStringFromBMPResult(KSChartBMPResultMake(143, 45, 60)),
                     ];
    NSMutableArray *itemsArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        BSChartPointItem *pointItem = [[BSChartPointItem alloc] initBMPPointWithXValue:[NSString stringWithFormat:@"%@",[self.dateFormatter stringFromDate:[NSDate date]]] andYValue:KSChartBMPFromString(arr[i]) andItemColor:nil];
        [itemsArr addObject:pointItem];
    }
    
    [self.baseView updateChartDataWithDataSource:itemsArr andDataType:BSChartBMPType];
    
}


@end
