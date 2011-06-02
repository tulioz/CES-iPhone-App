//
//  UEStyleSheet.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UEStyleSheet.h"


@implementation UEStyleSheet

//from twocentstudios.com
-(TTStyle*)insetSquare {
    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:0] next:
            [TTLinearGradientFillStyle styleWithColor1:[self.styleSheet backgroundColorWithCssSelector:@".featuredTableItem" forState:UIControlStateNormal] color2:RGBCOLOR(230, 200, 0) next:
             [TTInnerShadowStyle styleWithColor:RGBCOLOR(230, 200, 2) blur:3 offset:CGSizeMake(0, 1) next:nil]]];
}

//From three20 examples
- (TTStyle*)largeText {
    return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:24] next:nil];
}

- (TTStyle*)mediumText {
    return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:15] next:nil];
}

- (TTStyle*)smallText {
    return [TTTextStyle styleWithFont:[UIFont systemFontOfSize:12] next:nil];
}

-(UIColor*)launcherNavigationBarBackgroundColor {
    return [self.styleSheet backgroundColorWithCssSelector:@"launcherNavigationBar" forState:UIControlStateNormal];
}

-(UIColor*)featuredBackgroundColor {
    return [self.styleSheet backgroundColorWithCssSelector:@".featuredTableItem" forState:UIControlStateNormal];
}

-(UIColor*)bottomBarButtonBackgroundColor {
    return [self.styleSheet backgroundColorWithCssSelector:@".bottomBarButton" forState:UIControlStateNormal];
}

-(UIFont*)bottomBarButtonFont {
    return [self.styleSheet fontWithCssSelector:@".bottomBarButton" forState:UIControlStateNormal];
}

-(UIColor*)launcherBottomBarButtonBackgroundColor {
    return [self.styleSheet backgroundColorWithCssSelector:@".launcherBottomBarButton" forState:UIControlStateNormal];
}

-(UIFont*)launcherBottomBarButtonFont {
    return [self.styleSheet fontWithCssSelector:@".launcherBottomBarButton" forState:UIControlStateNormal];
}

-(UIColor*)offerFrameBackgroundColor {
    return [self.styleSheet backgroundColorWithCssSelector:@".offerFrame" forState:UIControlStateNormal];
}

-(UIColor*)offerFrameColor {
    return [self.styleSheet colorWithCssSelector:@".offerFrame" forState:UIControlStateNormal];
}

-(UIFont*)offerFrameFont {
    return [self.styleSheet fontWithCssSelector:@".offerFrame" forState:UIControlStateNormal];
}

// http://groups.google.com/group/three20/browse_thread/thread/186386848c1b7ab7?fwc=1
- (TTStyle*)launcherBottomBarButton:(UIControlState)state {
    TTShape* shape = [TTRectangleShape shape];
    UIColor* tintColor = [self launcherBottomBarButtonBackgroundColor];
    return [TTSTYLESHEET toolbarButtonForState:state shape:shape tintColor:tintColor font:[self launcherBottomBarButtonFont]];
}

// http://groups.google.com/group/three20/browse_thread/thread/186386848c1b7ab7?fwc=1
- (TTStyle*)bottomBarButton:(UIControlState)state {
    TTShape* shape = [TTRectangleShape shape];
    UIColor* tintColor = [self bottomBarButtonBackgroundColor];
    return [TTSTYLESHEET toolbarButtonForState:state shape:shape tintColor:tintColor font:[self bottomBarButtonFont]];
}

- (TTStyle*)embossedButton:(UIControlState)state {
    if (state == UIControlStateNormal) {
        return
        [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
         [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
          [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0) blur:1 offset:CGSizeMake(0, 1) next:
           [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 255, 255)
                                               color2:RGBCOLOR(216, 221, 231) next:
            [TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
             [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
              [TTTextStyle styleWithFont:nil color:TTSTYLEVAR(linkTextColor)
                             shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
                            shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
    } else if (state == UIControlStateHighlighted) {
        return
        [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
         [TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, 0, 1, 0) next:
          [TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0.9) blur:1 offset:CGSizeMake(0, 1) next:
           [TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(225, 225, 225)
                                               color2:RGBCOLOR(196, 201, 221) next:
            [TTSolidBorderStyle styleWithColor:RGBCOLOR(161, 167, 178) width:1 next:
             [TTBoxStyle styleWithPadding:UIEdgeInsetsMake(10, 12, 9, 12) next:
              [TTTextStyle styleWithFont:nil color:[UIColor whiteColor]
                             shadowColor:[UIColor colorWithWhite:255 alpha:0.4]
                            shadowOffset:CGSizeMake(0, -1) next:nil]]]]]]];
    } else {
        return nil;
    }
}

- (TTStyle*)blueToolbarButton:(UIControlState)state {
    TTShape* shape = [TTRoundedRectangleShape shapeWithRadius:4.5];
    UIColor* tintColor = RGBCOLOR(30, 110, 255);
    return [TTSTYLESHEET toolbarButtonForState:state shape:shape tintColor:tintColor font:nil];
}

- (TTStyle*)floated {
    return [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(0, 0, 5, 5)
                               padding:UIEdgeInsetsMake(0, 0, 0, 0)
                               minSize:CGSizeZero position:TTPositionFloatLeft next:nil];
}

-(TTStyle*)offerCard {
    return [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:15] next:
            [TTInsetStyle styleWithInset:UIEdgeInsetsMake(10, 10, 10, 10) next:
             [TTLinearGradientFillStyle styleWithColor1:[self.styleSheet colorWithCssSelector:@".offerCard" forState:UIControlStateNormal]
                                                 color2:[self.styleSheet colorWithCssSelector:@".offerCard" forState:UIControlStateNormal] next:
              [TTInnerShadowStyle styleWithColor:RGBCOLOR(200, 150, 2) blur:5 offset:CGSizeMake(0, 2) next:
               [TTSolidBorderStyle styleWithColor:[UIColor clearColor] width:2 next:
                nil]]]]];
}

@end
