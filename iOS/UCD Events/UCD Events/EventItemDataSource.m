//
//  EventItemDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventItemDataSource.h"


@implementation EventItemDataSource

@synthesize eventItemDataModel = _eventItemDataModel;
@synthesize eventId = _eventId;

#pragma mark -
#pragma mark NSObject

-(id)initWithEventId:(NSString *)eventId {
    if (self = [super init]) {
        _eventId = eventId;
        _eventItemDataModel = [[EventItemDataModel alloc] initWithEventId:_eventId];
    }
    
    return self;
}

-(void)dealloc {
    TT_RELEASE_SAFELY(_eventItemDataModel);
    
    [super dealloc];
}

#pragma mark -
#pragma mark TTSectionedDataSource

-(id<TTModel>)model {
    return _eventItemDataModel;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView {
    self.items = [NSMutableArray array];
    self.sections = [NSMutableArray array];
    
    EventItem *event = _eventItemDataModel.event;
    
    [self.sections addObject:@"Basic Info."];

    
    if (TTIsStringWithAnyText(event.description)) {
        [self.sections addObject:@"Description"];
    }
    
    [self.sections addObject:@"Venue Information"];
    
    //Basic
    NSArray *basic = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:event.name caption:@"name"],
                      nil
                      ];
  
    // Description
    NSArray *description = [NSArray arrayWithObjects:
                            [TTTableLongTextItem itemWithText:event.description]
                            , nil];
    
    NSArray *directions = [NSArray arrayWithObjects:
                           [TTTableButton itemWithText:@"Information and Directions" URL:[self getLocationURL:event.locationId]], nil];
    
    [self.items addObject:basic];
    
    if (TTIsStringWithAnyText(event.description)) {
        [self.items addObject:description];
    }
    
    [self.items addObject:directions];
}

#pragma mark -
#pragma mark EventItemDataSource

-(NSString *)getLocationURL:(NSString *)locationId {
    return [NSString stringWithFormat:@"%@%@/%@", ucdePath, locationsString, locationId];
}


@end
