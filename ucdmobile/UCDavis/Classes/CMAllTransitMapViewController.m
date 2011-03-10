//
//  CMAllTransitMapViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CMAllTransitMapViewController.h"
#import "MKMapKitHelper.h"
#import "UTVehicleManager.h"
#import "UTVehicle.h"
#import "CMTransitRouteStopList.h"
#import "VehicleAnnotation.h"
#import "UIAlertHelper.h"
#import "TransitHelper.h"
#import "GTRoute.h"

#define kBusPollTime 30.0

@interface CMAllTransitMapViewController (Private)

- (void)synchronousLoadTransit;
- (void)synchronousUpdateTransit;
- (void)didFinishLoadingTransit;

@end

@implementation CMAllTransitMapViewController

@synthesize mapView;
@synthesize locationManager;
@synthesize vehicleAnnotations;
@synthesize unitransVehicleManager;
@synthesize vehicleUpdateTimer;
@synthesize calendar;

- (void)dealloc {
	// hide the network indicator if the exited
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	[mapView release];
	mapView.delegate = nil; // prevent any memory leaks from fetching tiles
	[locationManager release];
	[operationQueue release];
	[unitransVehicleManager release];
	[vehicleAnnotations release];
	[vehicleUpdateTimer release];
	[calendar release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"All Bus Lines";
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	
	// initialize annotation arrays
	NSMutableArray *mutAr = [[NSMutableArray alloc] init];
	self.vehicleAnnotations = mutAr;
	[mutAr release];
	
	// fetch current unitrans information, might take a while, so do it in the background
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadTransit) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	
	// set up timer to refresh the buses
	self.vehicleUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:kBusPollTime target:self selector:@selector(synchronousUpdateTransit) userInfo:nil repeats:YES];
	
	// set center to surrounding to transit area
	CLLocationCoordinate2D centerCoordinate;
	centerCoordinate.latitude = 38.551172;
	centerCoordinate.longitude = -121.739158;
	self.mapView.region = MKCoordinateRegionMake(centerCoordinate, MKCoordinateSpanMake(.1, .1));
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
#pragma mark Transit Methods

- (void)synchronousLoadTransit {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	UTVehicleManager *manager = [[UTVehicleManager alloc] init];
	self.unitransVehicleManager = manager;
	[manager release];
	
	[self performSelectorOnMainThread:@selector(didFinishLoadingTransit) withObject:nil waitUntilDone:NO];
}

- (void)synchronousUpdateTransit {
	// don't load if any annotations are selected
	if([[self.mapView selectedAnnotations] count] > 0) {
		return;
	}
	// this condition checks if we are the top view controller, if not, invalidate and nil the timer
	if(![self.navigationController.topViewController isEqual:self]) {
		[self.vehicleUpdateTimer invalidate];
		self.vehicleUpdateTimer = nil;
	}
	[self.unitransVehicleManager updatePositions];
	[self performSelectorOnMainThread:@selector(didFinishLoadingTransit) withObject:nil waitUntilDone:NO];
}

// update the buses, show new locations
- (IBAction)updateTransit {
	// fetch current unitrans information, might take a while, so do it in the background
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousUpdateTransit) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didFinishLoadingTransit {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[mapView removeAnnotations:self.vehicleAnnotations]; // remove old vehicle annotations
	for(UTVehicle *vehicle in self.unitransVehicleManager.vehicles) {
		VehicleAnnotation *ann = [[VehicleAnnotation alloc] initWithVehicle:vehicle];
		[self.mapView addAnnotation:ann];
		[self.vehicleAnnotations addObject:ann];
		[ann release];
	}
}

#pragma mark -
#pragma mark MKMapViewDelegate methods

- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation {
	MKAnnotationView *annotationView;
	
	if(annotation == theMapView.userLocation) {
		annotationView = nil; // let the application add the blue dot for us
	} else if([annotation isKindOfClass:[VehicleAnnotation class]]) { // bus icons
		static NSString *AnnotationIdentifier = @"BusAnnotation";
		annotationView = [theMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
		
		if(annotationView == nil) {
			MKAnnotationView *busAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
			busAnnotationView.canShowCallout = YES;
			busAnnotationView.calloutOffset = CGPointMake(6, 0);
			
			busAnnotationView.enabled = YES;
			busAnnotationView.rightCalloutAccessoryView = nil;
			annotationView = busAnnotationView;
		}
		UTVehicle *vehicle = [(VehicleAnnotation *)annotation vehicle];
		NSString *busImage = [NSString stringWithFormat:@"bus_%d.png", vehicle.heading / 45];
		annotationView.image = [UIImage imageNamed:busImage];
		annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	}
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	// fetch the route
	VehicleAnnotation *annotation = (VehicleAnnotation *) view.annotation;
	UTVehicle *vehicle = annotation.vehicle;

	GTRoute *route = [[TransitHelper sharedInstance] routeById:vehicle.routeTag];
	CMTransitRouteStopList *transitRouteStopList = [[CMTransitRouteStopList alloc] initWithNibName:@"CMTransitRouteStopList" bundle:nil];
	transitRouteStopList.stops = [[TransitHelper sharedInstance] stopsByRoute:route calendar:self.calendar];
	transitRouteStopList.route = route;
	transitRouteStopList.calendar = self.calendar;
	[self.navigationController pushViewController:transitRouteStopList animated:YES];
	[transitRouteStopList release];	
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

#pragma mark Location Methods

- (IBAction)showCurrentLocation:(id)sender {
	if(!mapView.showsUserLocation) {	
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

@end
