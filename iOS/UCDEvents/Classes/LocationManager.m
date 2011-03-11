//
//  LocationManager.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"


@implementation LocationManager

@synthesize locationHandler;
@synthesize delegate;

BOOL updated = NO;

-(void)startUpdates {
	if (locationHandler == nil) {
		locationHandler = [[CLLocationManager alloc] init];
	}
						   
    locationHandler.delegate = self;
	
   locationHandler.desiredAccuracy = kCLLocationAccuracyKilometer;
   [locationHandler startUpdatingLocation];	
}
						   
-(void)locationHandler:(CLLocationManager *)manager didFailWithError:(NSError *) error {
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error determining your location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   [alert show];
   [alert release];
}

						   
-(void)locationHandler:(CLLocationManager *)manage didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	if (updated) {
		return;
	}
   
   updated = YES;
   
   [locationHandler stopUpdatingLocation];
   [delegate updateLocation:newLocation];
}

						   
-(void)dealloc {
   [locationHandler release];
   [super dealloc];
}
						   
@end
