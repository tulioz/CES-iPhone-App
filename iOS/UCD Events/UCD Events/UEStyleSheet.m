//
//  UEStyleSheet.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UEStyleSheet.h"


@implementation UEStyleSheet

-(UIColor*)emergencyInfoButtonBackgroundColor {
    return [self.styleSheet backgroundColorWithCssSelector:@".emergencyInfoButton" forState:UIControlStateNormal];
}

-(UIFont*)emergencyInfoButtonFont {
    return [self.styleSheet fontWithCssSelector:@".emergencyInfoButton" forState:UIControlStateNormal];
}


// http://groups.google.com/group/three20/browse_thread/thread/186386848c1b7ab7?fwc=1
- (TTStyle*)emergencyInfoButton:(UIControlState)state {
//    TTDefaultCSSStyleSheet *styleSheet = [TTDefaultCSSStyleSheet globalCSSStyleSheet];
    
    TTShape* shape = [TTRectangleShape shape];
    UIColor* tintColor = [self emergencyInfoButtonBackgroundColor];
    return [TTSTYLESHEET toolbarButtonForState:state shape:shape tintColor:tintColor font:[self emergencyInfoButtonFont]];
}

- (TTStyle*)blueToolbarButton:(UIControlState)state {
    TTShape* shape = [TTRoundedRectangleShape shapeWithRadius:4.5];
    UIColor* tintColor = RGBCOLOR(30, 110, 255);
    return [TTSTYLESHEET toolbarButtonForState:state shape:shape tintColor:tintColor font:nil];
}

@end
