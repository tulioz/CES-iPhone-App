//
//  WebServiceAdapter.m
//  UCDavis
//
//  Created by Sunny Dhillon on 10/14/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "WebServiceAdapter.h"
#import "RssParser.h"

//#define kHostname @"localhost:8000"
#define kHostname @"pc60.cs.ucdavis.edu:8000"

@implementation WebServiceAdapter

/**
 * Fetch RSS Feeds
 */
+ (NSArray *)fetchFeedByUrl:(NSURL *)feedURL {
	RssParser *rssParser = [[RssParser alloc] initWithURL:feedURL];
	NSArray *stories = rssParser.rssItems;
	[stories retain];
	[rssParser release];
	return stories;
}

@end
