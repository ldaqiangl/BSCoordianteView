//
//  BSChartBMPView.m
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/31.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import "BSChartBMPView.h"

#define BMPSYSChartColor KSChartColorMake(0.0, 163/255.0, 1.0)
#define BMPDIAChartColor KSChartColorMake(0.0, 1.0, 0.0)

@implementation BSChartBMPView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)updateChartDataWithDataSource:(NSArray *)dataSource andDataType:(BSChartType)dataType {
    
    [super updateChartDataWithDataSource:dataSource andDataType:dataType];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    CGContextRef currentCtx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(currentCtx, 1.0);
    
//#1.绘出特殊颜色区域
    [self.handleChart drawColorRectWithStartP:CGPointMake(0, 90*_yScale) andEndP:CGPointMake(_maxX+_xUnitSpace, 140*_yScale) andContext:currentCtx andFillColor:[UIColor colorWithRed:BMPSYSChartColor.ksR green:BMPSYSChartColor.ksG blue:BMPSYSChartColor.ksB alpha:0.3] andAlpha:0.3];
    [self.handleChart drawColorRectWithStartP:CGPointMake(0, 60*_yScale) andEndP:CGPointMake(_maxX+_xUnitSpace, 89.9*_yScale) andContext:currentCtx andFillColor:[UIColor colorWithRed:BMPDIAChartColor.ksR green:BMPDIAChartColor.ksG blue:BMPDIAChartColor.ksB alpha:0.3] andAlpha:0.3];
    
//#2.根据数据源的模型描绘出要显示的坐标点
    if (self.dataPointSource.count > 0) {
        
        for (int i = 0; i < self.dataPointSource.count; i++) {
            
            BSChartPointItem *pointItem = self.dataPointSource[i];
            if (pointItem.coordinateYValue.sys>0||pointItem.coordinateYValue.dia>0) {
                
                CGFloat sysY = pointItem.coordinateYValue.sys;
                CGFloat diaY = pointItem.coordinateYValue.dia;
                
                KSChartColor sysColor = pointItem.pointColor.sys;
                UIColor *sysPColor = [UIColor colorWithRed:sysColor.ksR green:sysColor.ksG blue:sysColor.ksB alpha:1.0];
                KSChartColor diaColor = pointItem.pointColor.dia;
                UIColor *diaPColor = [UIColor colorWithRed:diaColor.ksR green:diaColor.ksG blue:diaColor.ksB alpha:1.0];
                
                CGPoint sysPoint = CGPointMake([_xAxisPoints[i] floatValue], sysY*_yScale);
                CGPoint diaPoint = CGPointMake([_xAxisPoints[i] floatValue], diaY*_yScale);
                
                [self.handleChart drawAPointWith:sysPoint andCtx:currentCtx andPointColor:sysPColor];
                [self.handleChart drawAPointWith:diaPoint andCtx:currentCtx andPointColor:diaPColor];
                
                [self.handleChart drawTextStringWith:sysPoint andText:[NSString stringWithFormat:@"%.0f",pointItem.coordinateYValue.sys] andDirection:BSChartValuePositionUp andContext:currentCtx andTextColor:sysPColor andTextFont:[UIFont systemFontOfSize:12.0]];
                [self.handleChart drawTextStringWith:diaPoint andText:[NSString stringWithFormat:@"%.0f",pointItem.coordinateYValue.dia] andDirection:BSChartValuePositionUp andContext:currentCtx andTextColor:diaPColor andTextFont:[UIFont systemFontOfSize:12.0]];

            }
            
        }
        
//3.画线  动画效果
        UIColor *startPColor;
        UIColor *endPColor;
        for (int i = 0; i < self.dataPointSource.count - 1; i++) {
            
            BSChartPointItem *pointItemStart = self.dataPointSource[i];
            BSChartPointItem *pointItemEnd = self.dataPointSource[i+1];
            
            
            
            CGPoint sysStartP = CGPointMake([_xAxisPoints[i] floatValue], pointItemStart.coordinateYValue.sys*_yScale);
            CGPoint sysEndP = CGPointMake([_xAxisPoints[i+1] floatValue], pointItemEnd.coordinateYValue.sys*_yScale);
            
            startPColor = [UIColor colorWithRed:pointItemStart.pointColor.sys.ksR green:pointItemStart.pointColor.sys.ksG blue:pointItemStart.pointColor.sys.ksB alpha:1.0];
            endPColor = [UIColor colorWithRed:pointItemEnd.pointColor.sys.ksR green:pointItemEnd.pointColor.sys.ksG blue:pointItemEnd.pointColor.sys.ksB alpha:1.0];
            
            if (![self.handleChart isCrossValue:140*_yScale andStartPoint:sysStartP andEndPoint:sysEndP andStartPColor:startPColor andEndPColor:endPColor andLayer:self.layer]) {
                [self.handleChart drawALineWithAnimationFrom:sysStartP andEndPoint:sysEndP andLineColor:startPColor lineSuperLayer:self.layer andPath:nil];
            }
            
            
            
            CGPoint diaStartP = CGPointMake([_xAxisPoints[i] floatValue], pointItemStart.coordinateYValue.dia*_yScale);
            CGPoint diaEndP = CGPointMake([_xAxisPoints[i+1] floatValue], pointItemEnd.coordinateYValue.dia*_yScale);
            startPColor = [UIColor colorWithRed:pointItemStart.pointColor.dia.ksR green:pointItemStart.pointColor.dia.ksG blue:pointItemStart.pointColor.dia.ksB alpha:1.0];
            endPColor = [UIColor colorWithRed:pointItemEnd.pointColor.dia.ksR green:pointItemEnd.pointColor.dia.ksG blue:pointItemEnd.pointColor.dia.ksB alpha:1.0];
            
            if (![self.handleChart isCrossValue:60*_yScale andStartPoint:diaStartP andEndPoint:diaEndP andStartPColor:startPColor andEndPColor:endPColor andLayer:self.layer]) {
                [self.handleChart drawALineWithAnimationFrom:diaStartP andEndPoint:diaEndP andLineColor:startPColor lineSuperLayer:self.layer andPath:nil];
            }
            
        }
    }
    
}



@end
