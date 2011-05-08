//
//  CMTransitRouteStopList.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/13/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CMTransitRouteStopList.h"
#import "CMTransitStopDetailView.h"
#import "GTStop.h"
#import "GTRoute.h"

@implementation CMTransitRouteStopList

@synthesize route;
@synthesize calendar;
@synthesize stops;
@synthesize filteredStops;

- (void)dealloc {
	[route release];
	[calendar release];
	[stops release];
	[filteredStops release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [NSString stringWithFormat:@"%@ Stops", route.routeId];
	
	self.filteredStops = [self.stops mutableCopy];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredStops count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTStop *stop = [self.filteredStops objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
	cell.textLabel.text = stop.name;
	cell.detailTextLabel.text = stop.description;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	CMTransitStopDetailView *transitStopDetailView = [[CMTransitStopDetailView alloc] initWithNibName:@"CMTransitStopDetailView" bundle:nil];
	transitStopDetailView.calendar = self.calendar;
	transitStopDetailView.stop = [self.filteredStops objectAtIndex:indexPath.row];
	transitStopDetailView.route = self.route;
	[self.navigationController pushViewController:transitStopDetailView animated:YES];
	[transitStopDetailView release];
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText {
	// update the filtered array based on the search text and scope.
	[self.filteredStops removeAllObjects]; // first clear the filtered array.
	
	for (GTStop *stop in self.stops) {
		NSComparisonResult result = [stop.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
		if (result == NSOrderedSame) {
			[self.filteredStops addObject:stop];
		}
	}
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
	[self filterContentForSearchText:searchString];
	
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	self.filteredStops = [self.stops mutableCopy];
}

@end

