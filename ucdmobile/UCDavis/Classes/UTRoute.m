//
//  UTStopManager.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UTRoute.h"
#import "UnitransRouteParser.h"

#define kUnitransRouteURLFormat @"http://www.nextbus.com/s/xmlFeed?command=routeConfig&a=unitrans&r=%@"

@implementation UTRoute

@synthesize tag;
@synthesize title;
@synthesize color;
@synthesize stops;
@synthesize directionTitle;

- (void)dealloc {
	[tag release];
	[title release];
	[color release];
	[stops release];
	[super dealloc];
}

- (id)initWithRouteTag:(NSString *)routeTag {
	if(self = [super init]) {
		self.tag = routeTag;
		
		// fetch routes
		UnitransRouteParser *parser = [[UnitransRouteParser alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnitransRouteURLFormat, self.tag]]];
		self.stops = parser.stops;
		self.title = parser.title;
		self.color = parser.color;
		self.directionTitle = parser.directionTitle;
	}
	return self;
}


@end
