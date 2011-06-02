//
//  EventIndexJSONDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventIndexJSONDataSource.h"


@implementation EventIndexJSONDataSource

#pragma mark -
#pragma mark NSObject

-(id)init {
    if (self = [super init]) {
        _eventFeedModel = [[EventIndexJSONDataModel alloc] init];
    }
    
    return self;
}

-(void)dealloc {
    TT_RELEASE_SAFELY(_eventFeedModel);
    
    [super dealloc];
}

#pragma mark -
#pragma mark TTSectionedDataSource

-(id<TTModel>)model {
	return _eventFeedModel;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView {
	self.items = [NSMutableArray array];
	self.sections = [NSMutableArray array];
	
	NSMutableArray *eventsFromModel = _eventFeedModel.events;
	
	NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc] initWithKey: @"date" ascending:YES];
//	NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:sortByDate, nil];
	[eventsFromModel sortUsingDescriptors:sortDescriptors];

    if ([eventsFromModel count] == 0) {
        return;
    }
	
	TT_RELEASE_SAFELY(sortByDate);
//	TT_RELEASE_SAFELY(sortByName);
	
	NSMutableDictionary *sections = [NSMutableDictionary dictionary];
	NSMutableArray *sectionNames = [NSMutableArray array];
    
	for (EventItem *event in eventsFromModel) {
		NSDate *eventDate = event.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM YYYY"];
        
        NSLog(@"Date is %@\n", event.date);

        NSString *sectionHeader = [dateFormatter stringFromDate:eventDate];
        TT_RELEASE_SAFELY(dateFormatter);
        if(!sectionHeader) {
            sectionHeader = @"Upcoming";
        }

		NSMutableArray *section = [sections objectForKey:sectionHeader];
		if (!section) {
			section = [NSMutableArray array];
			[sections setObject:section forKey:sectionHeader];
            [sectionNames addObject:sectionHeader];
		}
		
        NSString *itemURL = [self getURLForEventId:event.iD];
        
        NSString *description = [event.description isKindOfClass:[NSNull class]] ? @" " : event.description;
        
		TTTableMessageItem *newTableItem = [TTTableMessageItem itemWithTitle:event.name caption:event.name text:description timestamp:event.date URL:itemURL];
		
		[section addObject:newTableItem];
	}
	
//    NSArray *sectionNames = [sections allKeys];
    
//	NSArray *sectionNames = [sections.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	for (NSString *currentSection in sectionNames) {
		NSArray *items = [sections objectForKey:currentSection];
		[_sections addObject:currentSection];
		[_items addObject:items];
	}
}

#pragma mark -
#pragma mark EventIndexDataSource

-(NSString *)getURLForEventId:(NSString *)eventId {
    return [NSString stringWithFormat:@"%@%@/%@", ucdePath, eventsString, eventId]; 
}

@end
