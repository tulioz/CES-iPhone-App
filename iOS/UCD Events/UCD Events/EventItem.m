//
//  EventItem.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventItem.h"


@implementation EventItem

@synthesize iD;
@synthesize name;
@synthesize locationId;
@synthesize website;
@synthesize date = _date;
@synthesize description;

-(id)initWithEventDictionary:(NSDictionary *)eventDictionary {
    if (self = [super init]) {
        self.iD = [eventDictionary objectForKey:@"id"];
        self.name = [eventDictionary objectForKey:@"name"];
        self.locationId = [eventDictionary objectForKey:@"location_id"];
        self.website = [eventDictionary objectForKey:@"website"];
        self.description = [eventDictionary objectForKey:@"description"];        
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:locale];
        [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];

        NSError *dateError = nil;
        if (![dateFormatter getObjectValue:&_date forString:[eventDictionary objectForKey:@"date"] range:nil error:&dateError]) {
            NSLog(@"Error parsing Date....");
        }
        [dateFormatter release];
        [locale release];
    }
    
    return self;
}

-(void)dealloc { 
    [super dealloc];
}

@end
