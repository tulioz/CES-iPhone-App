//
//  GTRoute.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/14/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "GTRoute.h"

@implementation GTRoute

@synthesize routeId;
@synthesize longName;

- (id)initWithRouteId:(NSString *)aId longName:(NSString *)ln {
	if(self = [super init]) {
		self.routeId = aId;
		self.longName = ln;
	}
	return self;
}

- (void)dealloc {
	[routeId release];
	[longName release];
	[super dealloc];
}

@end
