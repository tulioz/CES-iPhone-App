//
//  EventListViewController.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"
#import "EventIndexJSONDataSource.h"
#import "Three20/Three20.h"

@protocol EventListViewControllerDelegate;

@interface EventListViewController : TTTableViewController {
    id<EventListViewControllerDelegate> _delegate;
}

@end

@protocol EventListViewControllerDelegate<NSObject>

-(void)eventListViewController:(EventListViewController *)controller didSelectObject:(id)object;

@end