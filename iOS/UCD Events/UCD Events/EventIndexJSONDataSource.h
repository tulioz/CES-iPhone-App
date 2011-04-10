//
//  EventIndexJSONDataSource.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventIndexJSONDataModel.h"
#import "Three20/Three20.h"

@interface EventIndexJSONDataSource : TTSectionedDataSource {
    EventIndexJSONDataModel *_eventFeedModel;
}

-(NSString *)getURLForEventId:(NSString *)eventId;

@end
