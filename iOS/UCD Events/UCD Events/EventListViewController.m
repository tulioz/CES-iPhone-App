//
//  EventListViewController.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventListViewController.h"


@implementation EventListViewController

#pragma mark -
#pragma mark UIView

-(void)viewDidLoad {
    self.title = eventsTitleString;
    self.tableView.frame = CGRectMake(0, 0, 320, 385);
    
    TTButton *emergencyInfoButton = [TTButton buttonWithStyle:@"bottomBarButton:" title:@"View All Events"];
    [emergencyInfoButton addTarget:@"ucde://info/" action:@selector(openURLFromButton:) forControlEvents:UIControlEventTouchUpInside];

    [emergencyInfoButton setFrame:CGRectMake(0, 370, 320, 50)];
    
    [self.view addSubview:emergencyInfoButton];
}

#pragma mark -
#pragma mark TTTableViewController

-(void)createModel {
    self.dataSource = [[[EventIndexJSONDataSource alloc]
                        init] autorelease];
}

-(id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
