//
//  eventXMLDataModel.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventJSONDataModel.h"


@implementation EventJSONDataModel

@synthesize myurl = _myurl;
@synthesize events = _events;
@synthesize finished = _finished;

-(id)initWithMyURL:(NSString *)theURL {
	if (self = [super init]) {
		self.myurl = theURL;
		_events = [[NSMutableArray array] retain];
	}
	
	return self;
}

-(void) dealloc {
	TT_RELEASE_SAFELY(_myurl);
	TT_RELEASE_SAFELY(_events);
	[super dealloc];
}

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading && TTIsStringWithAnyText(_myurl)) {
		// Create a request for the XML file passed by the init method
		TTURLRequest *request = [TTURLRequest requestWithURL:self.myurl delegate:self];
	
		// Define a cacheTimeout of 7 days
		NSTimeInterval cacheTimeout = 7 * 24 * 60 * 60;
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = cacheTimeout;

		// Prepare a response for the request
		TTURLXMLResponse *response = [[TTURLXMLResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		// Send out the request
		[request send];
	}
}

-(void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLXMLResponse *response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	// rootObject represents the parsed XML feed in a dictionary of an array of dictionaries representing XML nodes
	NSDictionary *feed = response.rootObject;
	TTDASSERT([[feed objectForKey:@"events"] isKindOfClass:[NSDictionary class]]);
	
	NSArray *theevents = [feed objectForXMLNode];
	
	NSMutableArray *events = [[NSMutableArray alloc] init];

	for (NSDictionary *currentevent in theevents) {
		NSLog(@"the event dict is %@", currentevent);
		EventItem *event = [[EventItem alloc] init];
		LocationItem *eventLocation = [[LocationItem alloc] init];
		
		// Query the dictionary for each attribute and assign to the appropriate eventItem properties
		event.iD = [[currentevent objectForKey:@"id"] objectForXMLNode];
		event.type = [[currentevent objectForKey:@"type"] objectForXMLNode];
		event.name = [[currentevent objectForKey:@"name"] objectForXMLNode];
		event.imageURL = [[currentevent objectForKey:@"imageURL"] objectForXMLNode];
		event.description = [[currentevent objectForKey:@"description"] objectForXMLNode];
		event.time = [[currentevent objectForKey:@"time"] objectForXMLNode];
		
		// Interpret the string for the date as an NSDate object
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
		[dateFormatter setDateFormat:@"YYYY-MM-dd"];
		NSString *dateString = [[currentevent objectForKey:@"date"] objectForXMLNode];
		event.date = [dateFormatter dateFromString:dateString];
		
		// Interpret the location data as a LocationItem object
		NSDictionary *locationDictionary = [currentevent objectForKey:@"location"];
		
		eventLocation.iD = [[locationDictionary objectForKey:@"id"] objectForXMLNode];
		eventLocation.type = [[locationDictionary objectForKey:@"type"] objectForXMLNode];
		eventLocation.name = [[locationDictionary objectForKey:@"name"] objectForXMLNode];
		eventLocation.imageURL = [[locationDictionary objectForKey:@"imageURL"] objectForXMLNode];
		eventLocation.address = [[locationDictionary objectForKey:@"address"] objectForXMLNode];
		eventLocation.city = [[locationDictionary objectForKey:@"city"] objectForXMLNode];
		eventLocation.country = [[locationDictionary objectForKey:@"country"] objectForXMLNode];
		eventLocation.phone = [[locationDictionary objectForKey:@"phone"] objectForXMLNode];
		eventLocation.longitude = [[locationDictionary objectForKey:@"longitude"] objectForXMLNode];
		eventLocation.latitude = [[locationDictionary objectForKey:@"latitude"] objectForXMLNode];
		eventLocation.mapsURL = [[locationDictionary objectForKey:@"mapsURL"] objectForXMLNode];
		
		event.eventLocation = eventLocation;
		
		[events addObject:event];
		TT_RELEASE_SAFELY(dateFormatter);
		TT_RELEASE_SAFELY(eventLocation);
		TT_RELEASE_SAFELY(event);
	}

	_finished = TRUE;
	
	// Clear out events just in case we've done this before
	[_events removeAllObjects];
	[_events addObjectsFromArray:events];

	TT_RELEASE_SAFELY(events);
	
	[super requestDidFinishLoad:request];
}

@end
