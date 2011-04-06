//
//  LocationManager.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@implementation LocationManager

static LocationManager *sharedInstance;

@synthesize locationHandler;
@synthesize lastLocation;


BOOL updated = NO;

#pragma mark singleton methods

+(LocationManager *)sharedInstance {
	@synchronized(self) {
		if (!sharedInstance) {
			sharedInstance = [[LocationManager alloc] init];
		}
	}
	return sharedInstance;
}

+(id)alloc {
	@synchronized(self) {
		NSAssert(sharedInstance == nil, @"Don't allocate a multiple instances!");
		sharedInstance = [super alloc];
	}
	return sharedInstance;
}

-(void)startUpdates {
	NSLog(@"start updates called");
	if (locationHandler == nil) {
		locationHandler = [[CLLocationManager alloc] init];
	}
						   
	locationHandler.delegate = self;
	
   locationHandler.desiredAccuracy = kCLLocationAccuracyKilometer;
   [locationHandler startUpdatingLocation];	
}

-(void)stopUpdates {
	[locationHandler stopUpdatingLocation];
}

-(BOOL) locationKnown {
	if (round(lastLocation.speed) == -1) {
		return NO;
	} else {
		return YES;
	}

}
						   
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"Location error called");
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error determining your location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
   [alert show];
   [alert release];
}

						   
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	NSLog(@"didUpdateLocation Called");

	if (abs([newLocation.timestamp timeIntervalSinceDate:[NSDate date]]) < 60 * 10) {
		self.lastLocation = newLocation;
	}
	
	NSLog(@"found location of %@!", self.lastLocation);
}
	


-(void)dealloc {
   [locationHandler release];
   [super dealloc];
}
						   
@end
