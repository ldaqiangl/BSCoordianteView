//
//  BSChartBaseView.m
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/31.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import "BSChartBaseView.h"

@interface BSChartBaseView ()


@end

@implementation BSChartBaseView
- (NSMutableArray *)dataPointSource {
    if (!_dataPointSource) {
        _dataPointSource = [NSMutableArray array];
    }
    return _dataPointSource;
}

- (void)prepareDrawChartBaseWithXAxisInfo:(NSArray *)xValueArr andXPoints:(NSArray *)xPoints andYAxisInfo:(NSArray *)yValueArr andYPoints:(NSArray *)yPoints andXUnitSpace:(CGFloat)xUnitSpace andYUnitSpace:(CGFloat)yUnitSpace andXScale:(CGFloat)xScale andYScale:(CGFloat)yScale andEdgeInsets:(UIEdgeInsets)edgeInsets {
    
    _xAxisPoints = xPoints;_yAxisPoints = yPoints;
    _xAxisDataSource = xValueArr;_yAxisDataSource = yValueArr;
    
    _xScale = xScale;_yScale = yScale;
    
    _maxY = [[_yAxisPoints lastObject] floatValue];
    _maxX = [[_xAxisPoints lastObject] floatValue];
    _xUnitSpace = xUnitSpace;_yUnitSpace = yUnitSpace;
    
    self.edgeInsets = edgeInsets;
    
    if (!self.handleChart) {
        self.handleChart = [[BSChartHandle alloc] initWithChartCoordinateOrigin:CGPointMake(0, self.bounds.size.height - self.edgeInsets.bottom)];
    }
    self.handleChart.chartOriginPoint = CGPointMake(0, self.bounds.size.height - self.edgeInsets.bottom);
    
}



- (void)updateChartDataWithDataSource:(NSArray *)dataSource andDataType:(BSChartType)dataType {
    
    self.dataPointSource = [NSMutableArray arrayWithArray:dataSource];
    
    [self setNeedsDisplay];
}



- (void)drawRect:(CGRect)rect {
    
    CGContextRef drawCtx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(drawCtx, 1.0);
    CGContextSetStrokeColorWithColor(drawCtx, [UIColor colorWithHexString_Ext:@"#959595"].CGColor);
    CGContextSetFillColorWithColor(drawCtx, [UIColor colorWithHexString_Ext:@"#EEEEEE"].CGColor);
    
//#1.y轴显示的网格坐标线
    for (int i = 0; i < _yAxisPoints.count - 1; i++) {
        NSNumber *number = _yAxisPoints[i];
        CGPoint drawPoint = CGPointMake(0, number.floatValue);
        if (i < _yAxisPoints.count - 1 && i > 0) {
            [self.handleChart drawALineWith:CGPointMake(0, drawPoint.y) andEndPoint:CGPointMake(_maxX, drawPoint.y) andCtx:drawCtx andIsDash:NO andLineColor:[UIColor colorWithHexString_Ext:@"#EEEEEE"]];
        }
    }
    
//#2.绘图x轴显示坐标点和网格坐标线
    for (int i = 0; i < _xAxisPoints.count; i++) {
        NSNumber *number = _xAxisPoints[i];
        CGPoint drawPoint = CGPointMake(number.floatValue,0);
        if (_xAxisDataSource.count>i) {
            [self.handleChart drawTextStringWith:drawPoint andText:[NSString stringWithFormat:@"%@",_xAxisDataSource[i]] andDirection:BSChartValuePositionDown andContext:drawCtx andTextColor:[UIColor colorWithHexString_Ext:@"959595"] andTextFont:[UIFont systemFontOfSize:14.0]];
        }
        
        [self.handleChart drawALineWith:CGPointMake(drawPoint.x, 0) andEndPoint:CGPointMake(drawPoint.x, _maxY - _yUnitSpace) andCtx:drawCtx andIsDash:YES andLineColor:[UIColor colorWithHexString_Ext:@"#EEEEEE"]];
        
    }
    
}
@end
