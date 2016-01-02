//
//  BSChartPointItem.m
//  Kangs100Vip
//
//  Created by 董富强 on 16/1/1.
//  Copyright © 2016年 06-kangs100. All rights reserved.
//

#import "BSChartPointItem.h"

#define SYSChartOverColor KSChartColorMake(255.0/255.0, 153.0/255.0, 18.0/255.0)
#define SYSChartColor KSChartColorMake(65/255, 105/255.0, 1.0)
#define DIAChartColor KSChartColorMake(124/255.0, 252.0/255.0, 0)
#define DIAChartDownColor KSChartColorMake(1.0, 0, 0)


@implementation BSChartPointItem

- (instancetype)initBMPPointWithXValue:(NSString *)xValue andYValue:(KSChartBMPResult)yValue andItemColor:(UIColor *)itemColor {
    
    if (self = [super init]) {
        _coordinateXValue = xValue;
        _coordinateYValue = yValue;
        
        _pointColor = [self getGroupColorWithJudgeWith:yValue];
    }
    return self;
}


- (KSChartGroupColor)getGroupColorWithJudgeWith:(KSChartBMPResult)bmp {
    
    KSChartColor sysColor;
    KSChartColor diaColor;
    
    if (bmp.sys>140.0) {
        
        sysColor = SYSChartOverColor;
        diaColor = [self getDiaChartColor:bmp.dia];
        
    } else if (bmp.sys<90) {
        
        sysColor = DIAChartColor;
        diaColor = [self getDiaChartColor:bmp.dia];
        
    } else {
        
        sysColor =  SYSChartColor;
        diaColor = [self getDiaChartColor:bmp.dia];
        
    }
    
    return KSChartGroupColorMake(sysColor, diaColor);
}

- (KSChartColor)getDiaChartColor:(CGFloat)bmpDia {
    KSChartColor diaColor;
    
    if (bmpDia>90) {
        
        diaColor = SYSChartColor;
    } else if(bmpDia<60) {
        
        diaColor = DIAChartDownColor;
    } else {
        
        diaColor = DIAChartColor;
    }
    return diaColor;
}



@end
