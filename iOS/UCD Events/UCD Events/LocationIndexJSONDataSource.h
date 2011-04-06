//
//  LocationXMLDataSource.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "LocationIndexJSONDataModel.h"
#import "LocationItem.h"

#import <Three20Core/NSDateAdditions.h>


@interface LocationIndexJSONDataSource : TTSectionedDataSource {
	LocationIndexJSONDataModel *_locationFeedModel;
	NSMutableArray *_allItems;
	NSMutableArray* _delegates;
}

-(id)initWithMyURL:(NSString *)theURL;

@end
