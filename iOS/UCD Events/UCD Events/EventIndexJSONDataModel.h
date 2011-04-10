//
//  EventIndexJSONDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"
#import "extThree20JSON/extThree20JSON.h"
#import "EventItem.h"
#import "Three20/Three20.h"

@interface EventIndexJSONDataModel : TTURLRequestModel {
    NSMutableArray *_events;
    BOOL _finished;
}

-(NSString *)getURL;

@property (nonatomic, readonly, retain) NSMutableArray *events;
@property (nonatomic, readonly) BOOL finished;



@end
