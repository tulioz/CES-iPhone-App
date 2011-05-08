//
//  Class.m
//  UCDavis
//
//  Created by Sunny Dhillon on 11/20/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "CourseMetadata.h"


@implementation CourseMetadata

@synthesize pk;
@synthesize title;
@synthesize number;
@synthesize units;
@synthesize description;
@synthesize courses;

- (id)initWithTitle:(NSString *)courseTitle number:(NSString *)courseNumber primaryKey:(NSNumber *)primaryKey {
	if(self = [super init]) {
		self.title = courseTitle;
		self.number = courseNumber;
		self.pk = primaryKey;
	}
	return self;
}

- (void)dealloc {
	[title release];
	[number release];
	[units release];
	[description release];
	[courses release];
	[pk	release];
	[super dealloc];
}

@end
