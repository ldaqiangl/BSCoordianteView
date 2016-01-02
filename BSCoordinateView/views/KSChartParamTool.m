//
//  KSChartParamTool.m
//  Kangs100Vip
//
//  Created by 董富强 on 15/12/19.
//  Copyright © 2015年 06-kangs100. All rights reserved.
//

#import "KSChartParamTool.h"

@implementation KSChartParamTool

KSChartBMPResult KSChartBMPFromString(NSString *bmpStr) {
    NSString *subBmp = [bmpStr substringWithRange:NSMakeRange(1, bmpStr.length-2)];
    NSArray *subBmpArr = [subBmp componentsSeparatedByString:@","];
    KSChartBMPResult bmpResult;
    bmpResult.sys = [[subBmpArr firstObject] floatValue];
    bmpResult.dia = [subBmpArr[1] floatValue];
    bmpResult.pul = [[subBmpArr lastObject] floatValue];
    return bmpResult;
}

NSString* KSStringFromBMPResult(KSChartBMPResult bmp) {
    return [NSString stringWithFormat:@"(%f,%f,%f)",bmp.sys,bmp.dia,bmp.pul];
}

KSChartBMPResult KSChartBMPResultMake(CGFloat sys,CGFloat dia,CGFloat pul) {
    KSChartBMPResult result;
    result.sys = sys;
    result.dia = dia;
    result.pul = pul;
    return result;
}

KSChartColor KSChartColorMake(CGFloat ksr, CGFloat ksg,CGFloat ksb) {
    KSChartColor ksChColor;
    ksChColor.ksR = ksr;
    ksChColor.ksG = ksg;
    ksChColor.ksB = ksb;
    return ksChColor;
}

KSChartGroupColor KSChartGroupColorMake(KSChartColor c1,KSChartColor c2) {
    KSChartGroupColor groupC;
    groupC.sys = KSChartColorMake(c1.ksR, c1.ksG, c1.ksB);
    groupC.dia = KSChartColorMake(c2.ksR, c2.ksG, c2.ksB);
    return groupC;
}
@end
