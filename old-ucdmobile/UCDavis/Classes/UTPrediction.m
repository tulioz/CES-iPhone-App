//
//  UTPrediction.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UTPrediction.h"


@implementation UTPrediction

@synthesize seconds;
@synthesize minutes;
@synthesize epochTime;
@synthesize vehicleId;

- (void)dealloc {
	[super dealloc];
}

- (id)init {
	if(self = [super init]) {
	}
	return self;
}

@end
