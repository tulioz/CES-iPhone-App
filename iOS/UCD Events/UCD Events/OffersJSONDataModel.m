//
//  OffersJSONDataModel.m
//  UCD Events
//
//  Created by William Binns-Smith on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OffersJSONDataModel.h"


@implementation OffersJSONDataModel

@synthesize offers = _offers;
@synthesize finished = _finished;
@synthesize size;

-(id)init {
    if (self = [super init]) {
        _offers = [[NSMutableArray array] retain];
        NSLog(@"OffersJSONDataModel init");
    }
    
    return self;
}

-(void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    NSLog(@"OffersJSONDataModel load");
    NSString *loadURL = [self getURL];
    
	if (!self.isLoading && TTIsStringWithAnyText(loadURL)) {
		// Create a request for the XML file passed by the init method
		TTURLRequest *request = [TTURLRequest requestWithURL:loadURL delegate:self];
        
		// Define a cacheTimeout of 7 days
		NSTimeInterval cacheTimeout = 7 * 24 * 60 * 60;
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
	TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
	
	// rootObject represents the parsed JSON feed in an array of dictionaries representing nodes
	NSArray *feed = response.rootObject;
    
	NSArray *theOffers = feed;
    
	NSMutableArray *newOffers = [[NSMutableArray alloc] init];
    
	for (NSDictionary *currentOfferDictionary in theOffers) {
        NSDictionary *currentOffer = [currentOfferDictionary objectForKey:@"offer"];
		OfferItem *offer = [[OfferItem alloc] initWithOfferDictionary:currentOffer];
		[newOffers addObject:offer];
		TT_RELEASE_SAFELY(offer);
	}
    
	_finished = TRUE;
	
	// Clear out locations just in case we've done this before
	[_offers removeAllObjects];
	[_offers addObjectsFromArray:newOffers];
    
    self.size = [_offers count];
    
	TT_RELEASE_SAFELY(newOffers);
	[super requestDidFinishLoad:request];
}

-(NSString *)getURL {
    return [NSString stringWithFormat:@"%@%@.%@", apiPath, offersString, apiDataFormat]; 
}

-(NSUInteger)count {
    return [_offers count];
}

-(void)dealloc {
    TT_RELEASE_SAFELY(_offers);
    [super dealloc];
}

@end
