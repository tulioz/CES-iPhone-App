//
//  Vehicle.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UTVehicle.h"

@implementation UTVehicle

@synthesize vehicleId;
@synthesize routeTag;
@synthesize dirTag;
@synthesize latitude;
@synthesize longitude;
@synthesize secondsSinceReport;
@synthesize predictable;
@synthesize heading;

- (void)dealloc {
	[routeTag release];
	[dirTag release];
	[latitude release];
	[longitude release];
	[super dealloc];
}

- (id)init {
	if(self = [super init]) {
	}
	return self;
}

@end
