//
//  CMStudent.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "CMStudent.h"


@implementation CMStudent

@synthesize studentLevel;
@synthesize major;

- (id)initWithName:(NSString *)aName email:(NSString *)aEmail studentLevel:(NSString *)aStudentLevel major:(NSString *)aMajor primaryKey:(NSInteger)primaryKey {
	if(self = [super initWithName:aName email:aEmail primaryKey:primaryKey]) {
		self.studentLevel = aStudentLevel;
		self.major = aMajor;
	}
	return self;
}

- (void)dealloc {
	[studentLevel release];
	[major release];
	[super dealloc];
}

@end
