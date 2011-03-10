//
//  UnitransPredictionParser.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/24/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UTPrediction;

@interface UnitransPredictionParser : NSObject {
	NSURL *url;
	
	NSString *routeTag;
	
	NSMutableArray *predictions;
	
	NSString *directionTitle;
	
	NSXMLParser *xmlParser;
	
	// variables to use while we are streaming through document
	UTPrediction *currentPrediction;
	Boolean inPredictions;
	Boolean inDirection;
	Boolean inPrediction;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSString *routeTag;
@property (nonatomic, retain) NSMutableArray *predictions;
@property (nonatomic, retain) NSString *directionTitle;

- (id)initWithURL:(NSURL *)feedUrl;

@end
