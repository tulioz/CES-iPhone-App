//
//  CMBuildingDetailViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CMBuildingDetailViewController.h"
#import "CMBuilding.h"
#import "StaticMapHelper.h"
#import "UIView+Rounding.h"
#import "UIColor+CustomColors.h"
#import "UIAlertHelper.h"

#define kBuildingLayout 0
#define kDirections 1
#define kViewInMap 2

#define kWalking 0
#define kDriving 1
#define kPublicTransit 2
#define kCancelButton 3

@interface CMBuildingDetailViewController (Private)

- (void)openGoogleMapsWithStartingCoordinate:(CLLocationCoordinate2D)start directionType:(NSInteger)directionType;

@end

@implementation CMBuildingDetailViewController

@synthesize activityIndicatorView;
@synthesize building;
@synthesize headerView;
@synthesize buildingNameLabel;
@synthesize buildingLocationImageView;
@synthesize footerView;
@synthesize footerImageView;
@synthesize rowLabels;
@synthesize locationManager;

- (void)dealloc {
	[operationQueue release];
	[activityIndicatorView release];
	[building release];
	[buildingNameLabel release];
	[buildingLocationImageView release];
	[headerView release];
	[footerImageView release];
	[footerView release];
	[rowLabels release];
	[locationManager release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Building Info";
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	
	// fetch location image
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadLocationImage) object:nil];
	[operationQueue addOperation:operation]; // send to background thread
	[operation release];
	
	self.buildingNameLabel.text = self.building.name;
	self.tableView.tableHeaderView = self.headerView;
	// round corners of location image
	[buildingLocationImageView roundCornersWithRadius:10 borderColor:[UIColor lightGrayColor]];
	
	
	self.tableView.tableFooterView = self.footerView;
	UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", building.name]];
	self.footerImageView.image = image;
	if(image) {
		// round the corners
		[self.footerImageView roundCornersWithRadius:10 borderColor:[UIColor lightGrayColor]];
	}
	
	// set up rows
	self.rowLabels = [NSArray arrayWithObjects:@"Building Layout", @"Directions To Here", @"View In Map", nil];
	
	// only fetch current location if the user requests directions
	selectedAction = -1;
}

#pragma mark -
#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.rowLabels count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.textColor = [UIColor lightBlueColor];
    }
    
	cell.textLabel.text = [self.rowLabels objectAtIndex:indexPath.row];    
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	if(indexPath.row == kDirections) {
		if(self.locationManager == nil) {
			CLLocationManager *locManager = [[CLLocationManager alloc] init];
			self.locationManager = locManager;
			self.locationManager.delegate = self;
			[locManager release];
			
			// show the user the dialog while we are retrieving their location
			UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Walking Directions", @"Driving Directions", @"Public Transit Directions", nil];
			actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
			[actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
			[actionSheet release];			
		}
		[self.locationManager startUpdatingLocation];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

#pragma mark -
#pragma mark Location Manager Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if(selectedAction != -1) {
		[self openGoogleMapsWithStartingCoordinate:newLocation.coordinate directionType:selectedAction];
		selectedAction = -1; // reset
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Could not get a fix on the user's location.");
	[UIAlertHelper locationErrorAlert];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if(buttonIndex == kCancelButton) {
		return;
	}
	selectedAction = buttonIndex;
	if(self.locationManager.location != nil) { // wait until we get a location fix
		[self openGoogleMapsWithStartingCoordinate:locationManager.location.coordinate directionType:selectedAction];
		selectedAction = -1; // reset
	}
}

#pragma mark -
#pragma mark Private Methods

- (void)synchronousLoadLocationImage {
	UIImage *staticMapImage = [StaticMapHelper cachedImageViewWithLatitude:building.latitude longitude:building.longitude mapType:MapTypeRoadMap marker:YES reuseIdentifier:[NSString stringWithFormat:@"%@", building.name]];
	if(staticMapImage != nil) {
		self.buildingLocationImageView.image = staticMapImage;
	} else { // load a default image if it didn't load
		self.buildingLocationImageView.image = [UIImage imageNamed:@"building_detail.png"];
	}
	[self.activityIndicatorView stopAnimating];
}

// open the Google Maps application with start and end locations
- (void)openGoogleMapsWithStartingCoordinate:(CLLocationCoordinate2D)start directionType:(NSInteger)directionType {
	NSString *formatString = @"http://maps.google.com/maps?saddr=%f,%f&daddr=%@,%@";
	// append the direction type flag
	switch (directionType) {
		case kWalking:
			formatString = [formatString stringByAppendingString:@"&dirflg=w"];
			break;
		case kDriving:
			break;
		case kPublicTransit:
			formatString = [formatString stringByAppendingString:@"&dirflg=r"];
			break;
		default:
			break;
	}
	NSString* url = [NSString stringWithFormat:formatString, start.latitude, start.longitude, building.latitude, building.longitude];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	self.headerView = nil;
	self.footerImageView = nil;
	self.footerView = nil;
}

@end

