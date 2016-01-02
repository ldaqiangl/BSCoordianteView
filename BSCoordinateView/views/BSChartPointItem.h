//
//  BSChartPointItem.h
//  Kangs100Vip
//
//  Created by 董富强 on 16/1/1.
//  Copyright © 2016年 06-kangs100. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KSChartParamTool.h"
#import "BSChartCustom.h"

@interface BSChartPointItem : NSObject

@property (nonatomic, copy) NSString *coordinateXValue;

//BMP 血压 y
@property (nonatomic, assign) KSChartBMPResult coordinateYValue;
@property (nonatomic, assign) KSChartGroupColor pointColor;

- (instancetype)initBMPPointWithXValue:(NSString *)xValue andYValue:(KSChartBMPResult)yValue andItemColor:(UIColor *)itemColor;

//BSM 血糖 y


@end
