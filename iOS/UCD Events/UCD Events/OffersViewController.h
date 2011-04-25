//
//  OffersViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface OffersViewController : TTViewController <TTScrollViewDataSource, TTScrollViewDelegate> {
    TTScrollView* _scrollView;
    TTPageControl* _pageControl;
    NSArray* _colors;
}

@end
