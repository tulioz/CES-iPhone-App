//
//  EventDetailViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventDetailViewController.h"


@implementation EventDetailViewController

-(id)initWithEventId:(NSString *)eventId {
    if (self = [super init]) {
        _eventId = eventId;
        self.tableViewStyle = UITableViewStyleGrouped;
        NSLog(@"Loaded with eventId of %@", _eventId);
    }
    
    return self;
}

-(void)viewDidLoad {
    self.title = @"Event Info.";
}

-(void)createModel {
    self.dataSource = [[[EventItemDataSource alloc] initWithEventId:_eventId] autorelease];
}

-(id<UITableViewDelegate>)createDelegate {
    return [[[TTTableViewVarHeightDelegate alloc] initWithController:self] autorelease];
    //	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
