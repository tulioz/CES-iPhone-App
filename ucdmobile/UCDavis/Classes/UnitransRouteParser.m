//
//  UnitransRouteParser.m
//  UCDavis
//
//  Created by Sunny Dhillon on 12/12/09.
//  Copyright 2009 gunrockstudios.com. All rights reserved.
//

#import "UnitransRouteParser.h"
#import "UTStop.h"

@interface UnitransRouteParser ()

@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) UTStop *currentStop;
@property (nonatomic) Boolean inRoute;
@property (nonatomic) Boolean inDirection;
@property (nonatomic) Boolean inPath;

- (void)parseXMLFile;

@end


@implementation UnitransRouteParser

@synthesize url;
@synthesize tag;
@synthesize title;
@synthesize color;
@synthesize directionTitle;
@synthesize stops;
@synthesize xmlParser;
@synthesize currentStop;
@synthesize inRoute;
@synthesize inDirection;
@synthesize inPath;

- (void) dealloc {
	[url release];
	[tag release];
	[title release];
	[color release];
	[directionTitle release];
	[stops release];
	[xmlParser release];
	[currentStop release];
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
	self.stops = mutAr;
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
	
	if([elementName isEqualToString:@"route"]) {
		inRoute = YES;
		self.tag = [attributeDict objectForKey:@"tag"];
		self.title = [attributeDict objectForKey:@"title"];
		self.color = [attributeDict objectForKey:@"color"];
	} else if([elementName isEqualToString:@"direction"]) {
		inDirection = YES;
	} else if([elementName isEqualToString:@"path"]) {
		inPath = YES;
	} else if([elementName isEqualToString:@"stop"]) {
		if(inRoute && !inDirection) {
			// found a stop, store the attributes
			UTStop *newStop = [[UTStop alloc] init];
			self.currentStop = newStop;
			[newStop release];
			
			// set up stop properties
			currentStop.stopId = [[attributeDict objectForKey:@"stopId"] integerValue];
			currentStop.title = [attributeDict objectForKey:@"title"];
			currentStop.dirTag = [attributeDict objectForKey:@"dirTag"];
			currentStop.latitude = [NSNumber numberWithDouble:[[attributeDict objectForKey:@"lat"] doubleValue]];
			currentStop.longitude = [NSNumber numberWithDouble:[[attributeDict objectForKey:@"lon"] doubleValue]];
		} 
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	if([elementName isEqualToString:@"route"]) {
		inRoute = NO;
	} else if([elementName isEqualToString:@"direction"]) {
		inDirection = NO;
	} else if([elementName isEqualToString:@"path"]) {
		inPath = NO;
	} else if([elementName isEqualToString:@"stop"]) {
		if(inRoute && !inDirection) {
			[self.stops addObject:self.currentStop];
		} 
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	//NSLog(@"items array has %d items", [self.rssItems count]);
}
@end
