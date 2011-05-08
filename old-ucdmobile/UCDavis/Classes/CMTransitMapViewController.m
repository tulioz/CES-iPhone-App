//
//  CMTransitMapViewController.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CMTransitMapViewController.h"
#import "CMTransitStopDetailView.h"
#import "CMTransitRouteStopList.h"
#import "MKMapKitHelper.h"
#import "UTVehicleManager.h"
#import "UTVehicle.h"
#import "CMAnnotation.h"
#import "StopAnnotation.h"
#import "VehicleAnnotation.h"
#import "GTRoute.h"
#import "GTStop.h"
#import "TransitHelper.h"
#import "UIAlertHelper.h"

#define kBusPollTime 30.0

@interface CMTransitMapViewController (Private)

- (void)synchronousLoadTransit;
- (void)synchronousUpdateTransit;
- (void)didFinishLoadingTransit;
- (void)synchronousLoadStops;
- (void)didFinishLoadingStop;
- (void)didSelectStopList:(id)sender;

@end

@implementation CMTransitMapViewController

@synthesize calendar;
@synthesize mapView;
@synthesize locationManager;
@synthesize vehicleAnnotations;
@synthesize stopAnnotations;
@synthesize unitransVehicleManager;
@synthesize route;
@synthesize stops;
@synthesize vehicleUpdateTimer;

- (void)dealloc {
	// hide the network indicator if the exited
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

	[calendar release];
	[route release];
	[stops release];
	[mapView release];
	mapView.delegate = nil; // prevent any memory leaks from fetching tiles
	[locationManager release];
	[operationQueue release];
	[unitransVehicleManager release];
	[stopAnnotations release];
	[vehicleAnnotations release];
	[vehicleUpdateTimer release];
    [super dealloc];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = [NSString stringWithFormat:@"%@ Line", self.route.routeId];
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];

	// fetch stops for this route
	self.stops = [[TransitHelper sharedInstance] stopsByRoute:self.route calendar:self.calendar];
	
	// initialize annotation arrays
	NSMutableArray *mutAr = [[NSMutableArray alloc] init];
	self.vehicleAnnotations = mutAr;
	[mutAr release];
	mutAr = [[NSMutableArray alloc] init];
	self.stopAnnotations = mutAr;
	[mutAr release];
	
	// fetch current unitrans information, might take a while, so do it in the background
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(synchronousLoadTransit) object:nil];
    [operationQueue addOperation:operation]; // send to background thread
    [operation release];
	
	// add stops on the map
	for(GTStop *stop in self.stops) {
		StopAnnotation *ann = [[StopAnnotation alloc] initWithStop:stop];
		[self.mapView addAnnotation:ann];
		[self.stopAnnotations addObject:ann];
		[ann release];
	}
	[self.mapView setRegion:[MKMapKitHelper regionToFitAnnotations:self.stopAnnotations] animated:YES];
	
	// set up timer to refresh the buses
	self.vehicleUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:kBusPollTime target:self selector:@selector(synchronousUpdateTransit) userInfo:nil repeats:YES];
		
	// set up right button to give them a list of stops
	UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Stops" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectStopList:)];
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

#pragma mark -
#pragma mark Transit Methods

- (void)synchronousLoadTransit {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	UTVehicleManager *manager = [[UTVehicleManager alloc] initWithRouteTag:self.route.routeId];
	self.unitransVehicleManager = manager;
	[manager release];
	[self performSelectorOnMainThread:@selector(didFinishLoadingTransit) withObject:nil waitUntilDone:NO];
}

- (void)synchronousUpdateTransit {
	if([[self.mapView selectedAnnotations] count] > 0) {
		return;
	}	
	// this condition checks if we are in the view controller stack, if not, invalidate and nil the timer
	if(![self.navigationController.viewControllers containsObject:self]) {
		[self.vehicleUpdateTimer invalidate];
		self.vehicleUpdateTimer = nil;
	}
	[self.unitransVehicleManager updatePositions];
	[self performSelectorOnMainThread:@selector(didFinishLoadingTransit) withObject:nil waitUntilDone:NO];
}

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
	} else if([annotation isKindOfClass:[StopAnnotation class]]) { // stop icons
		static NSString *AnnotationIdentifier = @"MKPinAnnotationView";
		annotationView = (MKPinAnnotationView *)[theMapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
		
		if(annotationView == nil) {
			MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
			pinAnnotationView.canShowCallout = YES;
			pinAnnotationView.pinColor = MKPinAnnotationColorRed;
			pinAnnotationView.enabled = YES;
			UIImageView *stopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stop.png"]];
			pinAnnotationView.leftCalloutAccessoryView = stopImageView;
			[stopImageView release];
			pinAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			annotationView = pinAnnotationView;
		}
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
	}
	return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	if([view.annotation isKindOfClass:[StopAnnotation class]]) {
		StopAnnotation *stopAnnotation = (StopAnnotation *)view.annotation;
		// send them to view details on this stop
		CMTransitStopDetailView *transitStopDetailView = [[CMTransitStopDetailView alloc] initWithNibName:@"CMTransitStopDetailView" bundle:nil];
		transitStopDetailView.calendar = self.calendar;
		transitStopDetailView.stop = stopAnnotation.stop;
		transitStopDetailView.route = self.route;
		[self.navigationController pushViewController:transitStopDetailView animated:YES];
		[transitStopDetailView release];
	}
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

#pragma mark Stop List Methods

- (void)didSelectStopList:(id)sender {
	CMTransitRouteStopList *transitRouteStopList = [[CMTransitRouteStopList alloc] initWithNibName:@"CMTransitRouteStopList" bundle:nil];
	transitRouteStopList.stops = self.stops;
	transitRouteStopList.route = self.route;
	transitRouteStopList.calendar = self.calendar;
	[self.navigationController pushViewController:transitRouteStopList animated:YES];
	[transitRouteStopList release];	
}

@end
