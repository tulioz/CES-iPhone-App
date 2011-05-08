//
//  CMTransitStopSearchViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/19/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "CMTransitStopSearchViewController.h"
#import "GTRoute.h"
#import "GTStop.h"
#import "TransitHelper.h"
#import "MBProgressHud.h"
#import "CMTransitStopDetailView.h"

@interface CMTransitStopSearchViewController (Private)

- (void)synchronousLoadStops;
- (void)didFinishLoadingStops;

@end


@implementation CMTransitStopSearchViewController

@synthesize calendar;
@synthesize searchString;
@synthesize stops;

- (void)dealloc {
	[operationQueue release];
	[calendar release];
	[searchString release];
	[stops release];
    [super dealloc];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.title = @"Stops";
	
	// set up operation queue for thread fetching of classes
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	
	// loading the stops might take a while
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadStops) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	
	progressHud = [[MBProgressHUD alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:progressHud];
	progressHud.labelText = [NSString stringWithFormat:@"Finding stops..."];
	[progressHud show:YES];
	
}

- (void)synchronousLoadStops {
	// fetch and numerically sort stops
	self.stops = [[TransitHelper sharedInstance] stopsLikeName:self.searchString calendar:self.calendar];
	[self performSelectorOnMainThread:@selector(didFinishLoadingStops) withObject:nil waitUntilDone:NO];
}

- (void)didFinishLoadingStops {
	[self.tableView reloadData];
	
	[progressHud removeFromSuperview];
	[progressHud release];
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

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.stops count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	GTStop *stop = [[self.stops objectAtIndex:indexPath.row] objectForKey:@"stop"];
	GTRoute *route = [[self.stops objectAtIndex:indexPath.row] objectForKey:@"route"];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
	
	cell.textLabel.text = stop.name;
	
	UIImage *routeIcon = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon.png", route.routeId]];
	if(routeIcon != nil) {
		cell.accessoryView = [[UIImageView alloc] initWithImage:routeIcon];
	} else {
		cell.detailTextLabel.text = route.routeId;
	}
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	GTStop *stop = [[self.stops objectAtIndex:indexPath.row] objectForKey:@"stop"];
	GTRoute *route = [[self.stops objectAtIndex:indexPath.row] objectForKey:@"route"];
	CMTransitStopDetailView *transitStopDetailView = [[CMTransitStopDetailView alloc] initWithNibName:@"CMTransitStopDetailView" bundle:nil];
	transitStopDetailView.calendar = self.calendar;
	transitStopDetailView.stop = stop;
	transitStopDetailView.route = route;
	[self.navigationController pushViewController:transitStopDetailView animated:YES];
	[transitStopDetailView release];
}

@end
