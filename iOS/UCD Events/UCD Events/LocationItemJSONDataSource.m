//
//  LocationItemJSONDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationItemJSONDataSource.h"


@implementation LocationItemJSONDataSource

-(id) initWithTypeId:(NSString *)typeId locationId:(NSString *)locationId {
    if (self = [super init]) {
        _typeId = typeId;
        _locationId = locationId;
        _locationItemDataModel = [[LocationItemJSONDataModel alloc] initWithTypeId:_typeId locationId:_locationId];
    }
    
    return self;
    
}

-(void)dealloc {
    TT_RELEASE_SAFELY(_locationItemDataModel);
    
    [super dealloc];
}

-(id<TTModel>)model {
    return _locationItemDataModel;
}

-(void)tableViewDidLoadModel:(UITableView *)tableView {
    self.items = [NSMutableArray array];
    self.sections = [NSMutableArray array];
    
    LocationItem *location = _locationItemDataModel.location;
    
    [self.sections addObject:@"Basic Info."];
    [self.sections addObject:@"Contact"];
    
    if (TTIsStringWithAnyText(location.description)) {
        [self.sections addObject:@"Description"];
    }
    
    [self.sections addObject:@"Directions"];
    
    NSLog(@"Location's name is %@", location.name);
    
    //Basic
    NSArray *basic = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:location.name caption:@"name"],
                      [TTTableCaptionItem itemWithText:location.category caption:@"category"],
                      nil
                      ];
    // Contact
    NSArray *contact = [NSArray arrayWithObjects:
                        [TTTableCaptionItem itemWithText:[self formatPhoneString:location.phone] caption:@"phone" URL:[NSString stringWithFormat:@"tel://%@", location.phone]],
                        [TTTableCaptionItem itemWithText:location.address caption:@"address" URL:@""],
                        nil];
    
    // Description
    NSLog(@"%@", location.description);
    NSArray *description = [NSArray arrayWithObjects:
                            [TTTableLongTextItem itemWithText:location.description]
                            , nil];
    
    NSArray *directions = [NSArray arrayWithObjects:
                           [TTTableButton itemWithText:@"Get Directions" URL:@""], nil];
    
    [self.items addObject:basic];
    [self.items addObject:contact];
    
    if (TTIsStringWithAnyText(location.description)) {
        [self.items addObject:description];
    }
    
    [self.items addObject:directions];
}

-(NSString *) formatPhoneString:(NSString *) rawString {
    //	http://www.iphonesdkarticles.com/2008/11/localizating-iphone-apps-custom.html
	NSRange range;
	range.length = 3;
	range.location = 3;
	
	NSString *areaCode = [rawString substringToIndex:3];
	NSString *phonePart1 = [rawString substringWithRange:range];
	NSString *phonePart2 = [rawString substringFromIndex:6];
	
	return [NSString stringWithFormat:@"+1 (%@) %@-%@", areaCode, phonePart1, phonePart2];		
}

@end
