//
//  GTCalendar.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/12/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "GTCalendar.h"

@implementation GTCalendar

@synthesize serviceId;
@synthesize startDate;
@synthesize endDate;
/*
@synthesize monday;
@synthesize tuesday;
@synthesize wednesday;
@synthesize thursday;
@synthesize friday;
@synthesize saturday;
@synthesize sunday;*/

- (id)initWithServiceId:(NSString *)aServiceId startDate:(NSDate *)aStartDate endDate:(NSDate *)aEndDate {
	if(self = [super init]) {
		self.serviceId = aServiceId;
		self.startDate = aStartDate;
		self.endDate = aEndDate;	
	}
	return self;
}

- (void)dealloc {
	[serviceId release];
	[startDate release];
	[endDate release];
	[super dealloc];
}

@end
