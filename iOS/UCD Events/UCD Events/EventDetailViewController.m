//
//  EventDetailViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"


@implementation EventDetailViewController

#pragma mark -
#pragma mark NSObject

-(id)initWithEventId:(NSString *)eventId {
    if (self = [super init]) {
        _eventId = eventId;
        self.tableViewStyle = UITableViewStyleGrouped;
        NSLog(@"Loaded with eventId of %@", _eventId);
    }
    
    return self;
}

#pragma mark -
#pragma mark UIView

-(void)viewDidLoad {
    self.title = @"Event Info.";
}

#pragma mark -
#pragma mark TTTableViewController

-(void)createModel {
    self.dataSource = [[[EventItemDataSource alloc] initWithEventId:_eventId] autorelease];
}

-(id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
    //	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
