//
//  eventXMLDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventJSONDataSource.h"


@implementation EventJSONDataSource

-(id)initWithMyURL:(NSString *)theURL {
	if (self = [super init]) {
		_eventFeedModel = [[EventJSONDataModel alloc] initWithMyURL:theURL];
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
	NSMutableArray *updatedItems = [[NSMutableArray alloc] init];
	NSMutableArray *sectionNames = [[NSMutableArray alloc] init];
	
	NSMutableArray *eventsFromModel = _eventFeedModel.events;
	
	NSSortDescriptor *sortByCategory = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
	NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:sortByCategory, sortByName, nil];
	[eventsFromModel sortUsingDescriptors:sortDescriptors];
	
	TT_RELEASE_SAFELY(sortByCategory);
	TT_RELEASE_SAFELY(sortByName);
	
	BOOL first = YES;
	for (EventItem *event in eventsFromModel) {
		NSDate *eventDate = event.date;
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"MMMM YYYY"];
		NSString *theCategory = [dateFormatter stringFromDate:eventDate];
		TT_RELEASE_SAFELY(dateFormatter);
		
		// Dont bother with events that took place prior to today
		// CURRENT BUG: comparion will exclude today's events!
		NSComparisonResult compareWithToday = [event.date compare:[NSDate date]];
		if (compareWithToday == NSOrderedAscending)  {
			continue;
		}
		
		
		int eventFound = -1;
		
//		Check to see if the event's category already exist in our list of sections.
//		Only check to see if the category exists if we've done this before. First item is exempt.
		if (!first) {
			for (int i = 0; i < [sectionNames count]; i++) {
//				NSLog(@"Comparing my category %@ to sectionName %@\n", theCategory, [sectionNames objectAtIndex:i]);
				if ([theCategory isEqualToString:[sectionNames objectAtIndex:i]]) {
					eventFound = i;
				}
			}
		}
		
		NSMutableArray *categoryArray;
		
//		If we didn't find the category, add it to the list of sections and add current event to its array.
		if(eventFound == -1) {
			NSLog(@"Adding new category....");
			[sectionNames addObject:theCategory];
			NSMutableArray *newCategory = [[NSMutableArray alloc] init];
			categoryArray = newCategory;
			[updatedItems addObject:newCategory];
		} else {
//		Otherwise, add it to the array of the category we found.
			categoryArray = [updatedItems objectAtIndex:eventFound];
		}
		
//		This is the actual creation of the event's cell item. URL is empty as the view controller push is handled elsewhere.
		TTTableMessageItem *newTableItem = [TTTableMessageItem itemWithTitle:event.name caption:event.eventLocation.name text:event.description timestamp:event.date URL:@""];
//		newTableItem.imageStyle = TTSTYLE(rounded);
		
//		Bundle up the event NSObject into userInfo as a query-able dictionary.
//		We use this in the tableviewcontroller's didSelect method to push the event to the detailviewcontroller.
		newTableItem.userInfo = [NSDictionary dictionaryWithObject:event forKey:@"event"];
		
//		newTableItem.defaultImage = [UIImage imageNamed:@"agg2x.png"];
		
//		Add the cell to the list
		[categoryArray addObject:newTableItem];
		first = NO;
	}
	
	
	
//	Assign the arrays we created to the dataSource properties.
	self.items = updatedItems;
	self.sections = sectionNames;
	
	for (NSMutableArray *categoryArray in updatedItems) {
		TT_RELEASE_SAFELY(categoryArray);
	}
	
	TT_RELEASE_SAFELY(updatedItems);
	TT_RELEASE_SAFELY(sectionNames);
}

-(NSString *)titleForLoading:(BOOL)reloading {
	return @"Loading...";
}

-(NSString *)titleForEmpty {
	return @"There are no upcoming events.";
}

-(NSString *)subtitleForEmpty {
	return @"Please check again later.";
}

-(NSString *)titleForError:(NSError *)error {
	return @"There was an error!";
}

-(NSString *)subtitleForError:(NSError *)error {
	return @"Please try again later. Error!";
}


@end
