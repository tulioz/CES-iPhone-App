//
//  LocationXMLDataModel.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationXMLDataModel.h"


@implementation LocationXMLDataModel

-(NSArray *)modelItems {
	return [parser locationItems];
}

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	done = NO;
	loading = YES;
	parser = [[LocationXMLParser alloc] initWithContentsOfURL:
			  [NSURL URLWithString:@"http://localhost/~william/restaurants.xml"]];
	parser.delegate = self;
	[parser parse];
}

-(BOOL)isLoaded {
	return done;
}

-(BOOL)isLoading {
	return loading;
}

-(void)locationXMLParserDidFinishParsing:(LocationXMLParser *)locationXMLParser {
	done = YES;
	loading = NO;
	[self didFinishLoad];
}

-(void)locationXMLParser:(LocationXMLParser *)locationXMLParser didFailWithError:(NSError *)error {
	done = YES;
	loading = NO;
	
	[self didFailLoadWithError:error];
}

-(void)dealloc {
	[parser release];
	[super dealloc];
}

@end
