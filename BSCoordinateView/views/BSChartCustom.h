//
//  BSChartCustom.h
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/30.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#ifndef BSChartCustom_h
#define BSChartCustom_h

/**
 *  图表视图类型
 */
typedef NS_OPTIONS(NSInteger, BSChartType) {
    BSChartBMPType,//血压图表
    BSChartBSCType,//血糖图表
};

/**
 *  坐标轴/方向类型
 */
typedef NS_OPTIONS(NSInteger, BSChartDirectionType) {
    /**
     *  x 方向 水平轴
     */
    BSChartHorizonDirectionType = 0,
    /**
     *  y 方向 竖轴
     */
    BSChartVerticalDirectionType = 1,
};

/**
 *  显示值在坐标点的什么位置
 */
typedef NS_OPTIONS(NSInteger, BSChartValuePositionType) {
    /**
     *  左侧
     */
    BSChartValuePositionLeft = 1,
    /**
     *  下方
     */
    BSChartValuePositionDown = 2,
    /**
     *  右侧
     */
    BSChartValuePositionRight= 3,
    /**
     *  上方
     */
    BSChartValuePositionUp   = 4,
};




#endif /* BSChartCustom_h */
