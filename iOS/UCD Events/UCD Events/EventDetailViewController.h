//
//  EventDetailViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "EventItem.h"

@interface EventDetailViewController : TTTableViewController {
    NSString* _eventId;
}

@property (nonatomic, retain) EventItem *viewingEvent;

@end
