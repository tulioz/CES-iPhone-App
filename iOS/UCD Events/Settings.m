//
//  Settings.m
//  UCD Events
//
//  Created by William Binns-Smith on 4/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

const NSString *apiPath             = @"http://74.63.241.112:3000/api/v1/";
const NSString *ucdePath            = @"ucde://";
const NSString *apiDataFormat       = @"json";
const NSString *typesString         = @"types";
const NSString *locationsString     = @"locations";
const NSString *offersString        = @"offers";
const NSString *eventsString        = @"events";

const NSString *UCDPDEmergencyPhone 		= @"5307521230";
const NSString *UCDPDNonEmergencyPhone	    = @"5307521727";
const NSString *UCDFireDepartmentPhone      = @"5307521236";
const NSString *UCDFireDepartmentAddr       = @"625 Kleiber Hall Dr, Davis, CA 95616";
const NSString *UCDFireLat					= @"38.5409453";
const NSString *UCDFireLong					= @"-121.7557253";
const NSString *SutterDHSPhone              = @"5307566440";
const NSString *SutterDHSAddr               = @"2000 Sutter Place, Davis, CA 95616";
const NSString *SutterDHSLat				= @"38.562764";
const NSString *SutterDHSLong				= @"-121.7720747";
const NSString *DavisPDPhone				= @"5307475400";
const NSString *DavisPDAddr					= @"2600 5th Street, Davis, CA 95618";
const NSString *DavisPDLat					= @"38.551843";
const NSString *DavisPDLong					= @"-121.7187756";
const NSString *DavisFirePhone				= @"5307575684";
const NSString *DavisFireAddr				= @"530 5th Street, Davis, CA 95616";
const NSString *DavisFireLat				= @"38.54684";
const NSString *DavisFireLong				= @"-121.742462";

NSString *eventsTitleString                 = @"Featured Events";

NSString *UCDButtonURL        = @"http://events.ucdavis.edu";
NSString *weatherURL          = @"http://www.accuweather.com/m/en-us/US/CA/Davis/Quick-Look.aspx";
NSString *moreEventsURL       = @"http://calendar.ucdavis.edu/";

BOOL cacheEnabled = YES;

NSTimeInterval locationIndexTimeout = 0;
NSTimeInterval locationItemTimeout = 0;
NSTimeInterval eventIndexTimeout = 0;
NSTimeInterval eventItemTimeout = 0;
NSTimeInterval offerIndexTimeout = 0;
