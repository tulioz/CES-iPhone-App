//
//  EventListViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventListViewController.h"


@implementation EventListViewController

-(void)viewDidLoad {
    self.title = eventsTitleString;
}

-(void)createModel {
    self.dataSource = [[[EventIndexJSONDataSource alloc]
                        init] autorelease];
}

-(id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
