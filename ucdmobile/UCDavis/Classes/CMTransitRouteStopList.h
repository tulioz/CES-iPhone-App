//
//  CMTransitRouteStopList.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/13/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTRoute;

@interface CMTransitRouteStopList : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
	GTRoute *route;
	NSString *calendar;

	NSArray *stops;
	NSMutableArray *filteredStops;
}

@property(nonatomic, retain) GTRoute *route;
@property(nonatomic, retain) NSString *calendar;
@property(nonatomic, retain) NSArray *stops;
@property(nonatomic, retain) NSMutableArray *filteredStops;

@end
