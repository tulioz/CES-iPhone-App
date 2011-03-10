//
//  CMBuilding.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/1/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "CMBuilding.h"

@implementation CMBuilding

@synthesize pk;
@synthesize name;
@synthesize latitude;
@synthesize longitude;

- (id)initWithName:(NSString *)aName latitude:(NSNumber *)aLatitude longitude:(NSNumber *)aLongitude primaryKey:(NSInteger)primaryKey {
	if(self = [super init]) {
		self.name = aName;
		self.latitude = aLatitude;
		self.longitude = aLongitude;
		self.pk = primaryKey;
	}
	return self;
}

- (void)dealloc {
	[name release];
	[latitude	release];
	[longitude release];
	[super dealloc];
}

@end
