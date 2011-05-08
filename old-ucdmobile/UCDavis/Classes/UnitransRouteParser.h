//
//  UnitransRouteParser.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UTStop;

@interface UnitransRouteParser : NSObject {
	NSURL *url;
	
	NSString *tag;
	NSString *title;
	NSString *color;
	
	NSMutableArray *stops;
	
	NSString *directionTitle;
	
	NSXMLParser *xmlParser;
	
	// variables to use while we are streaming through document
	UTStop *currentStop;
	Boolean inRoute;
	Boolean inDirection;
	Boolean inPath;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *tag;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *color;
@property (nonatomic, retain) NSMutableArray *stops;
@property (nonatomic, retain) NSString *directionTitle;

- (id)initWithURL:(NSURL *)feedUrl;

@end
