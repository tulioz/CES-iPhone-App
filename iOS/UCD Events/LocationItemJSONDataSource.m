//
//  LocationItemJSONDataSource.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationItemJSONDataSource.h"

#define kWalking 0
#define kDriving 1
#define kPublicTransit 2

@implementation LocationItemJSONDataSource

#pragma mark -
#pragma mark TTURLRequestModel

-(id) initWithLocationId:(NSString *)locationId {
    if (self = [super init]) {
        _locationId = locationId;
        NSLog(@"locationID is %@", locationId);
        _locationItemDataModel = [[LocationItemJSONDataModel alloc] initWithLocationId:_locationId];
    }
    
    return self;
    
}

-(void)dealloc {
    TT_RELEASE_SAFELY(_locationItemDataModel);
    
    [super dealloc];
}

#pragma mark -
#pragma mark TTURLRequestModel

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
    
    //Basic
    NSArray *basic = [NSArray arrayWithObjects:
                      [TTTableCaptionItem itemWithText:location.name caption:@"name"],
                      [TTTableCaptionItem itemWithText:location.category caption:@"category"],
                      nil
                      ];
    // Contact
    NSArray *contact = [NSArray arrayWithObjects:
                        [TTTableCaptionItem itemWithText:[self formatPhoneString:location.phone] caption:@"phone" URL:[NSString stringWithFormat:@"tel:%@", location.phone]],
                        [TTTableCaptionItem itemWithText:location.address caption:@"address" URL:@""],
                        nil];
    
    // Description
    NSArray *description = [NSArray arrayWithObjects:
                            [TTTableLongTextItem itemWithText:location.description]
                            , nil];

    
    NSString *url = [self openGoogleMapsWithDestinationLatitude:location.latitude longitude:location.longitude];
    
    
    // Directions
    NSArray *directions = [NSArray arrayWithObjects:
                           [TTTableButton itemWithText:@"Get Directions" URL:url], nil];
    
    [self.items addObject:basic];
    [self.items addObject:contact];
    
    if (TTIsStringWithAnyText(location.description)) {
        [self.items addObject:description];
    }
    
    [self.items addObject:directions];
}

#pragma mark -
#pragma mark LocationItemDataSource

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


// open the Google Maps application with start and end locations
-(NSString *)openGoogleMapsWithDestinationLatitude:(NSString *)latitude longitude:(NSString *)longitude{
    NSString *formatString = @"http://maps.google.com/maps?daddr=%@,%@"; 
    
	NSString *url = [NSString stringWithFormat:formatString, latitude, longitude];
       
    return url;
}

@end
