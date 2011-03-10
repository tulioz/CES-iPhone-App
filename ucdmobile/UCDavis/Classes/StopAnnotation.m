//
//  StopAnnotation.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/13/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "StopAnnotation.h"
#import "GTStop.h"

@implementation StopAnnotation

@synthesize stop;

- (id)initWithStop:(GTStop *)theStop {
	CLLocationCoordinate2D stopCoordinate;
	stopCoordinate.latitude = [theStop.latitude doubleValue];
	stopCoordinate.longitude = [theStop.longitude doubleValue];
	if(self = [super initWithCoordinate:stopCoordinate title:theStop.name subtitle:theStop.description]) {
		self.stop = theStop;
	}
	return self;	
}

- (void)dealloc {
	[stop release];
	[super dealloc];
}

@end
