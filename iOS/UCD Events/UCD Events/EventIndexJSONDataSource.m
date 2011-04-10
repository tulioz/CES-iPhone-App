//
//  EventIndexJSONDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventIndexJSONDataSource.h"


@implementation EventIndexJSONDataSource

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

-(id<TTModel>)model {
	return _eventFeedModel;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView {
	self.items = [NSMutableArray array];
	self.sections = [NSMutableArray array];
	
	NSMutableArray *eventsFromModel = _eventFeedModel.events;
	
	NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc] initWithKey: @"date" ascending:YES];
	NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:sortByDate, sortByName, nil];
	[eventsFromModel sortUsingDescriptors:sortDescriptors];
    
    EventItem *firstEvent = [eventsFromModel objectAtIndex:0];
    NSLog(@"Looked up event with name of %@", firstEvent.name);
	
	TT_RELEASE_SAFELY(sortByDate);
	TT_RELEASE_SAFELY(sortByName);
	
	NSMutableDictionary *sections = [NSMutableDictionary dictionary];
	
	for (EventItem *event in eventsFromModel) {
		NSDate *eventDate = event.date;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMMM YYYY"];
        NSLog(@"eventname is %@", event.name);
        NSLog(@"%@", event.date);
        NSString *sectionHeader = [dateFormatter stringFromDate:eventDate];
        if(!sectionHeader) {
            sectionHeader = @"Upcoming";
        }
        TT_RELEASE_SAFELY(dateFormatter);
		NSMutableArray *section = [sections objectForKey:sectionHeader];
		if (!section) {
			section = [NSMutableArray array];
			[sections setObject:section forKey:sectionHeader];
		}
		
        NSString *itemURL = [self getURLForEventId:event.iD];
        NSLog(@"An item's URL is %@", itemURL);
		//		This is the actual creation of the location's cell item. URL is empty as the view controller push is handled elsewhere.
		TTTableMessageItem *newTableItem = [TTTableMessageItem itemWithTitle:event.name caption:event.name text:event.description timestamp:event.date URL:itemURL];
		
		//		Bundle up the location NSObject into userInfo as a query-able dictionary.
		//		We use this in the tableviewcontroller's didSelect method to push the location to the detailviewcontroller.
		
		[section addObject:newTableItem];
	}
	
	NSArray *sectionNames = [sections.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	for (NSString *currentSection in sectionNames) {
		NSArray *items = [sections objectForKey:currentSection];
		[_sections addObject:currentSection];
		[_items addObject:items];
	}
}

-(NSString *)getURLForEventId:(NSString *)eventId {
    return [NSString stringWithFormat:@"%@%@/%@.%@", apiPath, eventsString, eventId, apiDataFormat]; 
}

@end
