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

-(id)initWithLocationDictionary:(NSDictionary *) locationDictionary {
    self.category = [locationDictionary objectForKey:@"category"];
    self.name = [locationDictionary objectForKey:@"name"];
    self.address = [locationDictionary objectForKey:@"address"];
    self.imageURL = [locationDictionary objectForKey:@"imageURL"];
    self.phone = [locationDictionary objectForKey:@"phone"];
    self.latitude = [locationDictionary objectForKey:@"latitude"];
    self.longitude = [locationDictionary objectForKey:@"longitude"]; 
    
    return self;
}

-(void)dealloc { 
    [super dealloc];
}

@end
