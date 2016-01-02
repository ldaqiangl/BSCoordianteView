//
//  BSChartCoordinateView.m
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/30.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import "BSChartCoordinateView.h"

#import "BSChartHandle.h"
#import "BSChartBMPView.h"

@interface BSChartCoordinateView ()
{
    CGFloat _xScale;//坐标实际值/显示值
    CGFloat _yScale;//坐标实际值/显示值
    
    NSArray *_xAxisPoints;//存放坐标实际值（像素或点）
    NSArray *_yAxisPoints;
    NSArray *_xAxisDataSource;//存放x、y轴上显示的数据
    NSArray *_yAxisDataSource;
    
    CGFloat _maxY;
    CGFloat _maxX;
    CGFloat _xUnitSpace;
    CGFloat _yUnitSpace;
    
    NSString *_yCompany;
    NSString *_xCompany;
    
    UIColor *_xAxisColor;
    UIColor *_yAxisColor;
    
}


@property (nonatomic, strong) BSChartHandle *handleChart;
@property (nonatomic, assign) UIEdgeInsets edgeMarginInset;

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) BSChartBaseView *chartBaseView;

@end
@implementation BSChartCoordinateView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView = scrollView;
        [self addSubview:scrollView];
    }
    return _scrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //初始化 表视图与父视图 的外围间距 上、左、下、右
        self.edgeMarginInset = UIEdgeInsetsMake(BSPxToPt(70), BSPxToPt(70), BSPxToPt(70), BSPxToPt(70));
    }
    return self;
}

- (void)configChartCoordinateXAxisWith:(NSArray *)xAxisPoints andYAxisWith:(NSArray *)yAxisPoints andXScale:(CGFloat)xS andYScale:(CGFloat)yS andDataType:(BSChartType)dataType andXAxisColor:(UIColor *)xColor andYAxisColor:(UIColor *)yColor {
    
//#1.配置表视图横轴和纵轴上显示的坐标值
    _xAxisColor = xColor;_yAxisColor = yColor;
    _xScale = xS<1?BSPxToPt(200):xS;_yScale = yS<1?BSPxToPt(3.0):yS;
    //X
    NSMutableArray *xPoints = [NSMutableArray array];
    for (int i = 0; i < xAxisPoints.count; i++) {
        NSNumber *number = [NSNumber numberWithFloat:(i+1)*_xScale];
        [xPoints addObject:number];
    }
    if (xPoints.count < 7) {
        
        int currentDataCount = (int)xPoints.count;
        for (int i = currentDataCount; i < 7; i++) {
            NSNumber *numberObj = [NSNumber numberWithFloat:(i+1)*_xScale];
            [xPoints addObject:numberObj];
        }
    }
    _xAxisPoints = xPoints;
    _xAxisDataSource = xAxisPoints;
    
    if (_xAxisPoints.count > 2) {
        _xUnitSpace = ([[_xAxisPoints lastObject] floatValue] - [_xAxisPoints[_xAxisPoints.count-2] floatValue]);
    } else {
        _xUnitSpace = 0;
    }
    
    //Y
    NSMutableArray *yPoints = [NSMutableArray array];
    for (int i = 0; i < yAxisPoints.count; i++) {
        NSNumber *number = [NSNumber numberWithFloat:[yAxisPoints[i] floatValue]*_yScale];
        [yPoints addObject:number];
    }
    _yAxisPoints = yPoints;
    _yAxisDataSource = yAxisPoints;
    
    if (_yAxisPoints.count > 2) {
        _yUnitSpace = ([[_yAxisPoints lastObject] floatValue] - [_yAxisPoints[_yAxisPoints.count-2] floatValue]);
    } else {
        _yUnitSpace = 0;
    }
    
//#2.计算x、y坐标最大范围（由比例尺和输入值共同决定）
    _maxY = [[_yAxisPoints lastObject] floatValue];
    _maxX = [[_xAxisPoints lastObject] floatValue]+_xUnitSpace;
    
//#3.重新计算坐标视图的frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _maxY+self.edgeMarginInset.top+self.edgeMarginInset.bottom);
    
//#4.用表视图坐标系 初始化操作工具类
    if (!self.handleChart) {
        self.handleChart = [[BSChartHandle alloc] initWithChartCoordinateOrigin:CGPointMake(self.edgeMarginInset.left, self.frame.size.height-self.edgeMarginInset.bottom)];
    }
    self.handleChart.chartOriginPoint = CGPointMake(self.edgeMarginInset.left, self.frame.size.height-self.edgeMarginInset.bottom);
    
//#5.加载容器scrollView
    self.scrollView.frame = (CGRect){bs_convertBSChartCoordinateToUIKitWith(CGPointMake(0, _maxY), self.handleChart.chartOriginPoint),self.frame.size.width-self.edgeMarginInset.left,_maxY+self.edgeMarginInset.bottom};
    
//#6.装载基础视图
    if (!self.chartBaseView) {
        if (dataType == BSChartBMPType) {
            
            BSChartBMPView *bmpView = [[BSChartBMPView alloc] init];
            self.chartBaseView = bmpView;
            [self.scrollView addSubview:self.chartBaseView];
            _yCompany = @"mmHg";
        }
    }
    
    self.chartBaseView.frame = CGRectMake(0, 0, _maxX, self.scrollView.frame.size.height);
    self.scrollView.contentSize = self.chartBaseView.bounds.size;
    [self.chartBaseView prepareDrawChartBaseWithXAxisInfo:_xAxisDataSource andXPoints:_xAxisPoints andYAxisInfo:_yAxisDataSource andYPoints:_yAxisPoints andXUnitSpace:_xUnitSpace andYUnitSpace:_yUnitSpace andXScale:_xScale andYScale:_yScale andEdgeInsets:self.edgeMarginInset];
    
    [self setNeedsDisplay];
}



- (void)updateChartDataWithDataSource:(NSArray *)dataSource andDataType:(BSChartType)dataType {
    
    NSMutableArray *xDataSource = [NSMutableArray array];
    for (int i = 0;i < dataSource.count;i++) {
        
        if ([dataSource[i] isKindOfClass:[BSChartPointItem class]]) {
            BSChartPointItem *pointItem = dataSource[i];
            [xDataSource addObject:pointItem.coordinateXValue];
        }
    }
    
    [self configChartCoordinateXAxisWith:xDataSource andYAxisWith:_yAxisDataSource andXScale:_xScale andYScale:_yScale andDataType:dataType andXAxisColor:_xAxisColor andYAxisColor:_yAxisColor];
    
    [self.chartBaseView updateChartDataWithDataSource:dataSource andDataType:dataType];
}



- (void)drawRect:(CGRect)rect {
    
    CGContextRef drawCtx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(drawCtx, 1.0);
    CGContextSetStrokeColorWithColor(drawCtx, _yAxisColor.CGColor);
    
    CGContextSaveGState(drawCtx);
    
//#1.绘出y轴
    CGPoint chartYEndPoint = CGPointMake(0, _maxY);
    [self.handleChart drawALineWith:CGPointMake(0, 0) andEndPoint:chartYEndPoint andCtx:drawCtx andIsDash:NO andLineColor:_yAxisColor];
    [self.handleChart drawTriangleWith:chartYEndPoint andTextDirection:BSChartVerticalDirectionType andContext:drawCtx andArrowColor:_yAxisColor];
    if (_yCompany) {
        [self.handleChart drawTextStringWith:chartYEndPoint andText:_yCompany andDirection:BSChartValuePositionLeft andContext:drawCtx andTextColor:[UIColor redColor] andTextFont:[UIFont systemFontOfSize:10.0]];
    }
    
//#2.绘出x轴
    CGPoint chartXEndPoint = CGPointMake((self.bounds.size.width-self.edgeMarginInset.left), 0);
    [self.handleChart drawALineWith:CGPointMake(0, 0) andEndPoint:chartXEndPoint andCtx:drawCtx andIsDash:NO andLineColor:_xAxisColor];
//    [self.handleChart drawTriangleWith:chartXEndPoint and:BSChartHorizonDirectionType and:drawCtx andArrowColor:_xAxisColor];
    
//#3.配置y轴显示的坐标点
    for (int i = 0; i < _yAxisPoints.count - 1; i++) {
        NSNumber *number = _yAxisPoints[i];
        CGPoint drawPoint = CGPointMake(0, number.floatValue);
        [self.handleChart drawTextStringWith:drawPoint andText:[NSString stringWithFormat:@"%@",_yAxisDataSource[i]] andDirection:BSChartValuePositionLeft andContext:drawCtx andTextColor:_yAxisColor andTextFont:[UIFont systemFontOfSize:12.0]];
    }
    
//#4.配置x轴坐标点
/*
    for (int i = 1; i < _xAxisPoints.count - 1; i++) {
        NSNumber *number = _xAxisPoints[i];
        CGPoint drawPoint = CGPointMake(number.floatValue,0);
        if (i < _xAxisPoints.count - 1 && i > 0 && _xAxisDataSource.count < 1) {
            [self.handleChart drawALineWith:CGPointMake(drawPoint.x, 0) andEndPoint:CGPointMake(drawPoint.x, _maxY-_yUnitSpace) andCtx:drawCtx andIsDash:YES andLineColor:[UIColor colorWithHexString_Ext:@"#EEEEEE"]];
        }
    }
*/
    
    CGContextRestoreGState(drawCtx);

    
}


@end
