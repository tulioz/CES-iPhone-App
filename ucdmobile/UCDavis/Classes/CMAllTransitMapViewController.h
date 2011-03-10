//
//  CMAllTransitMapViewController.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class UTVehicleManager;

@interface CMAllTransitMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
	MKMapView *mapView;
	CLLocationManager *locationManager;
	
	NSMutableArray *vehicleAnnotations;
	UTVehicleManager *unitransVehicleManager;
	NSTimer *vehicleUpdateTimer;
	
	NSOperationQueue *operationQueue;
	
	NSString *calendar;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) NSMutableArray *vehicleAnnotations;
@property (nonatomic, retain) UTVehicleManager *unitransVehicleManager;
@property (nonatomic, retain) NSTimer *vehicleUpdateTimer;
@property (nonatomic, retain) NSString *calendar;

- (IBAction)didSelectMapType:(id)sender;
- (IBAction)showCurrentLocation:(id)sender;
- (IBAction)updateTransit;

@end
