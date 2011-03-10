//
//  CMTransitMapViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class GTRoute;
@class UTVehicleManager;

@interface CMTransitMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	NSString *calendar;
	GTRoute *route;
	NSArray *stops;
	
	MKMapView *mapView;
	CLLocationManager *locationManager;
	
	NSMutableArray *vehicleAnnotations;
	NSMutableArray *stopAnnotations;	
	UTVehicleManager *unitransVehicleManager;
	NSTimer *vehicleUpdateTimer;
	
	NSOperationQueue *operationQueue;
}

@property (nonatomic, retain) NSString *calendar;
@property (nonatomic, retain) GTRoute *route;
@property (nonatomic, retain) NSArray *stops;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *vehicleAnnotations;
@property (nonatomic, retain) NSMutableArray *stopAnnotations;
@property (nonatomic, retain) UTVehicleManager *unitransVehicleManager;
@property (nonatomic, retain) NSTimer *vehicleUpdateTimer;

- (IBAction)didSelectMapType:(id)sender;
- (IBAction)showCurrentLocation:(id)sender;
- (IBAction)updateTransit;

@end
