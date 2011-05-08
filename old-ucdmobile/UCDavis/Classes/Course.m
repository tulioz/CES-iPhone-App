//
//  Course.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/28/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "Course.h"

@implementation Course

@synthesize pk;
@synthesize title;
@synthesize number;
@synthesize crn;
@synthesize type;
@synthesize section;
@synthesize units;
@synthesize instructor;
@synthesize seats;
@synthesize courseTimes;
@synthesize courseTextbooks;

- (void)dealloc {
	[title release];
	[number release];
	[crn release];
	[type release];
	[section release];
	[units release];
	[instructor release];
	[seats release];
	[courseTimes release];
	[courseTextbooks release];
	[super dealloc];
}

- (id)initWithTitle:(NSString *)aTitle number:(NSString *)courseNumber crn:(NSString *)aCrn type:(NSString *)aType section:(NSString *)sec units:(NSString *)numUnits instructor:(NSString*)inst seats:(NSString *)occ primaryKey:(NSInteger)primaryKey {
	if(self = [super init]) {
		self.title = aTitle;
		self.number = courseNumber;
		self.crn = aCrn;
		self.type = aType;
		self.section = sec;
		self.units = numUnits;
		self.instructor = inst;
		self.seats = occ;
		self.pk = primaryKey;
	}
	return self;
}

@end
