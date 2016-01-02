//
//  BSChartCoordinateView.h
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/30.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BSChartBaseView.h"

@interface BSChartCoordinateView : UIView

- (void)configChartCoordinateXAxisWith:(NSArray *)xAxisPoints andYAxisWith:(NSArray *)yAxisInfo andXScale:(CGFloat)xS andYScale:(CGFloat)yS andDataType:(BSChartType)dataType andXAxisColor:(UIColor *)xColor andYAxisColor:(UIColor *)yColor;

- (void)updateChartDataWithDataSource:(NSArray *)dataSource andDataType:(BSChartType)dataType;

@end
