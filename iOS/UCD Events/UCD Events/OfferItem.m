//
//  OfferItem.m
//  UCD Events
//
//  Created by William Binns-Smith on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OfferItem.h"


@implementation OfferItem

@synthesize iD;
@synthesize name;
@synthesize description;
@synthesize locationId;

-(id)initWithOfferDictionary:(NSDictionary *)offerDictionary {
    if (self = [super init]) {
        
        self.iD = (NSString *)[offerDictionary objectForKey:@"id"];
        self.name = (NSString *)[offerDictionary objectForKey:@"name"];
        self.locationId = (NSString *)[offerDictionary objectForKey:@"location_id"];
        self.description = (NSString *)[offerDictionary objectForKey:@"description"];  
    }
    
    return self;
}

-(void)dealloc { 
    [super dealloc];
}

-(NSString *)getURL {
    return [NSString stringWithFormat:@"%@%@.%@", apiPath, eventsString, apiDataFormat]; 
}

@end
