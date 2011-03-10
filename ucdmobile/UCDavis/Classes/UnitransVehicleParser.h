//
//  UnitransVehicleParser.h
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UTVehicle;

@interface UnitransVehicleParser : NSObject {
	NSURL *url;
	NSMutableArray *vehicles;
	NSInteger lastUpdateTime;
	
	NSXMLParser *xmlParser;
	
	// variables to use while we are streaming through document
	UTVehicle *currentVehicle;
	
	// skip flag to skip the current element
	Boolean skip;
}

@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSMutableArray *vehicles;
@property (nonatomic) NSInteger lastUpdateTime;

- (id)initWithURL:(NSURL *)feedUrl;

@end
