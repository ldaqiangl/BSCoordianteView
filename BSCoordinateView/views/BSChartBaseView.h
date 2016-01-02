//
//  BSChartBaseView.h
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/31.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSChartHandle.h"

@interface BSChartBaseView : UIView
{
    CGFloat _xScale;//坐标实际值/显示值
    CGFloat _yScale;//坐标实际值/显示值
    
    NSArray *_xAxisPoints;
    NSArray *_yAxisPoints;
    NSArray *_xAxisDataSource;
    NSArray *_yAxisDataSource;
    
    CGFloat _maxY;
    CGFloat _maxX;
    CGFloat _xUnitSpace;
    CGFloat _yUnitSpace;
}

@property (nonatomic, strong) BSChartHandle *handleChart;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, strong) NSMutableArray *dataPointSource;

- (void)prepareDrawChartBaseWithXAxisInfo:(NSArray *)xValueArr andXPoints:(NSArray *)xPoints andYAxisInfo:(NSArray *)yValueArr andYPoints:(NSArray *)yPoints andXUnitSpace:(CGFloat)xUnitSpace andYUnitSpace:(CGFloat)yUnitSpace andXScale:(CGFloat)xScale andYScale:(CGFloat)yScale andEdgeInsets:(UIEdgeInsets)edgeInsets;

- (void)updateChartDataWithDataSource:(NSArray *)dataSource andDataType:(BSChartType)dataType;

@end
