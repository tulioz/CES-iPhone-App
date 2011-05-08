//
//  UnitransVehicleParser.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UnitransVehicleParser.h"
#import "UTVehicle.h"

@interface UnitransVehicleParser ()

@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) UTVehicle *currentVehicle;
@property (nonatomic) Boolean skip;

- (void)parseXMLFile;

@end


@implementation UnitransVehicleParser

@synthesize url;
@synthesize vehicles;
@synthesize lastUpdateTime;
@synthesize xmlParser;
@synthesize currentVehicle;
@synthesize skip;

- (void) dealloc {
	[url release];
	[vehicles release];
	[xmlParser release];
	[currentVehicle release];
	[super dealloc];
}


- (id)initWithURL:(NSURL *)feedUrl {
	if(self = [super init]) {
		self.url = feedUrl;
		[self parseXMLFile];
	}
	return self;
}

- (void)parseXMLFile {
	NSMutableArray *mutAr = [[NSMutableArray alloc] init];
	self.vehicles = mutAr;
	[mutAr release];
	
	NSXMLParser *xmlParserWithUrl = [[NSXMLParser alloc] initWithContentsOfURL:self.url];
	self.xmlParser = xmlParserWithUrl;
	[xmlParserWithUrl release];
	
	[self.xmlParser setDelegate:self];
	
	[self.xmlParser setShouldProcessNamespaces:NO];
	[self.xmlParser setShouldReportNamespacePrefixes:NO];
	[self.xmlParser setShouldResolveExternalEntities:NO];
	
	[self.xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
	//NSLog(@"found this element: %@", elementName);
	
	if ([elementName isEqualToString:@"vehicle"]) {
		// skip if route tag is null (it is not in service)
		if([[attributeDict objectForKey:@"routeTag"] isEqualToString:@"null"]) {
			self.skip = YES;
			return;
		}
		// found a vehicle, store the attributes
		UTVehicle *newVehicle = [[UTVehicle alloc] init];
		self.currentVehicle = newVehicle;
		[newVehicle release];
		
		// set up vehicle properties
		self.currentVehicle.vehicleId = [[attributeDict objectForKey:@"id"] integerValue];
		self.currentVehicle.routeTag = [attributeDict objectForKey:@"routeTag"];
		self.currentVehicle.dirTag = [attributeDict objectForKey:@"dirTag"];
		self.currentVehicle.latitude = [NSNumber numberWithDouble:[[attributeDict objectForKey:@"lat"] doubleValue]];
		self.currentVehicle.longitude = [NSNumber numberWithDouble:[[attributeDict objectForKey:@"lon"] doubleValue]];
		self.currentVehicle.secondsSinceReport = [[attributeDict objectForKey:@"secsSinceReport"] integerValue];
		self.currentVehicle.predictable = [[attributeDict objectForKey:@"predictable"] boolValue];
		self.currentVehicle.heading = [[attributeDict objectForKey:@"heading"] integerValue];
	} else if([elementName isEqualToString:@"lastTime"]) {
		// store the current time so we know next time to poll
		self.lastUpdateTime = [[attributeDict objectForKey:@"time"] integerValue];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	//NSLog(@"ended element: %@", elementName);
	if(self.skip) {
		self.skip = NO; // reset state
		return;
	}
	if ([elementName isEqualToString:@"vehicle"]) {
		// finished item, store in vehicle item array
		[self.vehicles addObject:self.currentVehicle];
		//NSLog(@"adding item: %@", self.currentTitle);
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	//NSLog(@"items array has %d items", [self.rssItems count]);
}

@end
