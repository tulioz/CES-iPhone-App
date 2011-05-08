//
//  Unitrans.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UTVehicleManager.h"
#import "UnitransVehicleParser.h"
#import "UTVehicle.h"

#define kUnitransVehicleURLFormat @"http://www.nextbus.com/s/xmlFeed?command=vehicleLocations&a=unitrans&t=%d"
#define kUnitransSingleLineURLFormat @"http://www.nextbus.com/s/xmlFeed?command=vehicleLocations&a=unitrans&t=%d&r=%@"

@interface UTVehicleManager ()

@property(nonatomic, retain) NSMutableDictionary *vehicleDictionary;

@end

@implementation UTVehicleManager

@synthesize lastUpdateTime;
@synthesize routeTag;
@synthesize vehicleDictionary;

- (void)dealloc {
	[vehicleDictionary release];
	[routeTag release];
	[super dealloc];
}

- (id)init {
	if(self = [super init]) {
		self.routeTag = nil;
		// fetch the vehicles
		UnitransVehicleParser *parser = [[UnitransVehicleParser alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnitransVehicleURLFormat, 0]]];
		NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
		// store vehicles in dictionary to allow easy update
		for(UTVehicle *vehicle in parser.vehicles) {
			[mutDict setObject:vehicle forKey:[NSNumber numberWithInt:vehicle.vehicleId]];
		}
		self.vehicleDictionary = mutDict;
		self.lastUpdateTime = parser.lastUpdateTime;
		[parser release];
	}
	return self;
}

- (id)initWithRouteTag:(NSString *)route {
	if(self = [super init]) {
		self.routeTag = route;
		// fetch the vehicles
		UnitransVehicleParser *parser = [[UnitransVehicleParser alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:kUnitransSingleLineURLFormat, 0, route]]];
		NSMutableDictionary *mutDict = [[NSMutableDictionary alloc] init];
		// store vehicles in dictionary to allow easy update
		for(UTVehicle *vehicle in parser.vehicles) {
			[mutDict setObject:vehicle forKey:[NSNumber numberWithInt:vehicle.vehicleId]];
		}
		self.vehicleDictionary = mutDict;
		self.lastUpdateTime = parser.lastUpdateTime;
		[parser release];
	}
	return self;
}

- (void)updatePositions {
	// fetch the vehicles
	NSString *unitrantsUrlString = [NSString stringWithFormat:kUnitransSingleLineURLFormat, self.lastUpdateTime, self.routeTag];
	if(self.routeTag == nil) {
		unitrantsUrlString = [NSString stringWithFormat:kUnitransVehicleURLFormat, self.lastUpdateTime];
	}
	UnitransVehicleParser *parser = [[UnitransVehicleParser alloc] initWithURL:[NSURL URLWithString:unitrantsUrlString]];
	// update the vehicles
	for(UTVehicle *vehicle in parser.vehicles) {
		[self.vehicleDictionary setObject:vehicle forKey:[NSNumber numberWithInt:vehicle.vehicleId]];
	}
	// update to new update time
	self.lastUpdateTime = parser.lastUpdateTime;
	[parser release];
}

- (NSArray *)vehicles {
	return [self.vehicleDictionary allValues];
}

@end
