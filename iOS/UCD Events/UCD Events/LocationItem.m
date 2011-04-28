//
//  LocationItem.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationItem.h"


@implementation LocationItem

@synthesize iD;
@synthesize category;
@synthesize name;
@synthesize imageURL;
@synthesize address;
@synthesize city;
@synthesize country;
@synthesize phone;
@synthesize hours;
@synthesize longitude;
@synthesize latitude;
@synthesize mapsURL;
@synthesize distance;
@synthesize description;
@synthesize featured;


-(id)initWithLocationDictionary:(NSDictionary *) locationDictionary {
    if (self = [super init]) {
        self.iD = [locationDictionary objectForKey:@"id"];
        self.category = [locationDictionary objectForKey:@"category"];
        self.name = [locationDictionary objectForKey:@"name"];
        self.address = [locationDictionary objectForKey:@"address"];
        self.imageURL = [locationDictionary objectForKey:@"imageURL"];
        self.phone = [locationDictionary objectForKey:@"phone"];
        self.latitude = [locationDictionary objectForKey:@"latitude"];
        self.longitude = [locationDictionary objectForKey:@"longitude"];
        self.description = [locationDictionary objectForKey:@"description"];
        self.featured = [locationDictionary objectForKey:@"featured"];
    }
    
    return self;
}

-(void)dealloc { 
    [super dealloc];
}

@end
