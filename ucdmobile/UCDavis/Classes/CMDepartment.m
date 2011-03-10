//
//  Department.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/15/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CMDepartment.h"

@implementation CMDepartment

@synthesize pk;
@synthesize name;
@synthesize url;
@synthesize abbreviation;
@synthesize building;

- (id)initWithName:(NSString *)theName abbreviation:(NSString *)abbr departmentURL:(NSString *)deptUrl building:(CMBuilding *)theBuilding primaryKey:(NSInteger)primaryKey {
	if(self = [super init]) {
		self.name = theName;
		self.abbreviation = abbr;
		self.pk = primaryKey;
		self.url = deptUrl;
		self.building = theBuilding;
	}
	return self;
}

- (void)dealloc {
	[name release];
	[abbreviation release];
	[url release];
	[building release];
	[super dealloc];
}

@end
