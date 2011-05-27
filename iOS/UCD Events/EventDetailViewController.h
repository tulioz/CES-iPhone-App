//
//  EventDetailViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "EventItemDataSource.h"

@interface EventDetailViewController : TTTableViewController {
    NSString *_eventId;
}

-(id)initWithEventId:(NSString *)eventId;

@end
