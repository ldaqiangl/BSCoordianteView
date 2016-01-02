//
//  UIColor+BSExt.m
//  BSCoordinateView
//
//  Created by 董富强 on 16/1/3.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "UIColor+BSExt.h"

const NSInteger MAX_RGB_COLOR_VALUE = 0xff;
const NSInteger MAX_RGB_COLOR_VALUE_FLOAT = 255.0f;

@implementation UIColor (BSExt)



+ (UIColor *) colorWithRGBA_Ext:(uint) hex {
    return [UIColor colorWithRed:(CGFloat)((hex>>24) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                           green:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                            blue:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                           alpha:(CGFloat)((hex) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT];
}

+ (UIColor *) colorWithARGB_Ext:(uint) hex {
    return [UIColor colorWithRed:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                           green:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                            blue:(CGFloat)(hex & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                           alpha:(CGFloat)((hex>>24) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT];
}

+ (UIColor *) colorWithRGB_Ext:(uint) hex {
    return [UIColor colorWithRed:(CGFloat)((hex>>16) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                           green:(CGFloat)((hex>>8) & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                            blue:(CGFloat)(hex & MAX_RGB_COLOR_VALUE) / MAX_RGB_COLOR_VALUE_FLOAT
                           alpha:1.0];
}

+ (UIColor *)colorWithHexString_Ext:(NSString *)hexString {
    uint hex;
    
    // chop off hash
    if ([hexString characterAtIndex:0] == '#') {
        hexString = [hexString substringFromIndex:1];
    }
    
    // depending on character count, generate a color
    NSInteger hexStringLength = hexString.length;
    
    if (hexStringLength == 3) {
        // RGB, once character each (each should be repeated)
        hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c", [hexString characterAtIndex:0], [hexString characterAtIndex:0], [hexString characterAtIndex:1], [hexString characterAtIndex:1], [hexString characterAtIndex:2], [hexString characterAtIndex:2]];
        hex = (uint) strtoul([hexString UTF8String], NULL, 16);
        
        return [self colorWithRGB_Ext:hex];
    } else if (hexStringLength == 4) {
        // RGBA, once character each (each should be repeated)
        hexString = [NSString stringWithFormat:@"%c%c%c%c%c%c%c%c", [hexString characterAtIndex:0], [hexString characterAtIndex:0], [hexString characterAtIndex:1], [hexString characterAtIndex:1], [hexString characterAtIndex:2], [hexString characterAtIndex:2], [hexString characterAtIndex:3], [hexString characterAtIndex:3]];
        hex = (uint)strtoul([hexString UTF8String], NULL, 16);
        
        return [self colorWithRGBA_Ext:hex];
    } else if (hexStringLength == 6) {
        // RGB
        hex = (uint)strtoul([hexString UTF8String], NULL, 16);
        
        return [self colorWithRGB_Ext:hex];
    } else if (hexStringLength == 8) {
        // RGBA
        hex =(uint) strtoul([hexString UTF8String], NULL, 16);
        
        return [self colorWithRGBA_Ext:hex];
    }
    
    // illegal
    [NSException raise:@"Invalid Hex String" format:@"Hex string invalid: %@", hexString];
    
    return nil;
}

@end
