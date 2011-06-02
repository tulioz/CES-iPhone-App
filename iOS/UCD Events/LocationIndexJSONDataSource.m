//
//  LocationXMLDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationIndexJSONDataSource.h"
#import "UEFeaturedItem.h"
#import "UEFeaturedItemCell.h"

@implementation LocationIndexJSONDataSource

#pragma mark -
#pragma mark NSObject

-(id)initWithTypeId:(NSString *)typeId {
	if (self = [super init]) {
        _typeId = typeId;
		_locationFeedModel = [[LocationIndexJSONDataModel alloc] initWithTypeId:_typeId];
	}
    
	return self;
}

-(void)dealloc {
	TT_RELEASE_SAFELY(_locationFeedModel);
	
	[super dealloc];
}

#pragma mark -
#pragma mark TTSectionedDataSource

-(id<TTModel>)model {
	return _locationFeedModel;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView {
	self.items = [NSMutableArray array];
	self.sections = [NSMutableArray array];
	
	NSMutableArray *locationsFromModel = _locationFeedModel.locations;
	
//    Sort the locations by name ahead of time
	NSSortDescriptor *sortByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSArray *sortDescriptors = [NSArray arrayWithObjects: sortByName, nil];
	[locationsFromModel sortUsingDescriptors:sortDescriptors];
	
	TT_RELEASE_SAFELY(sortByName);
	
	NSMutableDictionary *categories = [NSMutableDictionary dictionary];
	
    NSMutableArray *featuredCategory = [NSMutableArray array];
    
	for (LocationItem *location in locationsFromModel) {
		NSString *categoryName = location.category;
		NSMutableArray *category = [categories objectForKey:categoryName];
		if (!category) {
			category = [NSMutableArray array];
			[categories setObject:category forKey:categoryName];
		}
		
        NSString *itemURL = [self getURLforLocationId:location.iD];
        NSLog(@"Generated URL is %@", itemURL);
		//		This is the actual creation of the location's cell item. 
        if ([location.featured isEqualToNumber:[NSNumber numberWithInt:1]]) {
            UEFeaturedItem *featuredItem = [UEFeaturedItem itemWithText:location.name
                                                               subtitle:location.address  URL:itemURL];
            [category addObject:featuredItem];
            [featuredCategory addObject:featuredItem];
        } else {
            NSLog(@"location was not featured");
            [category addObject: [TTTableSubtitleItem itemWithText:location.name
                                                     subtitle:location.address  URL:itemURL]];
        }

	}
	
//    Sort the category names then put them in array so we can query the categories dict
	NSArray *categoryNames = [categories.allKeys sortedArrayUsingSelector:
                              @selector(caseInsensitiveCompare:)];
    
//    Manually pin Featured Items to the top
    if ([featuredCategory count] != 0) {
        [_sections addObject:@"Featured"];
        [_items addObject:featuredCategory];  
    }
 
	for (NSString *currentCategory in categoryNames) {
		NSArray *items = [categories objectForKey:currentCategory];
		[_sections addObject:currentCategory];
		[_items addObject:items];
	}
}
//
//-(void)search:(NSString *)text {
//	if (text.length) {
//		_items = [[NSMutableArray alloc] init];
//		NSMutableArray *resultItems = [[NSMutableArray alloc] init];
//		NSLog(@"Reached the search!");
//		text = [text lowercaseString];
//		NSLog(@"text is: %@", text);
//		for (LocationItem *location in _locationFeedModel.locations) {
//			NSString *locationName = [location.name lowercaseString];
//			if ([locationName hasPrefix:text]) {
//				NSLog(@"Found a match with location %@", location.name);
//				TTTableSubtitleItem *newTableItem = [TTTableSubtitleItem itemWithText:location.name subtitle:location.address imageURL:location.imageURL URL:@""];
//				newTableItem.userInfo = [NSDictionary dictionaryWithObject:location forKey:@"location"];
//				newTableItem.defaultImage = [UIImage imageNamed:@"agg2x.png"];
//				[resultItems addObject:newTableItem];
//			}
//		}
//		[_items addObject:resultItems];
//		_sections = [NSArray arrayWithObject:@"Test"];
//		
//		NSLog(@"items are: %@", _items);		 
//		if ([resultItems count] == 0) {
//			[resultItems release];
//			resultItems	= nil;
//		} else {
//			resultItems = nil;
//		}
//		
//		[_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
//        
//	}
//}

-(Class)tableView:(UITableView *)tableView cellClassForObject:(id)object {
    if ([object isKindOfClass:[UEFeaturedItem class]]) {
        return [UEFeaturedItemCell class];
    } else {
        return [super tableView:tableView cellClassForObject:object];
    }
}

-(NSMutableArray *)delegates {
	if (!_delegates) {
		_delegates = TTCreateNonRetainingArray();
	}
	return _delegates;
}

#pragma mark -
#pragma mark LocationIndexDataSource

-(id)getURLforLocationId:(NSString *)locationId {
    //    NSLog(@"locationId in getURL is %@", locationId);
    return [NSString stringWithFormat:@"%@%@/%@", ucdePath, locationsString, locationId, apiDataFormat];
}

@end
