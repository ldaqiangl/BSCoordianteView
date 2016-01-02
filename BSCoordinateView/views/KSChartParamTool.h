//
//  KSChartParamTool.h
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/19.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KSChartParam.h"

@interface KSChartParamTool : NSObject


/**
 *  将字符串转化为KSChartBMPResult
 */
KSChartBMPResult KSChartBMPFromString(NSString *bmpStr);


/**
 *  KSChartBMPResult转化为字符串
 */
NSString* KSStringFromBMPResult(KSChartBMPResult bmp);


/**
 *  血压测量结果
 *
 *  @param sys 收缩压
 *  @param dia 舒张压
 *  @param pul 脉搏
 *
 *  @return 收缩压，舒张压，脉搏
 */
KSChartBMPResult KSChartBMPResultMake(CGFloat sys,CGFloat dia,CGFloat pul);


/**
 *  图表颜色生成器
 *
 *  @param ksr R
 *  @param ksg G
 *  @param ksb B
 *
 *  @return 颜色[0，1]
 */
KSChartColor KSChartColorMake(CGFloat ksr, CGFloat ksg,CGFloat ksb);


/**
 *  颜色组生成器
 */
KSChartGroupColor KSChartGroupColorMake(KSChartColor c1,KSChartColor c2);


@end
