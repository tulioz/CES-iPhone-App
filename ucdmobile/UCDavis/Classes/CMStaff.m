//
//  CMStaff.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "CMStaff.h"


@implementation CMStaff

@synthesize address;
@synthesize title;
@synthesize phone;
@synthesize department;
@synthesize website;

- (id)initWithName:(NSString *)aName email:(NSString *)aEmail address:(NSString *)aAddress title:(NSString *)aTitle phone:(NSString *)aPhone department:(NSString *)dept website:(NSString *)aWebsite primaryKey:(NSInteger)primaryKey {
	if(self = [super initWithName:aName email:aEmail primaryKey:primaryKey]) {
		self.address = aAddress;
		self.title = aTitle;
		self.phone = aPhone;
		self.department = dept;
		self.website = aWebsite;

	}
	return self;
}

- (void)dealloc {
	[address release];
	[title release];
	[phone release];
	[department release];
	[website release];
	[super dealloc];
}

@end
