//
//  EventItemDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"
#import "extThree20JSON/extThree20JSON.h"
#import "EventItem.h"
#import "Settings.h"


@interface EventItemDataModel : TTURLRequestModel {
    NSString *_eventId;
    
    EventItem *_event;
    
    BOOL _finished;
}

-(id)initWithEventId:(NSString *)eventId;
-(NSString *)getURL;

@property (nonatomic, retain, readonly) NSString *eventId;
@property (nonatomic, retain, readonly) EventItem *event;

@end
