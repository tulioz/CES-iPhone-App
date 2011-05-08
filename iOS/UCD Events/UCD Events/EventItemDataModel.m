//
//  EventItemDataModel.m
//  UCD Events
//
//  Created by William Binns-Smith on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventItemDataModel.h"


@implementation EventItemDataModel

@synthesize eventId = _eventId;
@synthesize event = _event;

#pragma mark -
#pragma mark NSObject

-(id)initWithEventId:(NSString *)eventId {
    if (self = [super init]) {
        _eventId = eventId;
    }
    
    return self;
}

#pragma mark -
#pragma mark TTURLRequestModel

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {  
    NSString *loadURL = [self getURL];
	if (!self.isLoading && TTIsStringWithAnyText(loadURL)) {
		// Create a request for the XML file passed by the init method
		TTURLRequest *request = [TTURLRequest requestWithURL:loadURL delegate:self];
        
		// Define a cacheTimeout of 7 days
		NSTimeInterval cacheTimeout = 7 * 24 * 60 * 60;
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = cacheTimeout;
        
		// Prepare a response for the request
		TTURLJSONResponse *response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		// Send out the request
		if ([request send]) {
			NSLog(@"Loaded URL From cache");
		} else {
			NSLog(@"Loaded URL from web");
		}
	}
}

-(void)requestDidFinishLoad:(TTURLRequest *)request {
	TTURLJSONResponse *response = request.response;
    TTDASSERT([response.rootObject isKindOfClass:[NSMutableDictionary class]]);
    
	// rootObject represents the parsed JSON feed in a dictionary representing the location
	NSMutableDictionary *eventDict = response.rootObject;
    
    _event = [[EventItem alloc] initWithEventDictionary:[eventDict objectForKey:@"event"]];
    
	_finished = TRUE;
    
	// Clear out locations just in case we've done this before
	
	[super requestDidFinishLoad:request];
}

#pragma mark -
#pragma mark EventItemDataModel

-(NSString *) getURL {
    return [NSString stringWithFormat:@"%@%@/%@.%@", apiPath, eventsString, _eventId, apiDataFormat];
}

@end
