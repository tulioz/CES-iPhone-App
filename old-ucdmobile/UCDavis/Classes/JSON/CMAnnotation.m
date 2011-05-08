//
//  CMBuildingAnnotation.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/11/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CMAnnotation.h"

@implementation CMAnnotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id) initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString *)aTitle subtitle:(NSString *)aSubtitle {
	if(self = [super init]) {
		self.coordinate = coord;
		self.title = aTitle;
		self.subtitle = aSubtitle;
	}
	return self;	
}

- (void)dealloc {
	[title	release];
	[subtitle release];
	[super dealloc];
}


@end
