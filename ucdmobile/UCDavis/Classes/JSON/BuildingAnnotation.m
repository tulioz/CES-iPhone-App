//
//  BuildingAnnotation.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "BuildingAnnotation.h"
#import "CMBuilding.h"

@implementation BuildingAnnotation

@synthesize building;

- (id)initWithBuilding:(CMBuilding *)aBuilding {
	CLLocationCoordinate2D buildingCoordinate;
	buildingCoordinate.latitude = [aBuilding.latitude doubleValue];
	buildingCoordinate.longitude = [aBuilding.longitude doubleValue];
	if(self = [super initWithCoordinate:buildingCoordinate title:aBuilding.name subtitle:nil]) {
		self.building = aBuilding;
	}
	return self;	
}

- (void)dealloc {
	[building release];
	[super dealloc];
}

@end
