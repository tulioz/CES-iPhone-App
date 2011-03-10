//
//  LocationXMLDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationXMLDataSource.h"


@implementation LocationXMLDataSource

-(id)init {
	if (self = [super init]) {
		dataModel = [[LocationXMLDataModel alloc] init];
	}
	
	return self;
}

-(void)dealloc {
	[dataModel release];
	[super dealloc];
}

-(id<TTModel>)model {
	return dataModel;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView {
	NSArray *modelItems = [dataModel modelItems];
	if (modelItems == nil) {
		NSLog(@"ModelItems is NIL!!!");
	}


	NSMutableArray *updatedItems = [[NSMutableArray alloc] init];
	NSMutableArray *sectionNames = [[NSMutableArray alloc] init];
	
	BOOL first = YES;
	for (LocationItem *location in modelItems) {
		NSString *theCategory = location.type;
		int locationFound = -1;
		
		if (!first) {
			NSLog(@"Entering nonfirst...");
			for (int i = 0; i < [sectionNames count]; i++) {
				NSLog(@"Comparing my category %@ to sectionName %@\n", theCategory, [sectionNames objectAtIndex:i]);
				if ([theCategory isEqualToString:[sectionNames objectAtIndex:i]]) {
					locationFound = i;
				}
			}
		}
		
		NSMutableArray *categoryArray;
		if(locationFound == -1) {
			NSLog(@"Adding new category....");
			[sectionNames addObject:theCategory];
			NSMutableArray *newCategory = [[NSMutableArray alloc] init];
			categoryArray = newCategory;
			[updatedItems addObject:newCategory];
		} else {
			categoryArray = [updatedItems objectAtIndex:locationFound];
		}
		
		NSMutableString *theURL = [NSMutableString stringWithString:@"ucde://locationDetail/"];
		[theURL appendString:[location.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		[theURL appendString:@"/"];
		[theURL appendString:[location.type stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		[theURL appendString:@"/"];
		[theURL appendString:[location.imageURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		[theURL appendString:@"/"];
		[theURL appendString:[location.address stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		[theURL appendString:@"/"];
		[theURL appendString:[location.phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		[theURL appendString:@"/"];
		
		NSLog(@"URL string is: %@", theURL);
		
		TTTableImageItem *newTableItem = [TTTableImageItem itemWithText:location.name imageURL:location.imageURL URL:theURL];
		
		[categoryArray addObject:newTableItem];
		first = NO;
	}
	
	
	self.items = updatedItems;
	self.sections = sectionNames;
}

-(NSString *)titleForLoading:(BOOL)reloading {
	return @"Loading...";
}

-(NSString *)titleForEmpty {
	return @"Please try again later. Empty!";
}

-(NSString *)titleForError:(NSError *)error {
	return @"There was an error!";
}

-(NSString *)subtitleForError:(NSError *)error {
	return @"Please try again later. Error!";
}

@end
