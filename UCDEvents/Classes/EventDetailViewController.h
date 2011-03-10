//
//  EventDetailViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventItem.h"
#import "LocationDetailViewController.h"
#import <Three20/Three20.h>

@interface EventDetailViewController : UIViewController {
	
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UITextView *descriptionScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *eventImageView;

@property (nonatomic, retain) EventItem *theEvent;

-(id)initWithEvent:(EventItem *)event;
-(IBAction)viewLocation;

@end
