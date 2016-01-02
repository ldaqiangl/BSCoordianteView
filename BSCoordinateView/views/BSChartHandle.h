//
//  BSChartHandle.h
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/30.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BSChartPointItem.h"
#import "UIColor+BSExt.h"

#define BSPxToPt(px) px*[UIScreen mainScreen].bounds.size.width/750.0

@interface BSChartHandle : NSObject
@property (nonatomic, assign) CGPoint chartOriginPoint;

- (instancetype)initWithChartCoordinateOrigin:(CGPoint)origin;


/**
 *  将展示坐标转化为UIKit坐标
 *
 *  @param currentPoint 现在的展示坐标
 *
 *  @return UIKit坐标
 */
CGPoint bs_convertBSChartCoordinateToUIKitWith(CGPoint chartPoint,CGPoint chartOriginUIKitPoint);

/**
 *  将UIKit上的坐标转化为要展示的坐标
 *
 *  @param uiPoint UIKit上的坐标点
 *
 *  @return 要展示的坐标
 */
CGPoint bs_convertUIKitCoordinateToBSChartWith(CGPoint uiPoint,CGPoint chartOriginUIKitPoint);

/**
 *  画直线（实线或者虚线）
 *
 *  @param startPoint 图表坐标系中的起始点
 *  @param endPoint   图表坐标点的终止点
 *  @param ctx        上下文
 *  @param isDash     是否是虚线
 */
- (void)drawALineWith:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andCtx:(CGContextRef)ctx andIsDash:(BOOL)isDash andLineColor:(UIColor *)lineColor;

/**
 *  画点
 *
 *  @param centerP 点的位置
 *  @param ctx     上下文
 */
- (void)drawAPointWith:(CGPoint)centerP andCtx:(CGContextRef)ctx andPointColor:(UIColor *)pointColor;

/**
 *  画三角形
 *
 *  @param startP    箭头位置
 *  @param direction 箭头方向
 *  @param ctx       上下文
 */
- (void)drawTriangleWith:(CGPoint)startP andTextDirection:(BSChartDirectionType)direction andContext:(CGContextRef)ctx andArrowColor:(UIColor *)arrowColor;

/**
 *  画文字（值）
 *
 *  @param startP    显示位置
 *  @param value     显示值
 *  @param direction 方向
 *  @param ctx       上下文
 */
- (void)drawTextStringWith:(CGPoint)startP andText:(NSString *)value andDirection:(BSChartValuePositionType)direction andContext:(CGContextRef)ctx andTextColor:(UIColor *)textColor andTextFont:(UIFont *)font;

/**
 *  染区块颜色
 *
 *  @param startP    起始点
 *  @param endPoint  对角线终止点
 *  @param ctx       上下文
 *  @param fillColor 填充颜色
 */
- (void)drawColorRectWithStartP:(CGPoint)startP andEndP:(CGPoint)endPoint andContext:(CGContextRef)ctx andFillColor:(UIColor *)fillColor andAlpha:(CGFloat)alpha;

/**
 *  绘出动画效果的直线 （从头到尾，一气呵成）
 *
 *  @param startPoint 起始位置
 *  @param endPoint   终止位置
 *  @param lineColor  线条的颜色
 *  @param superLayer 绘出的线条所在的父layer
 */
- (void)drawALineWithAnimationFrom:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andLineColor:(UIColor *)lineColor lineSuperLayer:(CALayer *)superLayer andPath:(CGMutablePathRef)lineMutablePath;

/**
 *  交叉画线
 *
 *  @param crossValue <#crossValue description#>
 *  @param startP     <#startP description#>
 *  @param endP       <#endP description#>
 *  @param startColor <#startColor description#>
 *  @param endColor   <#endColor description#>
 *  @param layer      <#layer description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)isCrossValue:(CGFloat)crossValue andStartPoint:(CGPoint)startP andEndPoint:(CGPoint)endP andStartPColor:(UIColor *)startColor andEndPColor:(UIColor *)endColor andLayer:(CALayer *)layer;
@end




