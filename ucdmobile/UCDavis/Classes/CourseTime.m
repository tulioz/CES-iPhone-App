//
//  CourseTime.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/28/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CourseTime.h"

@implementation CourseTime

@synthesize pk;
@synthesize days;
@synthesize time;
@synthesize room;
@synthesize building;
@synthesize buildingName;

- (void)dealloc {
	[days release];
	[time release];
	[room release];
	[building release];
	[buildingName release];
	[super dealloc];
}

- (id)initWithDays:(NSString *)theDays time:(NSString *)aTime buildingName:(NSString *)aBuildingName room:(NSString *)aRoom  primaryKey:(NSInteger)primaryKey {
	if(self = [super init]) {
		self.days = theDays;
		self.time = aTime;
		self.buildingName = aBuildingName;
		self.room = aRoom;
		self.pk = primaryKey;
	}
	return self;
}

@end
