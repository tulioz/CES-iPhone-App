//
//  CMMapViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CMMapViewController.h"
#import "BuildingAnnotation.h"
#import "CMBuildingDetailViewController.h"
#import "DatabaseHelper.h"
#import "CMBuilding.h"
#import "UIAlertHelper.h"

@interface CMMapViewController (UtilityMethods)

//static inline CLLocationCoordinate2D CLLocationCoordinate2DMake(CLLocationDegrees latitude, CLLocationDegrees longitude);

@end

@implementation CMMapViewController

@synthesize mapView;
@synthesize locationManager;
@synthesize buildings;
@synthesize filteredBuildings;

- (void)dealloc {
	[mapView release];
	mapView.delegate = nil; // prevent any memory leaks from fetching tiles
	[locationManager release];
	[buildings release];
	[filteredBuildings release];
    [super dealloc];
}

- (void)viewDidUnload {
	// release any views which can be recreated
	self.mapView = nil;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Campus Map";
	
	// set center to Kemper Hall at UC Davis and zoom in to show building details
	self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(38.537051, -121.754909), MKCoordinateSpanMake(.005, .005));
	
	// fetch buildings
	self.buildings = [[DatabaseHelper sharedInstance] buildings];
	
	// create filtered array to hold buildings that appear in search
	NSMutableArray *mutBuildingArray = [[NSMutableArray alloc] init];
	self.filteredBuildings = mutBuildingArray;
	[mutBuildingArray release];
}

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

#pragma mark -
#pragma mark MKMapViewDelegate methods

- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation {
	// if this is the user location, let the application add the blue dot for us
	if(annotation == theMapView.userLocation) {
		return nil;
	}
	
	static NSString *AnnotationIdentifier = @"CMAnnotationView";
	
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[theMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
	
	if(annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
		annotationView.animatesDrop = YES;
		annotationView.canShowCallout = YES;
		annotationView.enabled = YES;
		annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	}
	
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	BuildingAnnotation *buildingAnnotation = (BuildingAnnotation *)view.annotation;
	CMBuilding *building = buildingAnnotation.building;
	CMBuildingDetailViewController *buildingDetailViewController = [[CMBuildingDetailViewController alloc] initWithNibName:@"CMBuildingDetailViewController" bundle:nil];
	buildingDetailViewController.building = building;
	[self.navigationController pushViewController:buildingDetailViewController animated:YES];
	[buildingDetailViewController release];
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
}

#pragma mark -
#pragma mark Map Methods

- (IBAction)didSelectMapType:(UISegmentedControl *)sender {
	if(sender.selectedSegmentIndex == 0) {
		self.mapView.mapType = MKMapTypeStandard;
	} else if(sender.selectedSegmentIndex == 1) {
		self.mapView.mapType = MKMapTypeHybrid;
	}
}

- (void)addBuildingToMap:(CMBuilding *)building {
	if(building == nil) {
		return;
	}
	// add building pin
	BuildingAnnotation *annotation = [[BuildingAnnotation alloc] initWithBuilding:building];
	[self.mapView addAnnotation:annotation];
	[self.mapView selectAnnotation:annotation animated:YES]; // open the callout
	[annotation release];
	// set region to building location
	[self.mapView setCenterCoordinate:CLLocationCoordinate2DMake([building.latitude doubleValue], [building.longitude doubleValue]) animated:NO];
	
}

#pragma mark -
#pragma mark UISearchBarDelegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	
}

#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.filteredBuildings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID] autorelease];
	}
	CMBuilding *building = [self.filteredBuildings objectAtIndex:indexPath.row];
	cell.textLabel.text = building.name;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	CMBuilding *building = [self.filteredBuildings objectAtIndex:indexPath.row];
	[self addBuildingToMap:building];
	[self.searchDisplayController setActive:NO animated:YES];
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText {
	// update the filtered array based on the search text and scope.
	[self.filteredBuildings removeAllObjects]; // first clear the filtered array.
	
	for (CMBuilding *building in self.buildings) {
		NSComparisonResult result = [building.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
		if (result == NSOrderedSame) {
			[self.filteredBuildings addObject:building];
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

#pragma mark -
#pragma mark Location Methods

- (IBAction)showCurrentLocation:(id)sender {
	if(self.locationManager == nil) {
		// enable Location Manager to get updates
		CLLocationManager *locManager = [[CLLocationManager alloc] init];
		self.locationManager = locManager;
		self.locationManager.delegate = self;
		[locManager release];
	}
	mapView.showsUserLocation = YES;
	[self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	// move to user location on the first fix
	if(ABS([newLocation.timestamp timeIntervalSinceNow]) < 5.0) {
		[self.mapView setCenterCoordinate:newLocation.coordinate animated:YES];
		[manager stopUpdatingLocation]; // only need first fix
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Could not get a fix on the user's location.");
	[UIAlertHelper locationErrorAlert];
}

#pragma mark -
#pragma mark Utility methods

// Convenience Method for creating a CLLocationCoordinate2D
CLLocationCoordinate2D CLLocationCoordinate2DMake(CLLocationDegrees latitude, CLLocationDegrees longitude) {
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = latitude;
	coordinate.longitude = longitude;
	return coordinate;
}

@end
