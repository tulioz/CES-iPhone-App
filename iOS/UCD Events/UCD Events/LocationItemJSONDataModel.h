//
//  LocationItemJSONDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import <extThree20JSON/extThree20JSON.h>
#import "LocationItem.h"
#import "Settings.h"

@class TTModelViewController;

@interface LocationItemJSONDataModel : TTURLRequestModel {
    NSString *_locationId;
    
    LocationItem *_location;
    
    BOOL _finished;
}

-(id) initWithLocationId:(NSString *)locationId;
-(NSString *) getURL;

@property (nonatomic, readonly) LocationItem* location;
@property (nonatomic, readonly) BOOL finished;


@end
