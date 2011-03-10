//
//  LocationXMLDataModel.m
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationJSONDataModel.h"


@implementation LocationJSONDataModel

@synthesize myurl = _myurl;
@synthesize locations = _locations;
@synthesize finished = _finished;

-(id)initWithMyURL:(NSString *)theURL {
	if (self = [super init]) {
		self.myurl = theURL;
		_locations = [[NSMutableArray array] retain];
	}
	
	return self;
}

-(void) dealloc {
	TT_RELEASE_SAFELY(_myurl);
	TT_RELEASE_SAFELY(_locations);
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
		TTURLJSONResponse *response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		// Send out the request
		[request send];
	}
}

-(void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLJSONResponse *response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	
	// rootObject represents the parsed JSON feed in a dictionary of an array of dictionaries representing XML nodes
	NSDictionary *feed = response.rootObject;
	TTDASSERT([[feed objectForKey:@"locations"] isKindOfClass:[NSArray class]]);
//	TTDASSERT([[feed objectForKey:@"locations"] isKindOfClass:[NSDictionary class]]);
	
	NSArray *theLocations = [feed objectForKey:@"locations"];

//	NSLog(@"locations array is %@", theLocations);
	
	NSMutableArray *locations = [[NSMutableArray alloc] init];

	for (NSDictionary *currentLocationDictionary in theLocations) {
		LocationItem *location = [[LocationItem alloc] init];
		
		NSDictionary *currentLocation = [currentLocationDictionary objectForKey:@"location"];
		
//		NSLog(@"id is %@", [currentLocation objectForKey:@"id"]);
		if ((location.iD = [currentLocation objectForKey:@"id"]) == @"<null>") {
			location.iD = @"";
		}
		location.type = [currentLocation objectForKey:@"type"];
		location.name = [currentLocation objectForKey:@"name"];
		location.imageURL = [currentLocation objectForKey:@"imageURL"];
//		NSLog(@"location's imageURL is ", [location.imageURL class]);
//		if (location.imageURL == nil) {
//			location.imageURL = @"";
//		}
		location.phone = [currentLocation objectForKey:@"phone"];
		
		// Query the dictionary for each attribute and assign to the appropriate LocationItem properties
/*		location.iD = [[currentLocation objectForKey:@"id"] objectForXMLNode];
		location.type = [[currentLocation objectForKey:@"type"] objectForXMLNode];
		location.name = [[currentLocation objectForKey:@"name"] objectForXMLNode];
		location.imageURL = [[currentLocation objectForKey:@"imageURL"] objectForXMLNode];
		location.address = [[currentLocation objectForKey:@"address"] objectForXMLNode];
		location.city = [[currentLocation objectForKey:@"city"] objectForXMLNode];
		location.country = [[currentLocation objectForKey:@"country"] objectForXMLNode];
		location.phone = [[currentLocation objectForKey:@"phone"] objectForXMLNode];
		location.longitude = [[currentLocation objectForKey:@"longitude"] objectForXMLNode];
		location.latitude = [[currentLocation objectForKey:@"latitude"] objectForXMLNode];
		location.mapsURL = [[currentLocation objectForKey:@"mapsURL"] objectForXMLNode];
*/		
		[locations addObject:location];
		TT_RELEASE_SAFELY(location);
	}

	_finished = TRUE;
	
	// Clear out locations just in case we've done this before
	[_locations removeAllObjects];
	[_locations addObjectsFromArray:locations];

	TT_RELEASE_SAFELY(locations);
	
	[super requestDidFinishLoad:request];
}

@end
