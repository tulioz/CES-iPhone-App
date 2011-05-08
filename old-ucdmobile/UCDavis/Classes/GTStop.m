//
//  GTStop.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/14/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "GTStop.h"

@implementation GTStop

@synthesize stopId;
@synthesize name;
@synthesize latitude;
@synthesize longitude;
@synthesize description;

- (void)dealloc {
	[description release];
	[name release];
	[latitude release];
	[longitude release];
	[super dealloc];
}

- (id)initWithStopId:(NSInteger)aId latitude:(NSNumber *)lat longitude:(NSNumber *)lng name:(NSString *)aName description:(NSString *)desc {
	if(self = [super init]) {
		self.stopId = aId;
		self.latitude = lat;
		self.longitude = lng;
		self.name = aName;
		self.description = desc;
	}
	return self;
}

@end