//
//  UIColor+CustomColors.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/4/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "UIColor+CustomColors.h"

// UIColor from RGB value
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kOceanRGB 0x004080

@implementation UIColor (CustomColors)

+ (UIColor *)oceanColor {
	return UIColorFromRGB(kOceanRGB);
}

+ (UIColor *)lightBlueColor {
	return [UIColor colorWithRed:0.243 green:0.306 blue:0.435 alpha:1.0];
}

@end
