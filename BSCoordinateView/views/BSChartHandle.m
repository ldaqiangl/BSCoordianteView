//
//  BSChartHandle.m
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/30.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import "BSChartHandle.h"

@interface BSChartHandle ()

@end


@implementation BSChartHandle

- (instancetype)initWithChartCoordinateOrigin:(CGPoint)origin {
    if (self = [super init]) {
        self.chartOriginPoint = origin;
    }
    return self;
}


CGPoint bs_convertBSChartCoordinateToUIKitWith(CGPoint chartPoint,CGPoint chartOriginUIKitPoint) {
    
    return CGPointMake(chartOriginUIKitPoint.x+chartPoint.x, chartOriginUIKitPoint.y-chartPoint.y);
}

CGPoint bs_convertUIKitCoordinateToBSChartWith(CGPoint uiPoint,CGPoint chartOriginUIKitPoint) {
    
    return CGPointMake(chartOriginUIKitPoint.x-chartOriginUIKitPoint.x, chartOriginUIKitPoint.y-uiPoint.y);
    
}



//画线（虚线或者实线）
- (void)drawALineWith:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andCtx:(CGContextRef)ctx andIsDash:(BOOL)isDash andLineColor:(UIColor *)lineColor {
    CGContextSetLineDash(ctx, 0, 0, 0);
    if (isDash) {
        
        CGFloat lengths[2] = {5,5};
        CGContextSetLineDash(ctx, 0, lengths, 1);
        CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    } else {
        
        CGContextSetLineWidth(ctx, 1.0);
        CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    }
    
    CGPoint uiStartPoint = bs_convertBSChartCoordinateToUIKitWith(startPoint, self.chartOriginPoint);
    CGPoint uiEndPoint = bs_convertBSChartCoordinateToUIKitWith(endPoint, self.chartOriginPoint);
    
    CGPoint lines[2];
    lines[0] = uiStartPoint;
    lines[1] = uiEndPoint;
    CGContextAddLines(ctx, lines, 2);
    CGContextStrokePath(ctx);
}

//画点
- (void)drawAPointWith:(CGPoint)centerP andCtx:(CGContextRef)ctx andPointColor:(UIColor *)pointColor {
    
    CGPoint uiCenterPoint = bs_convertBSChartCoordinateToUIKitWith(centerP, self.chartOriginPoint);
    
    CGContextSetFillColorWithColor(ctx, pointColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, pointColor.CGColor);
    
    CGFloat r = 2.0;
    CGContextAddArc(ctx, uiCenterPoint.x, uiCenterPoint.y, r, 0, M_PI*2, 1);
    CGContextFillPath(ctx);
    
}

//画箭头
- (void)drawTriangleWith:(CGPoint)startP andTextDirection:(BSChartDirectionType)direction andContext:(CGContextRef)ctx andArrowColor:(UIColor *)arrowColor {
    
    CGPoint uiStartPoint = bs_convertBSChartCoordinateToUIKitWith(startP, self.chartOriginPoint);
    
    //0 x方向  1 y方向
    CGContextSetStrokeColorWithColor(ctx, arrowColor.CGColor);
    CGContextSetFillColorWithColor(ctx, arrowColor.CGColor);
    CGFloat triangleL = BSPxToPt(30.0);
    
    CGFloat triangleH = triangleL*sqrt(3)/2;
    CGPoint lines[3];
    if (!direction) { //x 方向
        
        lines[0] = CGPointMake(uiStartPoint.x-triangleH, uiStartPoint.y+triangleL*0.5);
        lines[1] = CGPointMake(uiStartPoint.x, uiStartPoint.y);
        lines[2] = CGPointMake(uiStartPoint.x-triangleH, uiStartPoint.y-triangleL*0.5);
        
    } else { //y 方向
        
        lines[0] = CGPointMake(uiStartPoint.x+triangleL*0.5, uiStartPoint.y+triangleH);
        lines[1] = CGPointMake(uiStartPoint.x, uiStartPoint.y);
        lines[2] = CGPointMake(uiStartPoint.x-triangleL*0.5, uiStartPoint.y+triangleH);
        
    }
    CGContextAddLines(ctx, lines, 3);
//    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
}

//画文字
- (void)drawTextStringWith:(CGPoint)startP andText:(NSString *)value andDirection:(BSChartValuePositionType)direction andContext:(CGContextRef)ctx andTextColor:(UIColor *)textColor andTextFont:(UIFont *)font {
    CGPoint uiStartPoint = bs_convertBSChartCoordinateToUIKitWith(startP, self.chartOriginPoint);
    
    CGFloat margin = BSPxToPt(8.0);
    CGRect valueRect;
    CGSize valueSize = [value sizeWithAttributes:@{NSFontAttributeName:font}];
    CGFloat w = BSPxToPt(200);
    if (valueSize.width > w) {
        valueSize = CGSizeMake(w, w*0.5);
    }
    if (direction == BSChartValuePositionLeft) { //前方
        
        valueRect = (CGRect){uiStartPoint.x-valueSize.width-margin,uiStartPoint.y-valueSize.height*0.5,valueSize};
    } else if (direction == BSChartValuePositionDown) { //下方
        
        valueRect = (CGRect){uiStartPoint.x-valueSize.width*0.5,uiStartPoint.y+margin,valueSize};
    } else if (direction == BSChartValuePositionRight) { //后方
        
        valueRect = (CGRect){uiStartPoint.x+margin,uiStartPoint.y-valueSize.height*0.5,valueSize};
    } else { //上方
        
        valueRect = (CGRect){uiStartPoint.x-valueSize.width*0.5,uiStartPoint.y-valueSize.height-margin,valueSize};
    }
    
    [value drawInRect:valueRect withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor}];
}

- (void)drawColorRectWithStartP:(CGPoint)startP andEndP:(CGPoint)endPoint andContext:(CGContextRef)ctx andFillColor:(UIColor *)fillColor andAlpha:(CGFloat)alpha {
    
    CGPoint uiStartP = bs_convertBSChartCoordinateToUIKitWith(startP, self.chartOriginPoint);
    CGPoint uiEndP = bs_convertBSChartCoordinateToUIKitWith(endPoint, self.chartOriginPoint);
    
    CGRect fillRect = CGRectMake(uiStartP.x, uiEndP.y, uiEndP.x-uiStartP.x, uiStartP.y-uiEndP.y);
    CIColor *ciColor = [[CIColor alloc] initWithColor:fillColor];
    
    CGContextSetRGBFillColor(ctx, ciColor.red, ciColor.green, ciColor.blue, alpha);
    CGContextFillRect(ctx, fillRect);
    
}


- (void)drawALineWithAnimationFrom:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andLineColor:(UIColor *)lineColor lineSuperLayer:(CALayer *)superLayer andPath:(CGMutablePathRef)lineMutablePath {
    
    CGPoint uiStartP = bs_convertBSChartCoordinateToUIKitWith(startPoint, self.chartOriginPoint);
    CGPoint uiEndP = bs_convertBSChartCoordinateToUIKitWith(endPoint, self.chartOriginPoint);
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.lineCap = kCALineCapButt;
    lineLayer.strokeColor = lineColor.CGColor;
    lineLayer.fillColor = nil;
    
    if (lineMutablePath) {
        
        CGPathMoveToPoint(lineMutablePath, nil, uiStartP.x, uiStartP.y);
        CGPathAddLineToPoint(lineMutablePath, nil, uiEndP.x, uiEndP.y);
        lineLayer.path = lineMutablePath;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 3.0;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        //    self.clipsToBounds = YES;
        [superLayer addSublayer:lineLayer];
        
    } else {
        
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGPathMoveToPoint(linePath, nil, uiStartP.x, uiStartP.y);
        CGPathAddLineToPoint(linePath, nil, uiEndP.x, uiEndP.y);
        lineLayer.path = linePath;
        
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 3.0;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        pathAnimation.autoreverses = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        
        //    self.clipsToBounds = YES;
        [superLayer addSublayer:lineLayer];
        CGPathRelease(linePath);

    }
    

}



- (BOOL)isCrossValue:(CGFloat)crossValue andStartPoint:(CGPoint)startP andEndPoint:(CGPoint)endP andStartPColor:(UIColor *)startColor andEndPColor:(UIColor *)endColor andLayer:(CALayer *)layer {
    if ((startP.y - crossValue)*(endP.y - crossValue)<0) {
        
        CGFloat lineK = (startP.y - endP.y)/(startP.x - endP.x);
        CGPoint crossP = CGPointMake((crossValue-startP.y)/lineK+startP.x, crossValue);
        [self drawALineWithAnimationFrom:startP andEndPoint:crossP andLineColor:startColor lineSuperLayer:layer andPath:nil];
        [self drawALineWithAnimationFrom:crossP andEndPoint:endP andLineColor:endColor lineSuperLayer:layer andPath:nil];
        
        return YES;
    } else {
        
        return NO;
    }
    
}

@end

