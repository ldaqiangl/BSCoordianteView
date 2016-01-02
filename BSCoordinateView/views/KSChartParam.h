//
//  KSChartParam.h
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/19.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//
#ifndef KSChartParam_h
#define KSChartParam_h

#import <UIKit/UIKit.h>

/**
 *  自定义图表R、G、B颜色
 */
struct KSChartColor {
    CGFloat ksR;
    CGFloat ksG;
    CGFloat ksB;
};
typedef struct KSChartColor KSChartColor;


/**
 *  血压测量结果
 */
struct KSChartBMPResult {
    CGFloat sys;
    CGFloat dia;
    CGFloat pul;
};
typedef struct KSChartBMPResult KSChartBMPResult;

/**
 *  颜色组
 */
struct KSChartGroupColor {
    KSChartColor sys;
    KSChartColor dia;
};
typedef struct KSChartGroupColor KSChartGroupColor;



#endif /* KSChartParam_h */
