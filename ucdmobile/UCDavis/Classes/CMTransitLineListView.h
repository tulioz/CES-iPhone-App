//
//  CMTransitRouteListView.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMTransitLineListView : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate> {	
	UITableView *tableView;
	
	NSString *calendar;
	NSArray *routes;
	
	UIDatePicker *datePicker;
	NSArray *sectionTitles;
}

@property(nonatomic, retain) IBOutlet UITableView *tableView;

@property(nonatomic, retain) NSString *calendar;
@property(nonatomic, retain) NSArray *routes;
@property(nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property(nonatomic, retain) NSArray *sectionTitles;

@end
