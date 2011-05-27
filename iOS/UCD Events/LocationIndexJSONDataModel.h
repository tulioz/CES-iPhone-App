//
//  LocationXMLDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationItem.h"
#import "Settings.h"

#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>

@interface LocationIndexJSONDataModel : TTURLRequestModel {
	NSMutableArray *_locations; // array of locations in NSObject form
	BOOL _finished;
    NSString *_typeId;
}

-(NSString *)getURL;

@property (nonatomic, readonly) NSMutableArray *locations;
@property (nonatomic, readonly) BOOL finished;

-(id)initWithTypeId:(NSString *)typeId;

@end

