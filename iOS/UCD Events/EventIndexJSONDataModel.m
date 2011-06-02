//
//  EventIndexJSONDataModel.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EventIndexJSONDataModel.h"


@implementation EventIndexJSONDataModel

@synthesize events = _events;
@synthesize finished = _finished;

#pragma mark -
#pragma mark NSObject

-(id)init {
    if (self = [super init]) {
        _events = [[NSMutableArray array] retain];
    }
    
    return self;
}

-(void)dealloc {
    TT_RELEASE_SAFELY(_events);
    [super dealloc];
}


#pragma mark -
#pragma mark TTURLRequestModel

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
//    NSLog(@"index load calleD");
    NSString *loadURL = [self getURL];
    
	if (!self.isLoading && TTIsStringWithAnyText(loadURL)) {
		// Create a request for the XML file passed by the init method
		TTURLRequest *request = [TTURLRequest requestWithURL:loadURL delegate:self];
        
		// Define a cacheTimeout of 7 days
		NSTimeInterval cacheTimeout = eventIndexTimeout;
        //        NSTimeInterval cacheTimeout = 1;
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
//    NSLog(@"%@", [response.rootObject class]);
	TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
	
	// rootObject represents the parsed JSON feed in an array of dictionaries representing nodes
	NSArray *feed = response.rootObject;
    
	NSArray *theEvents = feed;
    
	NSMutableArray *events = [[NSMutableArray alloc] init];
    
	for (NSDictionary *currentEventDictionary in theEvents) {
        NSDictionary *currentEvent = [currentEventDictionary objectForKey:@"event"];
		EventItem *event = [[EventItem alloc] initWithEventDictionary:currentEvent];

		[events addObject:event];
		TT_RELEASE_SAFELY(event);
	}
    
	_finished = TRUE;
	
	// Clear out locations just in case we've done this before
	[_events removeAllObjects];
    
	[_events addObjectsFromArray:events];
    
	TT_RELEASE_SAFELY(events);
	
	[super requestDidFinishLoad:request];
}

#pragma mark -
#pragma mark EventIndexDataModel

-(NSString *)getURL {
    return [NSString stringWithFormat:@"%@%@.%@", apiPath, eventsString, apiDataFormat]; 
}

@end
