//
//  CMTransitRouteListView.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CMTransitLineListView.h"
#import "CMTransitMapViewController.h"
#import "CMAllTransitMapViewController.h"
#import "CMTransitStopSearchViewController.h"
#import "GTRoute.h"
#import "TransitHelper.h"

#define kDefaultCalendarTimeSinceEpoch 1262736000
#define kDatePickerOffScreen CGRectMake(0, 416, 325, 250)
#define kDatePickerOnScreen CGRectMake(0, 200, 325, 250)

@interface CMTransitLineListView ()

- (void)didSelectCalendar:(id)sender;
- (NSString *)shortStringFromDate:(NSDate *)date;

@end

@implementation CMTransitLineListView

@synthesize calendar;
@synthesize routes;
@synthesize datePicker;
@synthesize tableView;
@synthesize sectionTitles;

- (void)dealloc {
	[calendar release];
	[routes release];
	[datePicker release];
	[tableView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Routes";
	
	NSDate *date = [NSDate date];
	// if they are at an invalid date (messed up time settings or old app)
	if([date compare:self.datePicker.minimumDate] == NSOrderedAscending || [date compare:self.datePicker.maximumDate] == NSOrderedDescending) {
		// set date to a default date, January 6th, 2010
		date = [NSDate dateWithTimeIntervalSince1970:kDefaultCalendarTimeSinceEpoch];
	}
	self.calendar = [[TransitHelper sharedInstance] calendarWithDate:date];
	self.routes = [[TransitHelper sharedInstance] routesByCalendar:self.calendar];
	
	self.sectionTitles = [NSArray arrayWithObjects:@"All Bus Lines", @"Individual Bus Lines", nil];
	
	// set the date picker's date to today
	self.datePicker.date = [NSDate date];
	
	// set up right button to let them change the date
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:[self shortStringFromDate:[NSDate date]] style:UIBarButtonItemStylePlain target:self action:@selector(didSelectCalendar:)];
	self.navigationItem.rightBarButtonItem = barButton;
	[barButton release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionTitles count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self.sectionTitles objectAtIndex:section];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return section == 0 ? 1 : [self.routes count]; // the first section is all bus lines
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
	static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.imageView.image = nil;
    }
    
    // Set up the cell...
	if(indexPath.section == 0) {
		cell.textLabel.text = @"All Bus Lines";
		cell.detailTextLabel.text = [[self.routes valueForKey:@"routeId"] componentsJoinedByString:@", "];
		cell.imageView.image = nil;
	} else {
		GTRoute *route = [self.routes objectAtIndex:indexPath.row];
		NSString *textLabel = [NSString stringWithFormat:@"%@ Line", route.routeId];
		cell.textLabel.text = textLabel;
		cell.detailTextLabel.text = route.longName;
		cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon.png", route.routeId]];
	}
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	[self.tableView  deselectRowAtIndexPath:indexPath  animated:YES];
	if(indexPath.section == 0) {		
		CMAllTransitMapViewController *allTransitMapViewController = [[CMAllTransitMapViewController alloc] initWithNibName:@"CMAllTransitMapViewController" bundle:nil];
		allTransitMapViewController.calendar = self.calendar;
		[self.navigationController pushViewController:allTransitMapViewController animated:YES];
		[allTransitMapViewController release];
	} else {
		CMTransitMapViewController *transitMapViewController = [[CMTransitMapViewController alloc] initWithNibName:@"CMTransitMapViewController" bundle:nil];
		transitMapViewController.route = [self.routes objectAtIndex:indexPath.row];
		transitMapViewController.calendar = self.calendar;
		[transitMapViewController viewWillAppear:YES];
		[self.navigationController pushViewController:transitMapViewController animated:YES];
		[transitMapViewController release];
	}
}

#pragma mark -
#pragma mark Search Delegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:NO animated:YES];
	[searchBar resignFirstResponder];

	// send them to view the stops
	CMTransitStopSearchViewController *stopSearchListViewController = [[CMTransitStopSearchViewController alloc] initWithNibName:@"CMTransitStopSearchViewController" bundle:nil];
	stopSearchListViewController.searchString = searchBar.text;
	stopSearchListViewController.calendar = self.calendar;
	[self.navigationController pushViewController:stopSearchListViewController animated:YES];
	[stopSearchListViewController release];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:NO animated:YES];
	
	[searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Private methods

- (void)didSelectCalendar:(id)sender {
	[UIView beginAnimations:@"CalendarTransition" context:nil];
	[UIView setAnimationDuration:0.3];
	if(self.datePicker.frame.origin.y < kDatePickerOffScreen.origin.y) { // on screen
		self.datePicker.frame = kDatePickerOffScreen;
		// update new transit lines
		self.calendar = [[TransitHelper sharedInstance] calendarWithDate:[datePicker date]];
		self.routes = [[TransitHelper sharedInstance] routesByCalendar:self.calendar];
		[self.tableView reloadData];
		
		self.navigationItem.rightBarButtonItem.title = [self shortStringFromDate:[datePicker date]];
	} else { // off screen
		self.datePicker.frame = kDatePickerOnScreen;
		self.navigationItem.rightBarButtonItem.title = @"Done";
	}
	[UIView commitAnimations];
}

- (NSString *)shortStringFromDate:(NSDate *)date {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	NSString *shortString = [dateFormatter stringFromDate:date];
	[dateFormatter release];
	return shortString;
}

@end

