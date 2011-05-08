//
//  MyAnnotation.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/5/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize coordinate;

- (NSString *)subtitle{
	return @"Sub Title";
}

- (NSString *)title{
	return @"Title";
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end
