//
//  CMCollege.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/14/09.
//  Copyright 2009 Sunny Dhillon. All rights reserved.
//

#import "CMCollege.h"

@implementation CMCollege

@synthesize pk;
@synthesize name;

- (id)initWithName:(NSString *)theName primaryKey:(NSInteger)primaryKey {
	if(self = [super init]) {
		self.name = theName;
		self.pk = primaryKey;
	}
	return self;
}

- (void)dealloc {
	[name release];
	[super dealloc];
}

@end
