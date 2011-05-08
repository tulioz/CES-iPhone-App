//
//  VehicleAnnotation.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "VehicleAnnotation.h"
#import "UTVehicle.h"

@implementation VehicleAnnotation

@synthesize vehicle;

- (void)dealloc {
	[vehicle release];
	[super dealloc];
}

- (id)initWithVehicle:(UTVehicle *)aVehicle {
	CLLocationCoordinate2D vehicleCoordinate;
	vehicleCoordinate.latitude = [aVehicle.latitude doubleValue];
	vehicleCoordinate.longitude = [aVehicle.longitude doubleValue];
	if(self = [super initWithCoordinate:vehicleCoordinate title:[NSString stringWithFormat:@"%@ Line", aVehicle.routeTag] subtitle:nil]) {
		self.vehicle = aVehicle;
	}
	return self;
}

@end
