//
//  UTPredictionManager.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UTPredictions.h"
#import "UnitransPredictionParser.h"
#import "UTPrediction.h"

#define kUnitransPredictionsURLFormat @"http://www.nextbus.com/s/xmlFeed?command=predictions&a=unitrans&stopId=%d&r=%@"

@implementation UTPredictions

@synthesize predictionDictionary;
@synthesize routeTag;
@synthesize stopId;

- (void)dealloc {
	[predictionDictionary release];
	[routeTag release];
	[super dealloc];
}

- (id)initWithRouteTag:(NSString *)aRouteTag stopId:(NSInteger)aStopId {
	if(self = [super init]) {
		self.routeTag = aRouteTag;
		self.stopId = aStopId % 1000; // stop ids are only the 3 least sign digits
		
		// start parsing
		UnitransPredictionParser *parser = [[UnitransPredictionParser alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnitransPredictionsURLFormat, stopId, routeTag]]];
		self.predictionDictionary = [NSMutableDictionary dictionary];
		[self.predictionDictionary setObject:parser.predictions forKey:self.routeTag];
		[parser release];
	}
	return self;
}

@end
