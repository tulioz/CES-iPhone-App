//
//  CMTransitStopDetailView.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CMTransitStopDetailView.h"
#import "StaticMapHelper.h"
#import "GTStop.h"
#import "GTRoute.h"
#import "UTPredictions.h"
#import "UIView+Rounding.h"
#import "TransitHelper.h"

#define kEtaIndex 0
#define kStopTimesIndex 1

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kLoadingSource = @"Loading...";


@interface CMTransitStopDetailView ()

- (void)synchronousLoadLocationImage;
- (void)synchronousLoadPredictions;
- (void)didFinishLoadingPredictions;
- (void)synchronousLoadStopTimes;
- (void)didFinishLoadingStopTimes;

@end


@implementation CMTransitStopDetailView

@synthesize activityIndicatorView;
@synthesize calendar;
@synthesize stop;
@synthesize route;
@synthesize predictions;
@synthesize headerView;
@synthesize stopTitleLabel;
@synthesize stopImageView;
@synthesize dataSourceArray;

- (void)dealloc {
	[activityIndicatorView release];
	[calendar release];
	[stop release];
	[route release];
	[predictions release];
	[headerView release];
	[stopTitleLabel release];
	[stopImageView release];
	[dataSourceArray release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Stop Info";
	self.stopTitleLabel.text = stop.name;	
	self.tableView.tableHeaderView = self.headerView;
	// round edges of the stop view
	[self.stopImageView roundCornersWithRadius:10 borderColor:[UIColor lightGrayColor]];
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:3];
	
	// fetch location image, predictions, and load stop times
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadLocationImage) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadPredictions) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	
	operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadStopTimes) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];	
	
	
	// set up initial rows while it loads
	self.dataSourceArray = [NSMutableArray array];
	NSMutableDictionary *mutPredictionsDict = [NSMutableDictionary dictionaryWithCapacity:2];
	[mutPredictionsDict setObject:@"Estimated Time of Arrival" forKey:kSectionTitleKey];
	[mutPredictionsDict setObject:[NSArray arrayWithObject:kLoadingSource] forKey:kSourceKey];
	[self.dataSourceArray addObject:mutPredictionsDict];
	
	NSMutableDictionary *mutStopTimesDict = [NSMutableDictionary dictionaryWithCapacity:2];
	[mutStopTimesDict setObject:@"Stop Times" forKey:kSectionTitleKey];
	[mutStopTimesDict setObject:[NSArray arrayWithObject:kLoadingSource] forKey:kSourceKey];
	[self.dataSourceArray addObject:mutStopTimesDict];
}

#pragma mark -
#pragma mark Background Thread methods

- (void)synchronousLoadLocationImage {
	UIImage *staticMapImage = [StaticMapHelper cachedImageViewWithLatitude:stop.latitude longitude:stop.longitude mapType:MapTypeRoadMap marker:YES reuseIdentifier:[NSString stringWithFormat:@"%d", stop.stopId]];
	if(staticMapImage != nil) {
		self.stopImageView.image = staticMapImage;
	} else { // load a default image if it didn't load
		self.stopImageView.image = [UIImage imageNamed:@"stop_detail.png"];
	}
	[self.activityIndicatorView stopAnimating];
}

- (void)synchronousLoadPredictions {
	UTPredictions *preds = [[UTPredictions alloc] initWithRouteTag:self.route.routeId stopId:self.stop.stopId];
	self.predictions = preds;
	[preds release];
	
	// set up the prediction string
	NSArray *stopPredictions = [[self.predictions.predictionDictionary objectForKey:self.route.routeId] valueForKey:@"minutes"];
	NSString *predictionString = nil;
	if([stopPredictions count] > 0) {
		predictionString = [NSString stringWithFormat:@"%@ mins", [stopPredictions componentsJoinedByString:@", "]];
	} else {
		predictionString = @"No Predictions Available";
	}
	
	[[self.dataSourceArray objectAtIndex:kEtaIndex] setObject:[NSArray arrayWithObject:predictionString] forKey:kSourceKey];
	[self performSelectorOnMainThread:@selector(didFinishLoadingPredictions) withObject:nil waitUntilDone:NO];
}

- (void)didFinishLoadingPredictions {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[self.tableView reloadData];
}

- (void)synchronousLoadStopTimes {
	[[self.dataSourceArray objectAtIndex:kStopTimesIndex] setObject:[[TransitHelper sharedInstance] stopTimesByStop:self.stop route:self.route calendar:self.calendar] forKey:kSourceKey];
	
	[self performSelectorOnMainThread:@selector(didFinishLoadingStopTimes) withObject:nil waitUntilDone:NO];
}

- (void)didFinishLoadingStopTimes {
	[self.tableView reloadData];	
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

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSourceArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[self.dataSourceArray objectAtIndex:section] objectForKey:kSectionTitleKey];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.dataSourceArray objectAtIndex:section] objectForKey:kSourceKey] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	NSString *cellText = [[[self.dataSourceArray objectAtIndex:indexPath.section] objectForKey:kSourceKey] objectAtIndex:indexPath.row];
	// show a loading spinner
	if(cellText == kLoadingSource) {
		UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		cell.accessoryView = spinner;
		[spinner startAnimating];
		[spinner release];
	} else {
		cell.accessoryView = nil;
	}
	cell.textLabel.text = cellText;
    return cell;	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

