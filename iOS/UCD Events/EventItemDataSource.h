//
//  EventItemDataSource.h
//  UCD Events
//
//  Created by William Binns-Smith on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "EventItemDataModel.h"

@interface EventItemDataSource : TTSectionedDataSource {
    EventItemDataModel *_eventItemDataModel;
    NSString *_eventId;
}

-(id)initWithEventId:(NSString *)eventId;
-(NSString *)getLocationURL:(NSString *)locationId;

@property (nonatomic, retain) EventItemDataModel *eventItemDataModel;
@property (nonatomic, retain) NSString *eventId;
@end
