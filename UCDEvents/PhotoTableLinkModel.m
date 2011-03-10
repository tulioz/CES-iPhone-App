//
//  PhotoTableLinkModel.m
//  EventsAppDev
//
//  Created by William Binns-Smith on 2/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PhotoTableLinkModel.h"

@implementation PhotoTableLinkModel

@synthesize linkTitle;
@synthesize linkImage;
@synthesize linkURL;
@synthesize linkURLName;
@synthesize linkImageName;

-(id) initWithTitle:(NSString *) newTitle
			  image:(NSString *) newImageName
				URL:(NSString *) newURLName {

	self = [super init];
	if (nil != self) {
		self.linkTitle = newTitle;
		self.linkImage = [UIImage imageNamed:newImageName];
		self.linkURL = [TTURLAction actionWithURLPath:newURLName];
	}
	
	return self;
}

-(void) dealloc {
	self.linkImage = nil;
	self.linkURL = nil;
	[super dealloc];
}

@end
