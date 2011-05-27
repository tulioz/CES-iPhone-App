//
//  LocationXMLDataSource.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationIndexJSONDataModel.h"
#import "LocationItem.h"
#import "Settings.h"
#import <Three20Core/NSDateAdditions.h>


@interface LocationIndexJSONDataSource : TTSectionedDataSource {
	LocationIndexJSONDataModel *_locationFeedModel;
    NSString *_typeId;
    
	NSMutableArray *_allItems;
	NSMutableArray* _delegates;
}

-(id)initWithTypeId:(NSString *)typeId;
-(id)getURLforLocationId:(NSString *)locationId;

@end
