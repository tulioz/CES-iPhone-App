//
//  EventXMLDataModel.h
//  UCD Events
//
//  Created by William Binns-Smith on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "EventItem.h"
#import "LocationItem.h"

#import <Three20/Three20.h>
#import <extThree20XML/extThree20XML.h>
//#import <extThree20JSON/extThree20JSON.h>

@interface EventXMLDataModel : TTURLRequestModel {
	NSString* _myurl; // url of XML file containing events
	NSMutableArray *_events; // array of events in NSObject form
	
	BOOL _finished;
}

@property (nonatomic, copy) NSString *myurl;
@property (nonatomic, readonly) NSMutableArray *events;
@property (nonatomic, readonly) BOOL finished;

-(id)initWithMyURL:(NSString *)theURL;

@end
