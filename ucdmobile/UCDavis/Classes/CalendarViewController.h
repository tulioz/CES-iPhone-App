//
//  CalendarViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 11/6/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalendarViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray *viewControllers;
    // To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (IBAction)changePage:(id)sender;

@end
