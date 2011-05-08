//
//  CMPerson.m
//  UCDavis
//
//  Created by Sunny Dhillon on 1/3/10.
//  Copyright 2010 Sunny Dhillon. All rights reserved.
//

#import "CMPerson.h"

@implementation CMPerson

@synthesize pk;
@synthesize name;
@synthesize email;

- (id)initWithName:(NSString *)aName email:(NSString *)aEmail primaryKey:(NSInteger)primaryKey {
	if(self = [super init]) {
		self.name = aName;
		self.email = aEmail;
		self.pk = primaryKey;
	}
	return self;
}

- (NSString *)firstName {
	NSRange range = [self.name rangeOfString:@" " options:NSBackwardsSearch];
	return [self.name substringToIndex:range.location];
}

- (NSString *)lastName {
	NSRange range = [self.name rangeOfString:@" " options:NSBackwardsSearch];
	return [self.name substringFromIndex:range.location + 1]; // skip the space
}

- (NSString *)lastNameInitial {
	return [[self lastName] substringToIndex:1];
}

- (void)dealloc {
	[name release];
	[email release];
	[super dealloc];
}

@end
