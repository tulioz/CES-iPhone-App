//
//  UTStop.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UTStop.h"


@implementation UTStop

@synthesize stopId;
@synthesize title;
@synthesize dirTag;
@synthesize latitude;
@synthesize longitude;

- (void)dealloc {
	[title release];
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
