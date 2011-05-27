//
//  LocationXMLDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationItem.h"

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

@interface LocationJSONDataModel : TTURLRequestModel {
	NSString* _myurl; // url of XML file containing locations
	NSMutableArray *_locations; // array of locations in NSObject form
	
	BOOL _finished;
}

@property (nonatomic, copy) NSString *myurl;
@property (nonatomic, readonly) NSMutableArray *locations;
@property (nonatomic, readonly) BOOL finished;

-(id)initWithMyURL:(NSString *)theURL;

@end
